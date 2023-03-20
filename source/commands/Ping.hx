package commands;

import hxdiscord.types.structTypes.Embed;
import bot.BaseCommand;
import hxdiscord.types.*;

class Ping extends BaseCommand {
    override function init() {
        name = "ping";
        description = "Returns the ping of the bot.";
    }

    @async override function run(m:Interaction) {
        var embed:Embed = {
            title: ":ping_pong: Ping!",
            description: 'Pinging...',
            color: Main.getEmbedColor()
        };

        var before:Float = Sys.time();
        @await m.reply({embeds: [embed]});
        var ping:Float = (Sys.time() - before) * 1000;

        embed.description = 'Current ping is ${Math.round(ping)}ms!';
        
        @:privateAccess
        @await m.edit({
            embeds: [embed]
        });
    }
}