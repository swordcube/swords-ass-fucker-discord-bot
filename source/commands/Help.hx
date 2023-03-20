package commands;

import hxdiscord.types.structTypes.Embed;
import bot.BaseCommand;
import hxdiscord.types.*;

class Help extends BaseCommand {
    override function init() {
        name = "help";
        description = "Gives you a list of every command available.";
    }

    @async override function run(m:Interaction) {
        var formattedCommands:String = "";

        for(command in Main.commandsArray)
            formattedCommands += '**${command.name}** - ${command.description}\n';

        var embed:Embed = {
            title: "Help",
            description: 'Here is a list of every command available.\n\n$formattedCommands',
            color: Main.getEmbedColor(),
            footer: {
                text: 'Made by Sword#9137',
                icon_url: "https://cdn.discordapp.com/avatars/1087023438645960794/04f0fcbeae810019fe5337af9f16b0de.webp?size=128"
            }
        };

        m.reply({embeds: [embed]});
    }
}