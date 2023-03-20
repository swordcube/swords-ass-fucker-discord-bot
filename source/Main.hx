package;

import hxdiscord.types.structTypes.ApplicationCommand.ApplicationCommandOption;
import bot.BaseCommand;
import haxe.Json;
import bot.SettingsData;
import sys.io.File;
import hxdiscord.DiscordClient;
import hxdiscord.utils.Intents;
import hxdiscord.types.*;

class Main {
	/**
	 * The settings data from `config/settings.json`.
	 */
	public static var settings:SettingsData;

	/**
	 * The thing that is responsible for sending, editing, deleting messages/embeds
	 * 
	 * and whatever else you want basically!
	 */
	public static var bot:DiscordClient;

	/**
	 * An unordered list of every command.
	 * Use this to run the commands!
	 */
	public static var commands:Map<String, BaseCommand> = [];

	/**
	 * An ordered list of every command.
	 * Use this to make pretty lists of commands!
	 */
	public static var commandsArray:Array<BaseCommand> = [];

	static var __appCommands:Array<Dynamic> = [];

	/**
	 * Initializes the commands for the bot
	 * and allows users to run them.
	 */
	public static inline function initCommands() {
		addCommand(new commands.Help());
		addCommand(new commands.Ping());
		addCommand(new commands.Echo(), [
			{
				type: CommandType.STRING,
				name: "message",
				description: "The message to repeat/echo.",
				required: true
			}
		]);
		addCommand(new commands.Tombstone(), [
			{
				type: CommandType.STRING,
				name: "person",
				description: "The person/object who died.",
				required: true
			},
			{
				type: CommandType.STRING,
				name: "deathYear",
				description: "The year the person/object died.",
				required: false
			}
		]);
	}

	/**
	 * Returns the default embed color for embed messages.
	 */
	public static inline function getEmbedColor() {
		return Std.parseInt("0x"+settings.embedColor.replace("0x", "").replace("#", ""));
	}

	public static inline function generateAvatarURL(userID:String, avatarID:String, ?size:Int = 128) {
		return 'https://cdn.discordapp.com/avatars/$userID/$avatarID.webp?size=$size';
	}

	// ---- SHIT YOU SHOULDN'T HAVE TO WORRY ABOUT ----

	static function main() {
		settings = Json.parse(File.getContent("../../config/settings.json"));

		bot = new DiscordClient(File.getContent("../../config/token.txt"), [Intents.ALL], false);
		bot.onReady = onReady;
		bot.onInteractionCreate = (m:Interaction) -> {
			try {
				runCommand(commands.get(m.name), m);
			} catch(e) {
				Sys.println('Something went wrong registering a message! The bot might be rate limited!\nHere\'s the error message: ${e.toString()}');
			}
		};
	}

	public static function onReady() {
		Sys.println('sword\'s ass fucker - v${settings.version} has loaded!');
		bot.changeStatus("dnd", "listening", 'my nuts explode', false);

		initCommands();
		bot.setInteractionCommands(__appCommands);
	}

	public static inline function runCommand<T:BaseCommand>(command:T, message:Interaction) {
		command.run(message);
	}

	public static function addCommand<T:BaseCommand>(instance:T, ?options:Array<ApplicationCommandOption>) {
		if(options == null) options = [];

		if(instance == null) {
			Sys.println('The command you tried to add is null!');
			return;
		}

		instance.init();

		if(commands.exists(instance.name) && commands.get(instance.name) != null) {
			Sys.println('Command of name: ${instance.name} was already added!');
			return;
		}

		commands.set(instance.name, instance);
		commandsArray.push(instance);

		var appCommand = new ApplicationCommand();
		appCommand.setName(instance.name);
		appCommand.setDescription(instance.description);
		for(o in options)
			appCommand.addOption(o);

		__appCommands.push(appCommand);

		Sys.println('Loaded ${instance.name} command successfully!');
	}
}