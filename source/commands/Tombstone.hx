package commands;

import hxdiscord.types.structTypes.Embed;
import bot.BaseCommand;
import hxdiscord.types.*;

class Tombstone extends BaseCommand {
    override function init() {
        name = "tombstone";
        description = "Returns a tombstone with words of your choice.";
    }

    @async override function run(m:Interaction) {
        var curYear:String = Std.string(Date.now().getFullYear());
        var embed:Embed = {
            title: ":headstone: Here's your generated tombstone!",
            image: {
                url: 'http://www.tombstonebuilder.com/generate.php?top1=R.I.P&top2=&top3=${cast(m.getValue("person"), String).replace("-", "+")}&top4=${(m.getValue("deathYear") != null) ? m.getValue("deathYear") : curYear}+-+${curYear}&sp='.replace(" ", "+")
            },
            color: Main.getEmbedColor()
        };
        @await m.reply({embeds: [embed]});
    }
}