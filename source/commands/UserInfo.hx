package commands;

import haxe.DateUtils;
import DateTools;
import hxdiscord.endpoints.Endpoints;
import hxdiscord.types.structTypes.Embed;
import bot.BaseCommand;
import hxdiscord.types.*;

class UserInfo extends BaseCommand {
    override function init() {
        name = "userinfo";
        description = "Gets the info of a specific user.";
    }

    @async override function run(m:Interaction) {
        var userID:String = (m.getValue("user") != null) ? m.getValue("user") : m.member.user.id;
        var user:User = Endpoints.getUser(userID);
        var member:Member = Endpoints.getGuildMember(m.guild_id, userID);

        var embed:Embed = {
            author: {
                name: 'Info for ${user.username}#${user.discriminator}',
                icon_url: Main.generateAvatarURL(user.id, user.avatar)
            },
            // doing == true here because um
            // doing null checks is kinda dumb tbh
            description: '
            User ID: ${user.id}
            Display Name: ${(member.nick != null) ? member.nick : user.username}
            Verified: ${user.verified == true}
            Is Bot: ${user.bot == true}
            Joined At: ${DateUtils.fromISO8601(member.joined_at).toString()}
            Created At: Not Implemented
            Pending Member: ${member.pending == true}
            ',
            color: Main.getEmbedColor()
        };

        m.reply({embeds: [embed]});
    }
}