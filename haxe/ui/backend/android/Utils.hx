package haxe.ui.backend.android;

import android.util.DisplayMetrics;

class Utils {
    public static function convertDpToPixels(dp:Float):Int {
        var resources = MainActivity.context.getResources();
        var metrics = resources.getDisplayMetrics();
        var px = dp * metrics.densityDpi / DisplayMetrics.DENSITY_DEFAULT;
        return Std.int(px);
    }
    
    public static function convertPixelsToDp(px:Float):Int {
        return Std.int(px / (MainActivity.context.getResources().getDisplayMetrics().densityDpi / DisplayMetrics.DENSITY_DEFAULT));
    }
}