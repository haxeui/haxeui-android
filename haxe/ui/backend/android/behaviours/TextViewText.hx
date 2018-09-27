package haxe.ui.backend.android.behaviours;

import android.widget.TextView;
import haxe.ui.core.DataBehaviour;
import haxe.ui.util.Variant;
import java.lang.CharSequence;
import java.lang.StringBuilder;

class TextViewText extends DataBehaviour {
    public override function get():Variant {
        if (Std.is(_component.view, TextView)) {
            var textView:TextView = cast(_component.view, TextView);
            var ch:CharSequence = textView.getText();
            var sb:StringBuilder = new StringBuilder();
            sb.append(ch);
            return sb.toString();
        }
        
        return null;
    }
    
    public override function validateData() {
        if (Std.is(_component.view, TextView)) {
            var textView:TextView = cast(_component.view, TextView);
            textView.setText(_value.toString());
        }
    }
}