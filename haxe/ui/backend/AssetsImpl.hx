package haxe.ui.backend;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import haxe.ui.assets.ImageInfo;
import haxe.ui.backend.android.Utils;
import java.io.ByteArrayInputStream;

class AssetsImpl extends AssetsBase {
    private override function getTextDelegate(resourceId:String):String {
        return Resource.getString("assets/" + resourceId);
    }

    private override function getImageInternal(resourceId:String, callback:ImageInfo->Void) {
        var bytes = Resource.getBytes(resourceId);
        if (bytes == null) {
            callback(null);
            return;
        }
        
        var is:ByteArrayInputStream = new ByteArrayInputStream(bytes.getData());
        var bmp:Bitmap = BitmapFactory.decodeStream(is);
        is.close();
        
        var drawable:BitmapDrawable = new BitmapDrawable(Bitmap.createScaledBitmap(bmp, Utils.convertDpToPixels(bmp.getWidth()),
                                                                                        Utils.convertDpToPixels(bmp.getHeight()), true));
        var info:ImageInfo = {
            width: bmp.getWidth(),
            height: bmp.getHeight(),
            data: drawable
        }
        callback(info);
    }
}