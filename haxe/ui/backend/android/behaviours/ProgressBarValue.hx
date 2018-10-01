package haxe.ui.backend.android.behaviours;

import haxe.ui.core.DataBehaviour;
import android.widget.CompoundButton;
import android.widget.ProgressBar;

class ProgressBarValue extends DataBehaviour {
    public override function validateData() {
        if (Std.is(_component.view, ProgressBar)) {
            var progressBar:ProgressBar = cast(_component.view, ProgressBar);
            progressBar.setProgress(_value);
        }
    }   
}