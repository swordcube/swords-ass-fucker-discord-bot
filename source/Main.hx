package;

import bot.BaseCommand;
import haxe.Json;
import bot.SettingsData;
import sys.io.File;
import hxdiscord.DiscordClient;
import hxdiscord.utils.Intents;
import hxdiscord.types.*;

class Main {
	public static var settings:SettingsData;
	public static var bot:DiscordClient;

	public static var commands:Map<String, BaseCommand> = [];
	public static var commandsArray:Array<BaseCommand> = [];

	static function main() {
		settings = Json.parse(File.getContent("../../config/settings.json"));

		bot = new DiscordClient(File.getContent("../../config/token.txt"), [Intents.ALL], false);
		bot.onReady = onReady;
		bot.onMessageCreate = onMessageCreate;
		
		addCommand(new commands.Ping());
		addCommand(new commands.Ping());
	}

	public static function onReady() {
		Sys.println('sword\'s ass fucker - v${settings.version} has loaded with prefix of: ${settings.prefix}!');
	}

	public static function onMessageCreate(m:Message) {
		try {
			// Run commands
			for(command in commands) {
				if(m.content.startsWith(settings.prefix + command.name)) {
					var args:Array<String> = m.content.trim().split(" ");
					args.shift();
					command.run(m, args);
					return;
				}
			}
		} catch(e) {
			Sys.println("Something went wrong registering a message! The bot might be rate limited!");
		}
	}

	public static function addCommand<T:BaseCommand>(instance:T) {
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
	}
}