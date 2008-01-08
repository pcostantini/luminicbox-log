class LuminicBox.UI.UIDisabler extends MovieClip {
	
	public static function create(baseMc:MovieClip) {
		var mc = UIDisabler( baseMc.attachMovie("LuminicBox.UI.UIDisabler", "$uiDisabler", baseMc.getNextHighestDepth()) );
		return mc;
	}
	
	function UIDisabler() {
		this._x = 0;
		this._y = 0;
		enabled = true;
	}
	
	function set enabled(v:Boolean) {
		if(!v) {
			Stage.removeListener(this);
			this._visible = false;
			delete this.onRelease;
		} else {
			Stage.addListener(this);
			onResize();
			this.useHandCursor = false;
			this.onRelease = function() { }
			this._visible = true;
		}
	}
	
	function onResize() {
		this._width = Stage.width;
		this._height = Stage.height;
		this._x = 0;
		this._y = 0;
	}
	
}