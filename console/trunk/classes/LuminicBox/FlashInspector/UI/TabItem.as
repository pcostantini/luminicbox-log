import LuminicBox.UI.*;

class LuminicBox.FlashInspector.UI.TabItem extends RepeaterItem {
	
	private var _selected:Boolean;
	private var _tween:mx.transitions.Tween;
	
	private var txtLabel:TextField;
	private var mcBody:MovieClip;
	private var mcShadow:MovieClip;
	
	public function get selected():Boolean { return _selected; }
	public function set selected(value:Boolean) {
		_selected = value;
		this.enabled = !value;
		if(value) {
			txtLabel.textColor = 0x46525A;
			_tween.stop();
			_tween = new mx.transitions.Tween(mcBody,"_alpha",mx.transitions.easing.Regular.easeOut,mcBody._alpha,100,5);
			_tween.onMotionFinished = mx.utils.Delegate.create(this, onFade);
		} else {
			mcShadow._visible = false;
			txtLabel.textColor = 0x236B95;
			_tween.stop();
			delete _tween.onMotionFinished;
			_tween = new mx.transitions.Tween(mcBody,"_alpha",mx.transitions.easing.Regular.easeOut,mcBody._alpha,50,5);
		}
	}
	
	public function init() {
		txtLabel.text = dataItem.toString().toUpperCase();
		this.hitArea = mcBody;
		selected = false;
	}
	
	private function onFade():Void { mcShadow._visible = selected; }
	
	private function onRelease():Void { dispatchEvent( {type:"click",item:this,label:dataItem.toString()} ); }
	
	private function onRollOver():Void {
		_tween.stop();
		_tween = new mx.transitions.Tween(mcBody,"_alpha",mx.transitions.easing.Strong.easeOut,mcBody._alpha,75,10);
	}
	private function onRollOut():Void {
		_tween.stop();
		_tween = new mx.transitions.Tween(mcBody,"_alpha",mx.transitions.easing.Strong.easeOut,mcBody._alpha,50,10);
	}
	private function onReleaseOutside():Void { onRollOut(); }
	
}