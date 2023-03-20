package bot;

import hxdiscord.types.*;

class BaseCommand {
    public var name:String = "";

    public function new() {}
    public function init() {}
    @async public function run(m:Message, arguments:Array<String>) {}
}