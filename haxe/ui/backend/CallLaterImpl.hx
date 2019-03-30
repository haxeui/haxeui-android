package haxe.ui.backend;

import android.os.Handler;

class CallLaterImpl implements java.lang.Runnable {
    private var _fn:Void->Void;
    private var _handler:Handler;
    public function new(fn:Void->Void) {
        _fn = fn;
        _handler = new Handler();
        _handler.post(this);
//        _handler.postDelayed(this, 5);
    }
    
    public function run() {
        _handler.removeCallbacksAndMessages(this);
        _fn();
    }
}