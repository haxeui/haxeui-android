package haxe.ui.backend.android;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.ViewGroup.ViewGroup_LayoutParams;
import android.view.ViewGroup;
import android.view.ViewTreeObserver.ViewTreeObserver_OnGlobalLayoutListener;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.RelativeLayout_LayoutParams;

@:keep
class MainActivity extends Activity implements ViewTreeObserver_OnGlobalLayoutListener {
    public static var contentView:ViewGroup;

    public static var context:Context;
    
    @:overload
    public override function onCreate(savedInstanceState:Bundle) {
        context = this;
        
        var themeClass:String = Toolkit.backendProperties.getProp("haxe.ui.android.theme"); // eg: haxe.ui.android.theme=ahaxe.ui.backend.android.Style.Theme_DeviceDefault_Light
        if (themeClass != null) {
            var parts = themeClass.split(".");
            var themeId = parts.pop();
            var themeClass = parts.join(".");
            setTheme(Reflect.field(Type.resolveClass(themeClass), themeId));
        } else {
            setTheme(android.R.R_style.Theme_DeviceDefault);
        }
        
        super.onCreate(savedInstanceState);
        
        var title = Toolkit.backendProperties.getProp("haxe.ui.android.title");
        if (title != null) {
            setTitle(title);
        }
        
        if (contentView == null) {
            var rootView = Toolkit.backendProperties.getProp("haxe.ui.android.root.view"); // eg: haxe.ui.android.root.view=android.widget.ScrollView
            var temp = null; // this will be the contentview
            if (rootView != null) {
                var root:ViewGroup = Type.createInstance(Type.resolveClass(rootView), [this]);
                contentView = new RelativeLayout(this);
                root.addView(contentView, new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.MATCH_PARENT, ViewGroup_LayoutParams.MATCH_PARENT));
                temp = root;
            } else {
                contentView = new RelativeLayout(this);
                temp = contentView;
            }
            
            temp.getViewTreeObserver().addOnGlobalLayoutListener(this);
            temp.setFocusable(true);
            temp.setFocusableInTouchMode(true);
            temp.requestFocus();
            setContentView(temp, new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.MATCH_PARENT, ViewGroup_LayoutParams.MATCH_PARENT));
        }
    }
    
    public function onGlobalLayout() {
        contentView.getViewTreeObserver().removeOnGlobalLayoutListener(this);
        var mainClassName = haxe.macro.Compiler.getDefine("haxe.ui.backend.android.main");
        var main = Type.resolveClass(mainClassName);
        Reflect.callMethod(main, Reflect.field(main, "main"), []);
        
    }
}