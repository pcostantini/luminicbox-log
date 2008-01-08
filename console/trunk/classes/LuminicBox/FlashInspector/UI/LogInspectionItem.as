import mx.utils.Delegate;
import LuminicBox.FlashInspector.MenuManager;

class LuminicBox.FlashInspector.UI.LogInspectionItem extends LuminicBox.UI.RepeaterItem {
	
	public static var activeItem:LogInspectionItem = null;
	
	public var crossRefItem:MovieClip;
	
	private var mcBg:MovieClip;
	private var mcToggleIcon:MovieClip;
	private var txtValue:TextField;
	private var _childItems:LuminicBox.UI.Repeater;
	private var _printValue:String;
	private var _expandable:Boolean;
	private var _expanded:Boolean;
	private var _showBg:Boolean = true;
	
// static
	
// properties
	public function set showBg(value:Boolean) {
		_showBg = value;
		mcBg.gotoAndStop( (value)?1:2 );
	}
	
	public function get expandable():Boolean { return _expandable; }
	public function set expandable(value:Boolean) {
		mcToggleIcon._visible = value;
		_expandable = value;
	}
	
	public function showCrossRefHint() { mcBg.gotoAndStop(4); }
	
	public function hideCrossRefHint() { mcBg.gotoAndStop( (_showBg)?1:2 ); }
	
// methods
	public function getObj():Object {
		return dataItem.value;
	}
	
// init function
	private function init():Void {
		_expandable = false;
		_expanded = false;
		mcToggleIcon._visible = false;
		// bg events
		mcBg.onRollOver = Delegate.create(this, onBgRollOver);
		mcBg.onRollOut = Delegate.create(this, onBgRollOut);
		mcBg.onReleaseOutside = mcBg.onRollOut;
		mcBg.onRelease = Delegate.create(this, onBgRelease);
		// calculate left margin
		var offsetX:Number = (_parent["inspectionDepth"]*20)
		mcToggleIcon._x = mcToggleIcon._x + offsetX;
		txtValue._x = txtValue._x + offsetX;
		// what to print
		switch(getObj().type) {
			// null / undefined
			case("undefined"):
			case("null"):
				printNull();
				break;
			// objects
			case("properties"):
				txtValue.textColor = 0x3366cc;
				_printValue = getObj().type
				expandable = true;
				delete dataItem.property;
				if(!getObj().value.reversed) {
					// reverse items
					getObj().value.reverse();
					getObj().value.reversed = true;
				}
				break;
			case("object"):
				printObject();
				expandable = true;
				break;
			// primitives
			case("string"):
			case("boolean"):
			case("number"):
			case("date"):
				printValue();
				break;
			// color
			case("color"):
				_printValue = getObj().value.toString(16);
				break;
			// array
			case("array"):
				printArray();
				expandable = (getObj().value.length > 0);
				break;
			// stage objs
			case("button"):
			case("movieclip"):
			case("textfield"):
				printId();
				expandable = true;
				break;
			// xml
			case("xml"):
			case("xmlnode"):
			case("function"):
				printType();
				expandable = false;
				break;
			case("sound"):
				printType();
				expandable = true;
				break;
		}
		
		if(dataItem.property != undefined) _printValue = dataItem.property + ": " + _printValue;
		if(dataItem.label != undefined) _printValue = dataItem.label + ": " + _printValue;
		
		// validate (max depth || cross-reference)
		if(getObj().reachLimit || getObj().crossRef) expandable = false;
		
		txtValue.embedFonts = true;
		txtValue.text = _printValue;
		
		// context menu
		var cMenu = MenuManager.getMenu();
		cMenu.customItems.unshift( new ContextMenuItem("Copy Item", Delegate.create(this,menu_onCopy)) );
		this.menu = cMenu;		

	}
	
	/*
	   available types:
	    function
		properties
		object
		string
		boolean
		number
		undefined
		null
		date
		array
		button
		movieclip
		xml
		xmlnode
		color
	*/
	
	private function printValue():Void {
		_printValue = getObj().value;
	}
	
	private function printNull():Void {
		_printValue = "(" + getObj().type + ")";
	}
	
	private function printId():Void {
		//_printValue = "(" + getObj().type + " " + getObj().id + ")";
		_printValue = "(" + getObj().id + ")";
	}
	
	private function printType():Void {
		_printValue = "(" + getObj().type + ")";
	}
	
	private function printObject():Void {
		_printValue = "(" + getObj().id + ")";
	}
	
	private function printArray():Void {
		_printValue = "(" + getObj().type + ":" + getObj().value.length + ")";
	}


/* collapse methods (TODO: summarize) */
	private function toogleExpand():Void {
		if(_expanded) {
			collapse(Key.isDown(Key.SHIFT));
		} else {
			expand(Key.isDown(Key.SHIFT));
		}
	}
	
