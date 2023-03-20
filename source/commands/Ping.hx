package commands;

import hxdiscord.types.structTypes.Embed;
import bot.BaseCommand;
import hxdiscord.types.*;

class Ping extends BaseCommand {
    override function init() {
        name = "ping";
    }

    @async override function run(m:Message, arguments:Array<String>) {
        var embed:Embed = {
            title: ":ping_pong: Ping!",
            description: 'Pinging...',
            color: 0x5b7fdd
        };

        var before:Float = Sys.time();
        @await m.reply({embeds: [embed]});
        var ping:Float = (Sys.time() - before) * 1000;

        embed.description = 'Current ping is ${Math.round(ping)}ms!';
        
        @:privateAccess
        @await m.editMessage({
            embeds: [embed]
        });
    }
}