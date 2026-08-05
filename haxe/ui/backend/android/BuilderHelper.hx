package haxe.ui.backend.android;

import haxe.macro.Expr;
import haxe.macro.Compiler;

class BuilderHelper {
    macro static public function build():Expr {
        var args = Sys.args();
        var mainIndex = args.indexOf("-main");
        if (mainIndex != -1 && mainIndex + 1 < args.length) {
            Compiler.define("haxe.ui.backend.android.main", args[mainIndex + 1]);
        }

        return null;
    }
}