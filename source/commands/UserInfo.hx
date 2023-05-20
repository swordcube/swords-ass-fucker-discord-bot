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
        var member:Member = null;
        Endpoints.getGuildMember(m.guild_id, userID, (m) -> member = m, (e) -> trace(e));

        var joinedAt:Date = DateUtils.fromISO8601(member.joined_at);

        var embed:Embed = {
            author: {
                name: 'Info for ${user.username}#${user.discriminator}',
                icon_url: Main.generateAvatarURL(user.id, user.avatar)
            },
            fields: [
                {
                    name: "ID",
                    value: user.id
                },
                {
                    name: "Nickname",
                    value: (member.nick != null) ? member.nick : user.username
                },
                {
                    name: "Verified",
                    value: Std.string(user.verified == true)
                },
                {
                    name: "Is Bot",
                    value: Std.string(user.bot == true)
                },
                {
                    name: "Is Pending",
                    value: Std.string(member.pending == true)
                },
                {
                    name: "Joined At",
                    value: DateTools.format(joinedAt, "%m/%d/%Y %r")
                }
            ],
            color: Main.getEmbedColor()
        };

        m.reply({embeds: [embed]});
    }
}