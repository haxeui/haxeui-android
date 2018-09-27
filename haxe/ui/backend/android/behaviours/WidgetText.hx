package haxe.ui.backend.android.behaviours;

import haxe.ui.core.Behaviour;
import haxe.ui.core.DataBehaviour;
import haxe.ui.util.Variant;
import android.widget.TextView;

class WidgetText extends DataBehaviour {
    /*
    public override function set(value:Variant) {
        if (value == null || value.isNull == true) {
            return;
        }
        
        if (Std.is(_component.view, TextView)) {
            var textView:TextView = cast(_component.view, TextView);
            textView.setText(value.toString());
            _component.invalidateComponentLayout();
            trace(">>>>>>>>>>>>>>>>>>>>>>>>> " + _component.view.getHeight());
            //cast(_component.view, android.widget.Button).setText(value);
        }
    }

    public override function get():Variant {
        return null;
    }
    */
    /*
    public override function get():Variant {
        if (Std.is(_component.view, TextView)) {
            var textView:TextView = cast(_component.view, TextView);
            return textView.getText();
        }
        
        return null;
    }
    */
    
    public override function validateData() {
        if (Std.is(_component.view, TextView)) {
            var textView:TextView = cast(_component.view, TextView);
            textView.setText(_value.toString());
        }
    }
}