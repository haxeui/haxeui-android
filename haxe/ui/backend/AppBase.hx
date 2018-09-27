package haxe.ui.backend;

import haxe.ui.Preloader.PreloadItem;
import haxe.ui.backend.android.MainActivity;
import haxe.ui.core.Screen;

@:keep
class AppBase {
    private var _onReady:Void->Void;
    
    public function new() {
    }
    
    private function build() {

    }

    private function init(onReady:Void->Void, onEnd:Void->Void = null) {
        _onReady = onReady;
        onReady();
    }

    private function getToolkitInit():Dynamic {
        return {
            context: MainActivity.context,
            contentView: MainActivity.contentView
        };
    }
    
    public function start() {
        for (c in Screen.instance.rootComponents) {
            //c.ready();
        }
    }
    
    private function buildPreloadList():Array<PreloadItem> {
        return [];
    }
}
