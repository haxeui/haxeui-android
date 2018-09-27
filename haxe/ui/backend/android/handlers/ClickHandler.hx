package haxe.ui.backend.android.handlers;

import android.view.View;
import android.view.View.View_OnClickListener;

class ClickHandler implements View_OnClickListener {
    private var _fn:View->Void;
    
    public function new(fn:View->Void) {
        _fn = fn;
    }
    
    public function onClick(v:View) {
        _fn(v);
    }
}
