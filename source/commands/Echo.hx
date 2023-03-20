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
            author: {
                name: '${m.member.user.username}#${m.member.user.discriminator}',
                icon_url: Main.generateAvatarURL(m.member.user.id, m.member.user.avatar)
            },
            description: m.getValue("message"),
            color: Main.getEmbedColor()
        };

        m.reply({embeds: [embed]});
    }
}