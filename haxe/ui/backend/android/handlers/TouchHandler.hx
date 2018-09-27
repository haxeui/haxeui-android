package haxe.ui.backend.android.handlers;

import android.view.View;
import android.view.View.View_OnTouchListener;
import android.view.MotionEvent;

class TouchHandler implements View_OnTouchListener {
    private var _fn:View->MotionEvent->Void;
    
    public function new(fn:View->MotionEvent->Void) {
        _fn = fn;
    }
    
    public function onTouch(v:View, event:MotionEvent):Bool {
        _fn(v, event);
        return false;
    }
}
