package haxe.ui.backend.android.behaviours;

import haxe.ui.core.DataBehaviour;
import haxe.ui.util.Variant;
import android.widget.TextView;

class TextViewHint extends DataBehaviour {
    public override function validateData() {
        if (Std.is(_component.view, TextView)) {
            var textView:TextView = cast(_component.view, TextView);
            textView.setHint(_value.toString());
        }
    }
}