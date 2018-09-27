package haxe.ui.backend.android;

import android.app.Activity;
import android.os.Bundle;
import android.view.ViewTreeObserver.ViewTreeObserver_OnGlobalLayoutListener;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.RelativeLayout_LayoutParams;
import android.view.ViewGroup.ViewGroup_LayoutParams;
import android.content.Context;
import haxe.ui.core.Screen;

@:keep
class MainActivity extends Activity implements ViewTreeObserver_OnGlobalLayoutListener {
    public static var contentView:RelativeLayout;

    public static var context:Context;
    
    @:overload
    public override function onCreate(savedInstanceState:Bundle) {
        context = this;
        setTheme(android.R.R_style.Theme_DeviceDefault);
        //setTheme(android.R.R_style.Theme_DeviceDefault_Light);
        super.onCreate(savedInstanceState);

        if (contentView == null) {
            contentView = new RelativeLayout(this);
            contentView.getViewTreeObserver().addOnGlobalLayoutListener(this);
            contentView.setFocusable(true);
            contentView.setFocusableInTouchMode(true);
            contentView.requestFocus();
            setContentView(contentView, new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.MATCH_PARENT, ViewGroup_LayoutParams.MATCH_PARENT));
        }
    }

    /*
    private var _paused:Bool = false;
    @:overload
    public override function onPause() {
        super.onPause();
        trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onPause");
        _paused = true;
    }
    
    @:overload
    public override function onResume() {
        super.onResume();
        trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onResume");
        _paused = false;
    }
    
    @:access(haxe.ui.backend.ScreenBase)
    @:overload
    public override function onStop() {
        super.onStop();
        trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStop");
        _paused = false;
        //contentView = null;
        //setContentView(null, null);
        contentView = null;
        context = null;
        
        Screen.instance.rootComponents = [];
        Screen.instance._layoutListenerAdded = false;
        
        //removeContentView(contentView);
    }
    */
    
    public function onGlobalLayout() {
        contentView.getViewTreeObserver().removeOnGlobalLayoutListener(this);
        var mainClassName = haxe.macro.Compiler.getDefine("haxe.ui.backend.android.main");
        var main = Type.resolveClass(mainClassName);
        Reflect.callMethod(main, Reflect.field(main, "main"), []);
        
    }
}