import LuminicBox.UI.*;
import mx.utils.Delegate;

class LuminicBox.FlashInspector.UI.ControlBox extends BaseComponent {
	
	public var onTogglePause:Function;
	public var onClear:Function;
	public var onToggleOnTop:Function;
	
	private var btnClear:Button;
	private var btnPlay:Button;
	private var btnPause:Button;
	private var btnOnTopOn:Button;
	private var btnOnTopOff:Button;
	private var mcOnTopBg:MovieClip;
	
	public function set allowOnTop(value:Boolean) {
		mcOnTopBg._visible = value;
		btnOnTopOn._visible = value;
		btnOnTopOff._visible = value;
	}
	
	public function ControlBox() {
		setPause(false);
		btnClear.onRelease = Delegate.create(this, clear);
		btnPlay.onRelease = Delegate.create(this, togglePause);
		btnPause.onRelease = Delegate.create(this, togglePause);
		btnOnTopOn.onRelease = Delegate.create(this, toggleOnTop);
		btnOnTopOff.onRelease = Delegate.create(this, toggleOnTop);
	}
	
	public function setPause(value:Boolean):Void {
		btnPlay._visible = value;
		btnPause._visible = !value;
	}
	
	public function setOnTop(value:Boolean):Void {
		btnOnTopOn._visible = !value;
		btnOnTopOff._visible = value;
	}
	
	private function clear():Void { onClear(); }
	private function togglePause():Void { onTogglePause(); }
	private function toggleOnTop():Void { onToggleOnTop(); }
	
}