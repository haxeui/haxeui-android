package haxe.ui.backend.android.wrappers;

import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.view.ViewGroup.ViewGroup_LayoutParams;
import android.widget.HorizontalScrollView;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.RelativeLayout_LayoutParams;
import android.widget.ScrollView;

class ScrollPane extends RelativeLayout {
    private var _scrollview:ScrollView;
    private var _horizontalScrollView:HorizontalScrollView;
    private var _layout:RelativeLayout;
    
    public function new(context:Context) {
        super(context);
        
        _scrollview = new ScrollView(context);
        addView(_scrollview, new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.MATCH_PARENT, ViewGroup_LayoutParams.MATCH_PARENT));
        
        _horizontalScrollView = new HorizontalScrollView(context);
        _scrollview.addView(_horizontalScrollView);
        
        _layout = new RelativeLayout(context);
        _horizontalScrollView.addView(_layout, new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.MATCH_PARENT, ViewGroup_LayoutParams.MATCH_PARENT));
    }
    
    @:overload
    public override function addView(view:View, params:ViewGroup_LayoutParams) {
        if (view == _scrollview) {
            super.addView(view, params);
        } else {
            _layout.addView(view, params);
        }
    }
}