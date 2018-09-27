package haxe.ui.backend.android.size;

import haxe.ui.layouts.DelegateLayout.DelegateLayoutSize;

class ViewSize extends DelegateLayoutSize {
    private override function get_width():Float {
        return component.view.getWidth();
    }
    
    private override function get_height():Float {
        return component.view.getHeight();
    }
}
