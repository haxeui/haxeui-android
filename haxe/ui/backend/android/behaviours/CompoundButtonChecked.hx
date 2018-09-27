package haxe.ui.backend.android.behaviours;

import haxe.ui.core.DataBehaviour;
import haxe.ui.util.Variant;
import android.widget.CompoundButton;

class CompoundButtonChecked extends DataBehaviour {
    public override function validateData() {
        if (Std.is(_component.view, CompoundButton)) {
            var compoundButton:CompoundButton = cast(_component.view, CompoundButton);
            compoundButton.setChecked(_value);
        }
    }
}