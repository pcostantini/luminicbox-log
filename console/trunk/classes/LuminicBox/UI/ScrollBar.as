class LuminicBox.UI.ScrollBar extends LuminicBox.UI.BaseComponent {

// fields	
	// controls
	private var btnB:Button;
	private var btnF:Button;
	private var btnBar:Button;
	private var mcBg:MovieClip;
	// content & mask
	private var mcContent:MovieClip;
	private var mcMask:MovieClip;
	// vars
	private var pageSize:Number;
	private var contentSize:Number;
	private var _smoothScroll:Boolean=false;
	private var _stepWidth:Number=0;
	private var _rescaleBar:Boolean=false;
	private var _direction:String;
	private var _directionPos:String = "_y";
	private var _directionSize:String = "_height";
	private var _directionMouse:String = "_ymouse";
	private var _hideWhenDisabled:Boolean=false;
	
	
// properties:
	[Inspectable(type="Boolean",defaultValue="false")]
	public function get smoothScroll():Boolean { return _smoothScroll; }
	public function set smoothScroll(value:Boolean) { _smoothScroll = value; }
	
	// [Inspectable(type="String",enumeration="Vertical, Horizontal")]
	[Inspectable( enumeration="Vertical,Horizontal", defaultValue="Vertical")]
	public function get direction():String { return _direction; }
	public function set direction(value:String) {
		_direction = value; 
		if(_direction == "Horizontal") {
			_directionPos = "_x";
			_directionSize = "_width";
			_directionMouse = "_ymouse";
		}else{
			_directionPos = "_y";
			_directionSize = "_height";
			_directionMouse = "_ymouse";
		}
	}
	
	[Inspectable(type="Boolean",defaultValue="false")]
	public function get hideWhenDisabled():Boolean { return _hideWhenDisabled; }
	public function set hideWhenDisabled(value:Boolean) { _hideWhenDisabled = value; }
	
	[Inspectable()]
	public function get content():MovieClip { return mcContent; }
	public function set content(mc:MovieClip) {
		if(typeof(mc) == "string") mc = this._parent[mc];
		mcContent = mc;
		if(mcMask != undefined) mcContent.setMask(mcMask);
	}
	[Inspectable()]
	public function get mask():MovieClip { return mcMask; }
	public function set mask(mc:MovieClip) {
		if(typeof(mc) == "string") mc = this._parent[mc];
		mcMask = mc;
		
		if(mcContent != undefined) mcContent.setMask(mcMask);
	}
	[Inspectable(type="Number",defaultValue="5")]
	public function get stepWidth():Number { return _stepWidth; }
	public function set stepWidth(sw:Number) {
		_stepWidth = sw;
	}
	
	[Inspectable(type="Boolean",defaultValue="true")]
	public function get rescaleBar():Boolean { return _rescaleBar; }
	public function set rescaleBar(value:Boolean) { _rescaleBar = value; }
	
	public function get position():Number {
		if(contentSize>pageSize) {
			return (mcContent[_directionPos]-mcMask[_directionPos])*-100 / (contentSize-pageSize);
		} else {
			return 100;
		}
	}
	public function set position(value:Number) {
		setContentPosition(value, true);
		updateBar();
	}

// constructor
	function ScrollBar() {
		super();
		
		// set initial state
		// var h = this._height;
		/*var rot:Number = this._rotation
		this._rotation = 0
		this._rotation = rot*/
		var h = this[_directionSize] - btnB._height - btnF._height;
		this._xscale = 100;
		this._yscale = 100;
		setHeight(h);
		// add event handlers
		btnB.onPress = mx.utils.Delegate.create(this,btnB_onClick);
		btnF.onPress = mx.utils.Delegate.create(this,btnF_onClick);
		btnBar.onPress = mx.utils.Delegate.create(this,btnBar_onPress);
		btnBar.onRelease = mx.utils.Delegate.create(this,btnBar_onRelease);
		btnBar.onReleaseOutside = mx.utils.Delegate.create(this,btnBar_onRelease);
		reset();
		Mouse.addListener(this);
	}
	
	/*function onUnload():Void {
		Mouse.removeListener(this);
	}*/
	
// methods
	public function scroll(direction) {
		if(_stepWidth==0){
			var offset = (pageSize * .1) * direction;
		} else {
			var offset = _stepWidth * direction;
		}
		var newPos = mcContent[_directionPos] + offset;
		var minPos = mcMask[_directionPos];
		var maxPos = mcMask[_directionPos] - (contentSize-pageSize);
		if(newPos > minPos) {
			newPos = minPos;
		} else if(newPos < maxPos) {
			newPos = maxPos;
		}
		moveContent(newPos, true);
		//moveContent(newPos, true);
	}
	
	function update() {
		updateBar();
	}
	
	function reset() {
		if(!mcMask || !mcContent) return;
		mcContent[_directionPos] = mcMask[_directionPos];
		updateBar();
	}
	
	function setHeight(h:Number) {
			/*
		mcBg._y = 0;
		mcBg._height = h;
		btnF._y = h-btnF._height;
			*/
		mcBg._y = btnB._height;
		mcBg._height = h;
		btnF._y = mcBg._y + mcBg._height;
		//btnF._y = btnB._height + h;
	}
	
// private methods
	private function calculateSize() {
		pageSize = mcMask[_directionSize];
		contentSize = mcContent[_directionSize];
	}
	
	private function updateBar() {
		calculateSize();
		// var barArea = mcBg._height - (btnB._height + btnF._height); 
		var barArea = mcBg._height //  - (btnB._height + btnF._height);
		var barStart = btnB._height;
		// caculate bar size
		var pageSizePer = (pageSize *  100) / contentSize;
		// validate size
		btnBar._visible = (pageSizePer < 100)
		if(pageSizePer >= 100) {
			if(mcContent._y != mcMask._y) mcContent._y = mcMask._y;
			return;
		}
		// rescale bar 
		if( _rescaleBar ){
		var barSize = (barArea * pageSizePer) / 100;
		btnBar._height = barSize;
		} else {
			var barSize = btnBar._height;
			// btnBar._height = barSize;
		}
		// calculate bar position
		var posPer = (mcContent[_directionPos]-mcMask[_directionPos])*-100 / (contentSize-pageSize);
		if(_hideWhenDisabled) {
			btnB._visible = (Math.round(posPer) != 0);
			btnF._visible = (Math.round(posPer) != 100);
		}
		var newPos = barStart +  (barArea-barSize) * posPer / 100;
		// validate new bar position
		//if(newPos < (barArea + barStart - barSize)) newPos = (barArea + barStart - barSize);
		var maxPos = (barStart + barArea) - barSize
		if(newPos > maxPos) newPos = maxPos;
		btnBar._y = newPos;
	}
	
	private function setContentPosition(posPer, update) {
		calculateSize();
		var minPos = mcMask[_directionPos];
		var maxPos = mcMask[_directionPos] - (contentSize-pageSize);
		var newPos = (posPer*(contentSize-pageSize))/-100+mcMask[_directionPos];
		if(newPos > minPos) {
			newPos = minPos;
		} else if(newPos < maxPos) {
			newPos = maxPos;
		}
		moveContent(newPos, update)
		if(_hideWhenDisabled) {
			btnB._visible = (Math.round(posPer) != 0);
			btnF._visible = (Math.round(posPer) != 100);
		}
	}
	
	private function moveContent(pos, update) {
		if(!_smoothScroll) {
			mcContent[_directionPos] = pos;
			//updateBar();
		} else {
			var tw = new mx.transitions.Tween(mcContent,_directionPos,mx.transitions.easing.Regular.easeOut,mcContent[_directionPos], pos, 15);
			if(update) tw.onMotionChanged  = mx.utils.Delegate.create(this,updateBar);
		}
	}
	

	
// event handlers
	private function btnB_onClick() {
		scroll(1);
		updateBar();
	}
	private function btnF_onClick() {
		scroll(-1);
		updateBar();
	}
	private var lastMousePos=0;
	private function btnBar_onPress() {
		lastMousePos = this[_directionMouse];
		this.onMouseMove = mouse_onMove;
	}
	private function btnBar_onRelease() {
		//Mouse.removeListener(this);
		delete this.onMouseMove;
	}
	private function mouse_onMove() {
		var minPos = btnB._height;
		var maxPos = btnF._y - btnBar._height;
		var newMousePos = this[_directionMouse];
		if(newMousePos<minPos) {
			newMousePos = minPos;
		} else if(newMousePos > (this[_directionSize]-btnF._height)) {
			newMousePos = this[_directionSize]-btnF._height;
		}
		// trace(lastMousePos + " - " + newMousePos +" = " +  (lastMousePos - newMousePos));
		var newPos = btnBar._y + (lastMousePos - newMousePos) * -1;

		if(newPos < minPos) {
			newPos = minPos;
		} else if(newPos > maxPos) {
			newPos = maxPos;
		}
		btnBar._y = newPos;
		lastMousePos = newMousePos;
		
		// var barArea = mcBg._height - (btnB._height + btnF._height);		
		var barArea = mcBg._height // - (btnB._height + btnF._height);		
		var posPer = 100/(barArea-btnBar._height) * (newPos-minPos);
		setContentPosition(posPer, false);
	}
	
	private function onMouseWheel(delta:Number, target:MovieClip) {
		if(target._target.indexOf(mcContent._target) == 0) {
			scroll(delta);
			updateBar();
		}
	}

	// 	reset
	// 	update
	// event handlers
	// 	mcBar_onDrag
	// 	btnB_onClick
	// 	btnF_onClick

	
}