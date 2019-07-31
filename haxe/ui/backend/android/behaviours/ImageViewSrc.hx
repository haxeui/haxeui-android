package haxe.ui.backend.android.behaviours;

import android.widget.ImageView;
import haxe.ui.behaviours.DataBehaviour;

class ImageViewSrc extends DataBehaviour {
    public override function validateData() {
        if (Std.is(_component.view, ImageView)) {
            ToolkitAssets.instance.getImage(_value, function(image) {
                if (image == null || image.data == null) {
                    return;
                }
                var imageView:ImageView = cast(_component.view, ImageView);
                imageView.setImageDrawable(image.data);
            });
            
        }
    }
}