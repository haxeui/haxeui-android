package haxe.ui.backend.android.behaviours;

import haxe.ui.core.Behaviour;
import haxe.ui.util.Variant;
import android.widget.ProgressBar;
import android.widget.SeekBar;

class WidgetProgress extends Behaviour {
    public override function set(value:Variant) {
        if (value == null || value.isNull == true) {
            return;
        }
        
        if (Std.is(_component.view, ProgressBar)) {
            var progressBar:ProgressBar = cast(_component.view, ProgressBar);
            progressBar.setProgress(value);
        } else if (Std.is(_component.view, SeekBar)) {
            var seekBar:SeekBar = cast(_component.view, SeekBar);
            seekBar.setProgress(value);
        }
    }

    public override function get():Variant {
        var value:Variant = 0;

        if (Std.is(_component.view, ProgressBar)) {
            var progressBar:ProgressBar = cast(_component.view, ProgressBar);
            value = progressBar.getProgress();
        } else if (Std.is(_component.view, SeekBar)) {
            var seekBar:SeekBar = cast(_component.view, SeekBar);
            value = seekBar.getProgress();
        }
        
        return value;
    }
}