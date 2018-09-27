package haxe.ui.backend.android.wrappers;

import android.view.View;

class HaxeUIView extends View {
    @:overload
    public override function onAttachedToWindow() {
        trace("---------------------------------------------------------------- onAttachedToWindow");
    }
}