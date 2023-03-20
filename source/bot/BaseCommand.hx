package bot;

import hxdiscord.types.*;

class BaseCommand {
    public var name:String = "No name";
    public var description:String = "No description";

    public function new() {}
    public function init() {}
    @async public function run(m:Interaction) {}
}