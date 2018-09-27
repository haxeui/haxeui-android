package haxe.ui.backend;

import android.graphics.Color;
import android.view.View;
import android.view.ViewGroup.ViewGroup_LayoutParams;
import android.widget.RelativeLayout.RelativeLayout_LayoutParams;
import haxe.ui.backend.android.MainActivity;
import android.widget.Button;
import haxe.ui.backend.android.handlers.TouchHandler;
import haxe.ui.backend.android.wrappers.ScrollPane;
import haxe.ui.backend.android.wrappers.TabPane;
import haxe.ui.containers.ScrollView2;
import haxe.ui.core.Component;
import haxe.ui.core.ImageDisplay;
import haxe.ui.core.MouseEvent;
import haxe.ui.core.Screen;
import haxe.ui.core.TextDisplay;
import haxe.ui.core.TextInput;
import haxe.ui.core.UIEvent;
import haxe.ui.styles.Style;
import haxe.ui.util.Rectangle;
import android.view.ViewTreeObserver.ViewTreeObserver_OnGlobalLayoutListener;
import android.graphics.PorterDuff.PorterDuff_Mode;
import android.graphics.drawable.GradientDrawable;
import java.Lib;
import java.NativeArray;
import android.widget.TextView;
import android.view.MotionEvent;
import android.graphics.drawable.InsetDrawable;
import android.graphics.Rect;
import android.util.DisplayMetrics;
import haxe.ui.backend.android.handlers.ClickHandler;

class ComponentBase implements ViewTreeObserver_OnGlobalLayoutListener {
    private var _eventMap:Map<String, UIEvent->Void>;
    
    public var view:View;
    
    public function new() {
        _eventMap = new Map<String, UIEvent->Void>();
    }

    public function onGlobalLayout() {
        cast(this, Component).invalidateComponentLayout();
    }
    
    public function handleCreate(native:Bool) {
        var className:String = Type.getClassName(Type.getClass(this));
        var nativeComponentClass:String = Toolkit.nativeConfig.query('component[id=${className}].@class', 'android.widget.RelativeLayout', this);
        var params:Array<Dynamic> = [MainActivity.context];
        /*
        if (Std.is(this, haxe.ui.components.HProgress)) {
            // annoying case for progress bars
            var p = new ProgressBar(MainActivity.context, null, android.R.R_attr.progressBarStyleHorizontal);
            p.setProgressDrawable(MainActivity.context.getResources().getDrawable(android.R.R_drawable.progress_horizontal));
            view = p;
        } else {
            view = Type.createInstance(Type.resolveClass(nativeComponentClass), params);
        }
        */
        view = Type.createInstance(Type.resolveClass(nativeComponentClass), params);
        
        // TODO: just temp stuff to play
        /*
        if (Std.is(view, Button)) {
            mapEvent(MouseEvent.MOUSE_DOWN, function(e) {
                cast(this, Component).addClass(":down");
            });
            mapEvent(MouseEvent.MOUSE_UP, function(e) {
                cast(this, Component).removeClass(":down");
            });
        }
        */
        
        
        if (view == null) {
            throw 'Could not create native component: ${nativeComponentClass}';
        }
        
        //view.getViewTreeObserver().addOnGlobalLayoutListener(this);
    }

