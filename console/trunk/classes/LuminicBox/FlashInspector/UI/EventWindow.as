import LuminicBox.UI.*;
import LuminicBox.FlashInspector.UI.*;
import mx.utils.Delegate;

class LuminicBox.FlashInspector.UI.EventWindow extends BaseComponent {
	
	private var mcEvents:Repeater;
	private var mcMask:MovieClip;
	private var mcScroll:ScrollBar;
	private var mcBg:MovieClip;
	
	public function EventWindow() {
		super();
		
		mcEvents = Repeater(this.attachMovie("Repeater", "mcEvents", 1) );
		mcEvents.itemTemplate = "LuminicBox.FlashInspector.UI.LogEventItem";
		mcEvents.direction = "vertical";
		mcEvents["inspectionDepth"] = 0;
		mcEvents.addEventListener("redraw", this, "mcEvents_onRedraw");
		mcEvents.addEventListener("iteminspect", this, "mcEvents_onInspect");
		mcEvents.addEventListener("itemrollover", this, "mcEvents_onItemRollover");
		mcEvents.addEventListener("itemrollout", this, "mcEvents_onItemRollout");
		
		mcScroll = ScrollBar(this.attachMovie("LuminicBox.UI.ScrollBar", "mcScroll", 2));
		mcScroll.content = mcEvents;
		mcScroll.mask = mcMask;
		mcEvents.setMask(mcMask);
		
		// resize
		var w:Number = _width;
		var h:Number = _height;
		this._xscale = 100;
		this._yscale = 100;
		setSize(w,h);
	}
	
	public function setSize(w:Number,h:Number) {
		// bg
		mcBg._width = w;
		mcBg._height = h;
		// mask
		mcMask._height = h;
		mcMask._width = w - mcScroll._width;
		// scroll
		var scrollDown:Boolean = (mcScroll.position == 100);
		mcScroll._x = w - mcScroll._width; 
		mcScroll.setHeight(h);
		mcScroll.update();
		if(scrollDown) mcScroll.position = 100;
	}
	
	public function clear():Void {
		LogInspectionItem.activeItem = null;
		mcEvents.reset();
		mcScroll.reset();
	}
	
	public function populate(logEvents:Array) {
		mcEvents.reset();
		mcEvents.databind(logEvents);
		mcScroll.reset();
	}
	
	public function addItem(logEvent):Void {
		var scrollDown:Boolean = (mcScroll.position == 100);
		mcEvents.addItem(logEvent);
		mcScroll.update();
		if(scrollDown) mcScroll.position = 100;
	}
	
	public function scrollLine(dir):Void {
		mcScroll.scroll(dir);
		mcScroll.update();
	}
	
	public function scrollPage(dir):Void {
		mcScroll.scroll(dir * 10);
		mcScroll.update();
	}
	
	public function scrollToTop():Void {
		mcScroll.position = 0;
	}
	
	public function scrollToBottom():Void {
		mcScroll.position = 100;
	}

	
// Group: Repeater Event handlers
	private function mcEvents_onRedraw(e) {
		//var scrollDown:Boolean = (mcScroll.position == 100);
		mcScroll.update();
		//if(scrollDown) mcScroll.position = 100;
	}
	
	private function mcEvents_onItemRollover(e) {
		e.type = "eventInfo";
		dispatchEvent( e );
	}
	
	private function mcEvents_onItemRollout(e) {
		e.type = "eventInfoOut";
		dispatchEvent( e );
	}
	
	private function mcEvents_onInspect(e) {
		e.type = "eventInspect";
		dispatchEvent( e );
	}
	
}