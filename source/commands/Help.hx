package commands;

import hxdiscord.types.structTypes.Embed;
import bot.BaseCommand;
import hxdiscord.types.*;

class Help extends BaseCommand {
    override function init() {
        name = "help";
    }

    @async override function run(m:Message, arguments:Array<String>) {
        
    }
}