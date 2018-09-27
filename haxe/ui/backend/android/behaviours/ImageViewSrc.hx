package haxe.ui.backend.android.behaviours;

import haxe.ui.core.DataBehaviour;
import haxe.ui.util.Variant;
import android.widget.ImageView;
import java.io.ByteArrayInputStream;
import android.graphics.drawable.Drawable;
import android.graphics.BitmapFactory;
import android.graphics.Bitmap;

class ImageViewSrc extends DataBehaviour {
    public override function validateData() {
        if (Std.is(_component.view, ImageView)) {
            var bytes = Resource.getBytes("assets/" + _value);
            var is:ByteArrayInputStream = new ByteArrayInputStream(bytes.getData());
            var bmp:Bitmap = BitmapFactory.decodeStream(is);
            /*
            var drawable:Drawable = Drawable.createFromStream(is, _value);
            */
            is.close();
            
            var imageView:ImageView = cast(_component.view, ImageView);
            //imageView.setImageDrawable(drawable);
            imageView.setImageBitmap(bmp);
        }
    }
}