    private function handlePosition(left:Null<Float>, top:Null<Float>, style:Style) {
        if (view == null || Type.getClass(this) == null) {
            return;
        }

        if (Std.is(view.getLayoutParams(), RelativeLayout_LayoutParams)) {
            var params:RelativeLayout_LayoutParams = cast(view.getLayoutParams(), RelativeLayout_LayoutParams);
            if (params == null) {
                params = new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.WRAP_CONTENT, ViewGroup_LayoutParams.WRAP_CONTENT);
            }
            
            params.leftMargin = Std.int(left);
            params.topMargin = Std.int(top);
            view.setLayoutParams(params);
        }
        
    }

    private function handleSize(width:Null<Float>, height:Null<Float>, style:Style) {
        if (view == null || Type.getClass(this) == null) {
            return;
        }
        
        if (Std.is(view.getLayoutParams(), RelativeLayout_LayoutParams)) {
            var params:RelativeLayout_LayoutParams = cast(view.getLayoutParams(), RelativeLayout_LayoutParams);
            if (params == null) {
                params = new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.WRAP_CONTENT, ViewGroup_LayoutParams.WRAP_CONTENT);
            }
            
            var c:Component = cast(this, Component);
            if (c.autoWidth == false) {
                params.width = Std.int(width);
            }
            if (c.autoHeight == false) {
                params.height = Std.int(height);
            }

            view.setLayoutParams(params);
        }
    }

    private function handleReady() {
        view.getViewTreeObserver().addOnGlobalLayoutListener(this);
    }

    private function handleClipRect(value:Rectangle) {
    }

    public function handlePreReposition() {
    }

    public function handlePostReposition() {
    }

    private function handleVisibility(show:Bool) {
    }

    //***********************************************************************************************************
    // Text related
    //***********************************************************************************************************
    private var _textDisplay:TextDisplay;
    public function createTextDisplay(text:String = null):TextDisplay {
        if (_textDisplay == null) {
            _textDisplay = new TextDisplay();
        }
        if (text != null) {
            _textDisplay.text = text;
        }
        return _textDisplay;
    }

    public function getTextDisplay():TextDisplay {
        return createTextDisplay();
    }

    public function hasTextDisplay():Bool {
        return (_textDisplay != null);
    }

    private var _textInput:TextInput;
    public function createTextInput(text:String = null):TextInput {
        if (_textInput == null) {
            _textInput = new TextInput();
        }
        if (text != null) {
            _textInput.text = text;
        }
        return _textInput;
    }

    public function getTextInput():TextInput {
        return createTextInput();
    }

    public function hasTextInput():Bool {
        return (_textInput != null);
    }

    //***********************************************************************************************************
    // Image related
    //***********************************************************************************************************
    private var _imageDisplay:ImageDisplay;
    public function createImageDisplay():ImageDisplay {
        if (_imageDisplay == null) {
            _imageDisplay = new ImageDisplay();
        }
        return _imageDisplay;
    }

    public function getImageDisplay():ImageDisplay {
        return createImageDisplay();
    }

    public function hasImageDisplay():Bool {
        return (_imageDisplay != null);
    }

    public function removeImageDisplay() {
        if (_imageDisplay != null) {
            _imageDisplay = null;
        }
    }

    //***********************************************************************************************************
    // Display tree
    //***********************************************************************************************************
    private function handleSetComponentIndex(child:Component, index:Int) {
    }

    private function handleAddComponent(child:Component):Component {
        if (Std.is(view, TabPane)) {
            cast(view, TabPane).addTab(child.text, child.view);
        } else {
            var params = new RelativeLayout_LayoutParams(ViewGroup_LayoutParams.WRAP_CONTENT, ViewGroup_LayoutParams.WRAP_CONTENT);
            cast(view, android.view.ViewGroup).addView(child.view, params);
        }
        return child;
    }

    private function handleAddComponentAt(child:Component, index:Int):Component {
        return child;
    }
    
    private function handleRemoveComponent(child:Component, dispose:Bool = true):Component {
        return child;
    }

    private function handleRemoveComponentAt(index:Int, dispose:Bool = true):Component {
        return null;
    }

    private function applyStyle(style:Style) {
        if (style.backgroundColor != null) {
            var c:haxe.ui.util.Color = style.backgroundColor;
            if (view.getBackground() != null) {
                view.getBackground().setColorFilter(Color.rgb(c.r, c.g, c.b), PorterDuff_Mode.MULTIPLY);
            } else {
                view.setBackgroundColor(Color.rgb(c.r, c.g, c.b));
            }
        }
        
        if (style.color != null && Std.is(view, TextView)) {
            var c:haxe.ui.util.Color = style.color;
            cast(view, TextView).setTextColor(Color.rgb(c.r, c.g, c.b));
        }
        
        if (style.fontSize != null && Std.is(view, TextView)) {
            cast(view, TextView).setTextSize(style.fontSize);
        }
        
        if (style.backgroundColor != null && style.backgroundColorEnd != null) {
            var gd:GradientDrawable = new GradientDrawable();
            gd.setCornerRadius(Std.int(convertDpToPixels(2)));
            
            if (style.borderColor != null) {
                var borderColor:haxe.ui.util.Color = style.borderColor;
                gd.setStroke(Std.int(convertDpToPixels(style.borderLeftSize)), Color.rgb(borderColor.r, borderColor.g, borderColor.b));
            }

            var backgroundColor:haxe.ui.util.Color = style.backgroundColor;
            var backgroundColorEnd:haxe.ui.util.Color = style.backgroundColorEnd;
            var c1 = Color.rgb(backgroundColor.r, backgroundColor.g, backgroundColor.b);
            var c2 = Color.rgb(backgroundColorEnd.r, backgroundColorEnd.g, backgroundColorEnd.b);
            gd.setColors(Lib.nativeArray([c1, c2], true));
            
            var paddingLeft = view.getPaddingLeft();
            var paddingTop = view.getPaddingTop();
            var paddingRight = view.getPaddingRight();
            var paddingBottom = view.getPaddingBottom();
            
            paddingLeft = 38;
            paddingTop = 55;
            paddingRight = 38;
            paddingBottom = 55;
            
            var inset:InsetDrawable = new InsetDrawable(gd,
                Std.int(convertPixelsToDp(paddingLeft)),
                Std.int(convertPixelsToDp(paddingTop)),
                Std.int(convertPixelsToDp(paddingRight)),
                Std.int(convertPixelsToDp(paddingBottom)));
            
            view.setBackground(inset);
            view.setPadding(0, 0, 0, 0);
        }
    }

    private function convertDpToPixels(dp:Float):Float {
        var resources = MainActivity.context.getResources();
        var metrics = resources.getDisplayMetrics();
        var px = dp * metrics.densityDpi / DisplayMetrics.DENSITY_DEFAULT;
        return px;
    }
    
    private function convertPixelsToDp(px:Float):Float {
        return px / (MainActivity.context.getResources().getDisplayMetrics().densityDpi / DisplayMetrics.DENSITY_DEFAULT);
    }
    
    //***********************************************************************************************************
    // Events
    //***********************************************************************************************************
    private function mapEvent(type:String, listener:UIEvent->Void) {
        switch (type) {
            case MouseEvent.CLICK:
                if (_eventMap.exists(type) == false) {
                    _eventMap.set(type, listener);
                    view.setOnClickListener(new ClickHandler(onViewClick));
                }
            case MouseEvent.MOUSE_DOWN | MouseEvent.MOUSE_UP:
                if (_eventMap.exists(type) == false) {
                    _eventMap.set(type, listener);
                    view.setOnTouchListener(new TouchHandler(onTouch));
                }
        }
    }

    private function unmapEvent(type:String, listener:UIEvent->Void) {
    }
    
    private function onViewClick(view:View) {
        var fn = _eventMap.get(MouseEvent.CLICK);
        if (fn != null) {
            fn(new MouseEvent(MouseEvent.CLICK));
        }
    }
    
    private function onTouch(view:View, event:MotionEvent) {
        switch(event.getAction()) {
            case 0x00000000: //MotionEvent.ACTION_DOWN
                var fn = _eventMap.get(MouseEvent.MOUSE_DOWN);
                if (fn != null) {
                    fn(new MouseEvent(MouseEvent.MOUSE_DOWN));
                }
            case 0x00000001: //MotionEvent.ACTION_UP
                var fn = _eventMap.get(MouseEvent.MOUSE_UP);
                if (fn != null) {
                    fn(new MouseEvent(MouseEvent.MOUSE_UP));
                }
        }
    }
}