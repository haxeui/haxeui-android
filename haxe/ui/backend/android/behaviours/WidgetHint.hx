package haxe.ui.backend.android.behaviours;

import haxe.ui.core.DataBehaviour;
import haxe.ui.util.Variant;
import android.widget.EditText;

class WidgetHint extends DataBehaviour {
    public override function validateData() {
        if (Std.is(_component.view, EditText)) {
            var editText:EditText = cast(_component.view, EditText);
            editText.setHint(_value.toString());
        }
    }
}