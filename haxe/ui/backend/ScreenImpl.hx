package haxe.ui.backend;

import haxe.ui.backend.android.MainActivity;
import haxe.ui.core.Component;
import haxe.ui.core.Screen;
import haxe.ui.events.UIEvent;
import android.view.ViewTreeObserver.ViewTreeObserver_OnGlobalLayoutListener;
import android.view.View;

class ScreenImpl extends ScreenBase implements ViewTreeObserver_OnGlobalLayoutListener {
    public function new() {
    }

    private override function get_width():Float {
        return MainActivity.contentView.getWidth();
    }

    private override function get_height():Float {
        return MainActivity.contentView.getHeight();
    }

    private var _layoutListenerAdded:Bool = false;
    public override function addComponent(component:Component) {
        if (_layoutListenerAdded == false) {
            _layoutListenerAdded = true;
            MainActivity.contentView.getViewTreeObserver().addOnGlobalLayoutListener(this);
            
        }

        var rootWidth:String = Toolkit.backendProperties.getProp("haxe.ui.android.root.width");
        if (rootWidth != null) {
            if (StringTools.endsWith(rootWidth, "%")) {
                component.percentWidth = Std.parseFloat(StringTools.replace(rootWidth, "%", ""));
            } else {
                component.width = Std.parseFloat(rootWidth);
            }
        }
        
        var rootHeight:String = Toolkit.backendProperties.getProp("haxe.ui.android.root.height");
        if (rootHeight != null) {
            if (StringTools.endsWith(rootHeight, "%")) {
                component.percentHeight = Std.parseFloat(StringTools.replace(rootHeight, "%", ""));
            } else {
                component.height = Std.parseFloat(rootHeight);
            }
        }
        MainActivity.contentView.addView(component.view);
    }

    public function onGlobalLayout() {
        for (component in cast(this, Screen).rootComponents) {
            component.ready();
            resizeComponent(component);
        }
    }
    
    private override function resizeComponent(c:Component) {
        var cx:Null<Float> = null;
        var cy:Null<Float> = null;

        if (c.percentWidth > 0) {
            cx = (this.width * c.percentWidth) / 100;
        }
        if (c.percentHeight > 0) {
            cy = (this.height * c.percentHeight) / 100;
        }
        
        c.resizeComponent(cx, cy);
    }
    
    public override function removeComponent(component:Component) {
    }

    private override function handleSetComponentIndex(child:Component, index:Int) {
    }

    //***********************************************************************************************************
    // Dialogs
    //***********************************************************************************************************
    /*
    public function messageDialog(message:String, title:String = null, options:Dynamic = null, callback:DialogButton->Void = null):Dialog {
        return null;
    }

    public function showDialog(content:Component, options:Dynamic = null, callback:DialogButton->Void = null):Dialog {
        return null;
    }

    public function hideDialog(dialog:Dialog):Bool {
        return false;
    }
    */

    //***********************************************************************************************************
    // Events
    //***********************************************************************************************************
    private override function supportsEvent(type:String):Bool {
        return false;
    }

    private override function mapEvent(type:String, listener:UIEvent->Void) {
    }

    private override function unmapEvent(type:String, listener:UIEvent->Void) {
    }
}