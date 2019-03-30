package haxe.ui.backend.android.behaviours;

import android.widget.CompoundButton;
import haxe.ui.components.OptionBox;
import haxe.ui.behaviours.DataBehaviour;

class CompoundButtonChecked extends DataBehaviour {
    public override function validateData() {
        if (Std.is(_component.view, CompoundButton)) {
            var compoundButton:CompoundButton = cast(_component.view, CompoundButton);
            compoundButton.setChecked(_value);
        }
        
        if (Std.is(_component, OptionBox) && _value == true) {
            var option = cast(_component, OptionBox);
            var group = option.componentGroup;
            for (o in OptionBoxGroups.instance.get(group)) {
                if (o != option) {
                    o.selected = false;
                }
            }
        }
    }
}