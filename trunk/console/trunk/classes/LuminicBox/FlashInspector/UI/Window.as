class LuminicBox.FlashInspector.UI.Window extends MovieClip {
	
	public var onClose:Function;
	
	private var mcContent:MovieClip;
	
	public static function createWindow(base:MovieClip, w:Number, h:Number, contentId:String):Window {
		var win = Window(base.attachMovie(WINDOW_LIB_ID, WINDOW_LIB_ID, base.getNextHighestDepth()));
		win.setSize(w,h);
		win.attachContent(contentId);
		return win;
	}
	
	public function Window() {
		Stage.addListener(this);
		btnClose.onRelease = mx.utils.Delegate.create(this, close);
	}

	public function dispose():Void {
		Stage.removeListener(this);
		mcContent.removeMovieClip();
		this.removeMovieClip();
	}
	
	public function getContent():MovieClip { return mcContent; }
	
	public function getWidth():Number { return mcBody._width; }
	
	public function getHeight():Number { return mcBody._height; }
	
	public function setSize(w:Number, h:Number):Void {
		setBoxSize(mcBody, w, h);
		setBoxSize(mcShadow, w, h);
		getContent().setSize(w,h);
		onResize();
	}
	
	public function attachContent(id:String):MovieClip {
		mcContent = this.attachMovie(id, id, 0);
		mcContent.close = mx.utils.Delegate.create(this, close);
		return mcContent;
	}
	
	
// Group: Private implementation
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
	
	private function close():Void {
		onClose();
		dispose();
	}
	
	private function onResize():Void {
		this._x = Math.round( (Stage.width - getWidth()) / 2 );
		this._y = Math.round( (Stage.height - getHeight()) / 2 );
		btnClose._x = getWidth() - btnClose._width - 3;
	}
	
	private var mcBody:MovieClip;
	private var mcShadow:MovieClip;
	private var mcContainer:MovieClip;
	private var btnClose:MovieClip;
	private static var WINDOW_LIB_ID:String = "LuminicBox.FlashInspector.UI.Window";
}