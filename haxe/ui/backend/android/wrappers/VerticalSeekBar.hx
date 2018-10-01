package haxe.ui.backend.android.wrappers;

import android.content.Context;
import android.widget.SeekBar;
import android.graphics.Canvas;
import android.view.MotionEvent;

// http://hoodaandroid.blogspot.com/2012/10/vertical-seek-bar-or-slider-in-android.html
// https://github.com/jeisfeld/Augendiagnose/blob/master/AugendiagnoseIdea/augendiagnoseLib/src/main/java/de/jeisfeld/augendiagnoselib/components/VerticalSeekBar.java
class VerticalSeekBar extends SeekBar {
    public function new(context:Context) {
        super(context);
    }
    
    @:overload
    private override function onSizeChanged(w:Int, h:Int, oldw:Int, oldh:Int) {
        super.onSizeChanged(h, w, oldh, oldw);
    }
    
    @:overload
    private override function onMeasure(widthMeasureSpec:Int, heightMeasureSpec:Int) {
        super.onMeasure(heightMeasureSpec, widthMeasureSpec);
        setMeasuredDimension(getMeasuredHeight(), getMeasuredWidth());
    }
    
    @:overload
    private override function onDraw(c:Canvas) {
        c.rotate(-90);
        c.translate(-getHeight(), 0);
        super.onDraw(c);
    }
    
    @:overload
    public override function onTouchEvent(event:MotionEvent):Bool {
        if (!isEnabled()) {
            return false;
        }
        
        if (event.getAction() == MotionEvent.ACTION_DOWN || event.getAction() == MotionEvent.ACTION_MOVE || event.getAction() == MotionEvent.ACTION_UP) {
            setProgress(getMax() - Std.int((getMax() * event.getY() / getHeight())));
            onSizeChanged(getWidth(), getHeight(), 0, 0);
        }
          
        return true;
    }
}