package haxe.ui.backend.android.wrappers;

import android.widget.RelativeLayout;
import android.widget.RelativeLayout.RelativeLayout_LayoutParams;
import android.content.Context;
import android.view.ViewGroup.ViewGroup_LayoutParams;
import android.widget.TabHost;
import android.widget.TabHost.TabHost_TabSpec;
import android.widget.LinearLayout;
import android.widget.FrameLayout;
import android.widget.FrameLayout.FrameLayout_LayoutParams;
import android.widget.LinearLayout.LinearLayout_LayoutParams;
import android.widget.TabWidget;
import android.view.View;

class TabPane extends RelativeLayout {
    private var _tabHost:TabHost;
    private var _tabLayout:LinearLayout;
    private var _tabWidget:TabWidget;
    private var _tabContent:FrameLayout;
    
    public function new(context:Context) {
        super(context);
        
        _tabHost = new TabHost(context, null);
        addView(_tabHost, new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.MATCH_PARENT, ViewGroup_LayoutParams.MATCH_PARENT));
        
        _tabLayout = new LinearLayout(context);
        _tabLayout.setOrientation(LinearLayout.VERTICAL);
        _tabHost.addView(_tabLayout, new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.MATCH_PARENT, ViewGroup_LayoutParams.MATCH_PARENT));
        
        _tabWidget = new TabWidget(context);
        _tabWidget.setId(android.R.R_id.tabs);
        _tabLayout.addView(_tabWidget, new LinearLayout_LayoutParams(ViewGroup_LayoutParams.MATCH_PARENT, ViewGroup_LayoutParams.WRAP_CONTENT));
        
        _tabContent = new FrameLayout(context);
        _tabContent.setId(android.R.R_id.tabcontent);
        _tabLayout.addView(_tabContent, new LinearLayout_LayoutParams(ViewGroup_LayoutParams.MATCH_PARENT, ViewGroup_LayoutParams.MATCH_PARENT));
        
        _tabHost.setup();
    }
    
    public function addTab(text:String, view:View) {
        var tabSpec = _tabHost.newTabSpec(text);
        tabSpec.setIndicator(text);
        if (view.getId() == -1) { // could be done better
            view.setId(Std.random(0xFFFFFF));
        }
        _tabContent.addView(view, new FrameLayout_LayoutParams(ViewGroup_LayoutParams.WRAP_CONTENT, ViewGroup_LayoutParams.WRAP_CONTENT));
        tabSpec.setContent(view.getId());
        _tabHost.addTab(tabSpec); 
    }
}