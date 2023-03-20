package commands;

import hxdiscord.types.structTypes.Embed;
import bot.BaseCommand;
import hxdiscord.types.*;

class Echo extends BaseCommand {
    override function init() {
        name = "echo";
        description = "Repeats whatever you say back to you.";
    }

    @async override function run(m:Interaction) {
        var embed:Embed = {
            title: m.user.discriminator,
            description: m.getValue("message"),
            color: Main.getEmbedColor()
        };

        m.reply({embeds: [embed]});
    }
}