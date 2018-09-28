package haxe.ui.backend;

import haxe.ui.backend.android.MainActivity;
import haxe.ui.core.Component;
import haxe.ui.core.Screen;
import haxe.ui.core.UIEvent;
import haxe.ui.containers.dialogs.Dialog;
import haxe.ui.containers.dialogs.DialogButton;
import android.view.ViewTreeObserver.ViewTreeObserver_OnGlobalLayoutListener;
import android.view.View;

class ScreenBase implements ViewTreeObserver_OnGlobalLayoutListener {
    public function new() {
    }

    public var focus:Component;

    private var _options:Dynamic;
    public var options(get, set):Dynamic;
    private function get_options():Dynamic {
        return _options;
    }
    private function set_options(value:Dynamic):Dynamic {
        _options = value;
        return value;
    }

    public var width(get, null):Float;
    private function get_width():Float {
        return MainActivity.contentView.getWidth();
    }

    public var height(get, null):Float;
    private function get_height():Float {
        return MainActivity.contentView.getHeight();
    }

    public var dpi(get, null):Float;
    private function get_dpi():Float {
        return 72;
    }

    private var _layoutListenerAdded:Bool = false;
    public function addComponent(component:Component) {
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
    
    private function resizeComponent(c:Component) {
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
    
    public function removeComponent(component:Component) {
    }

    private function handleSetComponentIndex(child:Component, index:Int) {
    }

    //***********************************************************************************************************
    // Dialogs
    //***********************************************************************************************************
    public function messageDialog(message:String, title:String = null, options:Dynamic = null, callback:DialogButton->Void = null):Dialog {
        return null;
    }

    public function showDialog(content:Component, options:Dynamic = null, callback:DialogButton->Void = null):Dialog {
        return null;
    }

    public function hideDialog(dialog:Dialog):Bool {
        return false;
    }

    //***********************************************************************************************************
    // Events
    //***********************************************************************************************************
    private function supportsEvent(type:String):Bool {
        return false;
    }

    private function mapEvent(type:String, listener:UIEvent->Void) {
    }

    private function unmapEvent(type:String, listener:UIEvent->Void) {
    }
}