// v2

class LuminicBox.FlashInspector.UI.Background extends MovieClip {
	
	private var mcMask:MovieClip;
	private var mcBg:MovieClip;
	private var mcBgBevel:MovieClip;
	private var mcBgSide:MovieClip;
	private var mcBox:MovieClip;
	private var mcBoxShadow:MovieClip;
	private var mcInspectBg:MovieClip;
	
	public function Background() {
		var w:Number = _width;
		var h:Number = _height;
		this._xscale = 100;
		this._yscale = 100;
		setSize(w,h);
	}
	
	public function setSize(w:Number, h:Number):Void {
		// bg
		mcBg._width = w;
		mcBg._height = h;
		mcBgBevel._width = w;
		mcBgSide._x = w-mcBgSide._width;
		// mask shape
		setBoxSize(mcMask, w, h);
		// boxes
		setBoxSize(mcBox, w-8, h-22);
		setBoxSize(mcBoxShadow, w-8, h-22);
		// inspect bg
		mcInspectBg._width = w-14;
		mcInspectBg._height = h-28;
	}
	
	private function setBoxSize(box:MovieClip, w, h) {
		var cornerSize = box.cornerBL._width;
		box.w._width = w;
		box.w._height= h-cornerSize*2;
		box.h._height = h;
		box.h._width = w-cornerSize*2;
		box.cornerBL._y = h - cornerSize;
		box.cornerTR._x = w - cornerSize;
		box.cornerBR._y = h - cornerSize;
		box.cornerBR._x = w - cornerSize;
	}
}