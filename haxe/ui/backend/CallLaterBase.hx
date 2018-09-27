package haxe.ui.backend;

import android.os.Handler;

class CallLaterBase implements java.lang.Runnable {
    private static var count1:Int = 0;
    private static var count2:Int = 0;
    private var _fn:Void->Void;
    private var _handler:Handler;
    public function new(fn:Void->Void) {
        _fn = fn;
        /*
        count1++;
        trace("count: " + count1);
        fn(); // actually works nicely like this - no flashing, could be a bottle neck though
        return;
        */
        count1++;
        trace("start");
        _handler = new Handler();
        _handler.post(this);
//        _handler.postDelayed(this, 5);
    }
    
    public function run() {
        count2++;
        trace("Count1 = " + count1 + ", Count2 = " + count2);
        _handler.removeCallbacksAndMessages(this);
        _fn();
        trace("end");
    }
}