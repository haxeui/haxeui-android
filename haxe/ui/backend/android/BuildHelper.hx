package haxe.ui.backend.android;

import haxe.macro.Expr;
import haxe.macro.Compiler;
import haxe.macro.Context;

class BuilderHelper {
    macro static public function build():Expr {
        var main:String = Sys.args()[Sys.args().indexOf("-main") + 1];
        Compiler.define("haxe.ui.backend.android.main", main);

        return null;
    }
}