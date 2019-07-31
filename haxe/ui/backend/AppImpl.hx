package haxe.ui.backend;

import haxe.ui.backend.android.MainActivity;

@:keep
class AppImpl extends AppBase {
    public function new() {
    }
    
    private override function getToolkitInit():ToolkitOptions {
        return {
            context: MainActivity.context,
            contentView: MainActivity.contentView
        };
    }
}
