package haxe.ui.backend.android.behaviours;

import haxe.ui.core.Behaviour;
import haxe.ui.util.Variant;
import android.widget.Button;
import java.io.ByteArrayInputStream;
import android.graphics.drawable.Drawable;

class WidgetIcon extends Behaviour {
    public override function set(value:Variant) {
        if (value == null || value.isNull == true) {
            return;
        }
        
        if (Std.is(_component.view, Button)) {
            var bytes = Resource.getBytes(value);
            var is:ByteArrayInputStream = new ByteArrayInputStream(bytes.getData());
            var drawable:Drawable = Drawable.createFromStream(is, value);
            is.close();
            var button:Button = cast(_component.view, Button);
            button.setCompoundDrawablesWithIntrinsicBounds(drawable, null, null, null);
        }
    }

    public override function get():Variant {
        return null;
    }
}