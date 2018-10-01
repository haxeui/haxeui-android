package haxe.ui.backend;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import haxe.io.Bytes;
import haxe.ui.assets.FontInfo;
import haxe.ui.assets.ImageInfo;
import haxe.ui.backend.android.Utils;
import java.io.ByteArrayInputStream;

class AssetsBase {
    public function new() {

    }

    private function getTextDelegate(resourceId:String):String {
        return Resource.getString("assets/" + resourceId);
    }

    private function getImageInternal(resourceId:String, callback:ImageInfo->Void) {
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

    private function getImageFromHaxeResource(resourceId:String, callback:String->ImageInfo->Void) {
        trace(">>>>> getImageFromHaxeResource: " + resourceId);
        callback(resourceId, null);
    }

    public function imageFromBytes(bytes:Bytes, callback:ImageInfo->Void) {
        trace(">>>>> imageFromBytes: ");
        callback(null);
    }
    
    private function getFontInternal(resourceId:String, callback:FontInfo->Void) {
        callback(null);
    }

    private function getFontFromHaxeResource(resourceId:String, callback:String->FontInfo->Void) {
        callback(resourceId, null);
    }
}