package haxe.ui.backend.android.behaviours;

import android.widget.TextView;
import haxe.ui.core.DataBehaviour;

class WidgetIcon extends DataBehaviour {
    public override function validateData() {
        if (Std.is(_component.view, TextView)) {
            ToolkitAssets.instance.getImage(_value, function(image) {
                if (image == null || image.data == null) {
                    return;
                }
                var textView:TextView = cast(_component.view, TextView);
                textView.setCompoundDrawablesWithIntrinsicBounds(image.data, null, null, null);
            });
        }
    }
}