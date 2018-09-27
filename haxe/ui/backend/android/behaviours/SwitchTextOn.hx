package haxe.ui.backend.android.behaviours;

import haxe.ui.core.DataBehaviour;
import haxe.ui.util.Variant;
import android.widget.Switch;

class SwitchTextOn extends DataBehaviour {
    public override function validateData() {
        if (Std.is(_component.view, Switch)) {
            var s:Switch = cast(_component.view, Switch);
            s.setShowText(true);
            s.setTextOn(_value);
        }
    }
}