	public function collapse(doChildren:Boolean):Void {
		if(!_expanded) return;
		_expanded = false;
		mcToggleIcon.gotoAndStop(1);
		if(_childItems) {
			_childItems._visible = false;
			_childItems._yscale = 0;
			if(doChildren) {
				for(var i=0; i<_childItems.items.length; i++) {
					var item = _childItems.items[i];
					if(item.expandable) item.collapse(true);
				}
			}
		}
		dispatchEvent( {type:"redraw",item:this} );
	}
	
	public function expand(doChildren:Boolean):Void {
		if(_expanded) return;
		_expanded = true ;
		mcToggleIcon.gotoAndStop(3);
		if(!_childItems) {
			_childItems = LuminicBox.UI.Repeater ( attachMovie("Repeater", "mcChildItems", 1) );
			_childItems["inspectionDepth"] = _parent["inspectionDepth"]+1;
			_childItems._y = 19;
			_childItems.direction = "vertical";
			_childItems.addEventListener("ALL", this, "onItemEvent");
			_childItems.itemTemplate = "LuminicBox.FlashInspector.UI.LogInspectionItem";
			_childItems.databind( getObj().value );
		} else {
			_childItems._visible = true;
			_childItems._yscale = 100;
		}
		if(doChildren) {
			for(var i=0; i<_childItems.items.length; i++) {
				var item = _childItems.items[i];
				if(item.expandable) item.expand(true);
			}
		}
		dispatchEvent( {type:"redraw",item:this} );
	}
	
/* subitems event handler */
	private function onItemEvent(e) {
		if(e.type == "redraw") {
			dispatchEvent( {type:"redraw",item:this} );
		} else if(e.type == "crossreferencehint" && e.item.getObj().value == this.getObj().value) {
			e.item.crossRefItem = this;
			showCrossRefHint();
		} else {
			dispatchEvent(e);
		}
	}
	
/* ui event handlers */
	private function onBgRollOver() {
		mcBg.gotoAndStop( (!getObj().crossRef)?3:4 );
		if(getObj().crossRef) dispatchEvent( {type:"crossreferencehint",item:this} );
		if(_expandable) mcToggleIcon.gotoAndStop( (_expanded)?4:2 );
		activeItem = this;
		if(getObj().type != "properties") dispatchEvent( {type:"itemrollover",item:this,argument:dataItem} );
	}
	
	private function onBgRollOut() {
		mcBg.gotoAndStop( (_showBg)?1:2 );
		if(_expandable) mcToggleIcon.gotoAndStop( (_expanded)?3:1 );
		if(getObj().crossRef) crossRefItem.hideCrossRefHint();
		activeItem = null;
		dispatchEvent( {type:"itemrollout",item:this,argument:dataItem} );
	}
	
	private function onBgRelease() {
		var type = getObj().type;
		if(_expandable) {
			// inspectable (expandable)
			toogleExpand();
			onBgRollOver();
		} else if(getObj().crossRef) {
			// cross-reference
			//crossRefItem.collapse();
		} else if(type == "xml" || type == "xmlnode" || type == "string") {
			// call inspect window
			dispatchEvent( {type:"iteminspect",item:this,argument:getObj()} );
		}
	}
	
/* menu handlers */
	private function menu_onCopy(obj:Object, menu:ContextMenu):Void {
		LuminicBox.FlashInspector.ClipboardManager.saveToClipboard( getObj() );
	}
}

/*
 * Group: Changelog
 * 
 * Wed Nov 16 21:30:18 2005:
 *  - added custom menu for copying item's data
 * 
 * Thu Sep 29 01:17:53 2005:
 *  - added support for LogEvent.label
 * 
 * Tue Sep 27 01:25:29 2005:
 *  - added full expand/collapse support
 * 
 * Tue May 03 01:12:42 2005:
 * 	- added call to properties.reverse()
 * 
 * Sat Apr 30 13:06:08 2005:
 * 	- new printObj() function for writting object's type using toString().
 * 
 * Mon Apr 25 23:11:22 2005:
 * 	- the cross-reference obj is now highlighted
 * 	- getObj(), collapse() and expand() are now public methods
 * 	- mcBg.onReleaseOutside = mcBg.onRollOut
 * 
 * Tue Mar 22 22:02:06 2005:
 * 	- added Property inspection. properties are now inspected
 * 	- added array.length within {array} label
 * 	- fixed xmlnode inspection
 * 
 * Mon Nov 29 21:36:51 2004:
 * 	- fixed redraw bug last items from the second(+) levels
 */