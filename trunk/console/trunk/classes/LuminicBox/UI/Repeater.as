/**
* A data-bound list control that allows custom layout by repeating a specified template for each item displayed in the list
*/
class LuminicBox.UI.Repeater extends LuminicBox.UI.BaseComponent {
	
	public static var $version = 0.92;


// private vars:
	// fields
	private var _selectedItem:MovieClip;
	private var _dataSource:Array;
	private var _dummy:MovieClip;
	private var _items:Array;
	private var header:MovieClip;
	private var footer:MovieClip;
	// internal vars
	private var inited:Boolean;
	private var sizeProperty:String;			// the name of the size property used to calculate distance between items
	private var oppositeSizeProperty:String;		// the name of the opposite size property
	private var posProperty:String;				// the name of the position property to use
	private var oppositePosProperty:String;			// the name of the opposite position property
	private var pos:Number;					// position
	private var oppositePos:Number;				// opposite axis pos
	private var z:Number;					// depth counter
	// template fields
	private var _itemTemplate:String;
	private var _headerTemplate:String;
	private var _footerTemplate:String;
	private var _separatorTemplate:String;
	private var _direction:String;
	private var _itemsPerLine:Number;	
	private var clipParameters:Object = {
		direction:1,
		itemsPerLine:1,
		footerTemplate:1,
		headerTemplate:1,
		itemTemplate:1,
		separatorTemplate:1
	};
	
// properties:
	
	/**
	* Gets/Sets the repeating direction.<br/>
	* Possible values: "horizontal","vertical"<br/>
	* Default value: "horizontal" 
	*/
	[Inspectable(type="string",enumeration="horizontal,vertical",defaultValue="horizontal")]
	public function set direction(value:String) { _direction = value.toLowerCase(); }
	public function get direction():String { return _direction; }
	/**
	* Gets/Sets the amount of items to repeat on each row/column<br/>
	*  Default value: 1
	*/ 
	[Inspectable(type="number",defaultValue=1)]
	public function set itemsPerLine(value:Number) { _itemsPerLine = value; }
	public function get itemsPerLine():Number { return _itemsPerLine; }
	/**
	* Gets/Sets the control marked as selected.<br/>
	* <b>Remarks:</b><br/>
	* The item should have the <code>selected</code> property and implement logic in it for changing the way the it looks.<br/>
	* <b>Usage:</b>
	* <pre>
	* // using an event broadcasted from the item control:
	* repeater.addEventListener("itemclick", this, "onRepeater_ItemClick");
	* function onRepeater_ItemClick(e) {
	* 	repeater.selectedItem = e.item;
	* }
	* // selecing first item directly
	* repeater.databind(myDataSource);
	* repeater.selectedItem = repeater.items[0]; 
	* </pre> 
	*/ 
	public function get selectedItem():MovieClip { return _selectedItem; }
	public function set selectedItem(value:MovieClip) {
		if(!value) {
			if(_selectedItem) _selectedItem.selected = false;
			_selectedItem = undefined;
		} else {
			if(_selectedItem == value) return;
			if(_selectedItem) _selectedItem.selected = false;
			_selectedItem = value;
			value.selected = true;
		}
	}
	/**
	* Gets a reference to the data source used for the databind.<br/>
	* This method returns <var>undefined</var> if <code>databind()</code> hasn't been called.
	*/
	public function get dataSource():Object { return _dataSource; }
	/**
	* Gets a collection contaning the child controls (Just the 'itemTemplate' controls).
	*/ 
	public function get items():Array { return _items; }
	/**
	* Gets the item count
	*/ 
	public function get itemCount():Number {
		if(_items) return _items.length;
		return 0;
	}
	/**
	* Gets/Sets the library's MovieClip to use when displaying items. <b>Required</b><br/>
	* The MovieClip to repeat must extend RepeaterItem
	* @see RepeaterItem
	*/ 
	[Inspectable(type="string")]
	public function set itemTemplate(value:String) { _itemTemplate = value; }
	public function get itemTemplate():String { return _itemTemplate; }
	/**
	* Gets/Sets the library's MovieClip to use as separator between items. <i>Optional</i>
	*/ 
	[Inspectable(type="string")]
	public function set separatorTemplate(value:String) { _separatorTemplate = value; }
	public function get separatorTemplate():String { return _separatorTemplate; }
	/**
	* Gets/Sets the library's MovieClip to use for the header section. <i>Optional</i>
	*/
	[Inspectable(type="string")]
	public function set headerTemplate(value:String) { _headerTemplate = value; }
	public function get headerTemplate():String { return _headerTemplate; }
	/**
	* Gets/Sets the library's MovieClip to use for the footer section. <i>Optional</i>
	*/	
	[Inspectable(type="string")]
	public function set footerTemplate(value:String) { _footerTemplate = value; }
	public function get footerTemplate():String { return _footerTemplate; }
	
	/* *** EVENTS *** */
	// TODO: define events
	
// constructor:
	function Repeater() {
		super();
		inited = false;
		this._xscale = 100;
		this._yscale = 100;
	}
	
// publich methods:
	/**
	* Binds a data source to the reapater and creates child controls based on the data source.<br/>
	* <b>Usage:</b>
	* <pre>
	* var letters = new Array("A","B","C","D","E");
	* repeater.databind(letters);
	* </pre>
	* @param data Data source Array 
	*/ 
	public function databind(data:Array):Void {
		clear();
		_dataSource = data;
		// START DATA BINDING
		// attach header
		if(_headerTemplate.length > 0) {
			header = this.attachMovie( _headerTemplate, "header", z++);
			pos += header[sizeProperty];
			// fire event
			dispatchEvent( {type:"itemcreated",item:header,itemType:"header",sender:this} );
		}
		// attach items
		var itemCount:Number = data.length;
		for(var i:Number=0; i<itemCount; i++) insertItem( data[i], i);
		// attach footer
		if(_footerTemplate.length > 0) {
			footer = this.attachMovie( _footerTemplate, "footer", z++);
			footer[posProperty] = pos;
			pos += footer[sizeProperty];
			// fire event
			dispatchEvent( {type:"itemcreated",item:footer,itemType:"footer",sender:this} );
		}
		// show repeater
		this._visible = true;
		// fire event
		dispatchEvent( {type:"databound",sender:this} );
	}	
	/**
	* Adds a data item to the data source and appends the new child control to the others.
	* <b>Usage:</b>
	* <pre>
	* var letters = new Array({"A","B","C","D","E"});
	* repeater.databind(letters);
	* // ..
	* repeater.addItem("F");
	* repeater.addItem("G");
	* repeater.addItem("H");
	* </pre>
	* @param dataItem Data obj
	*/
	public function addItem(dataItem:Object) {
		if(!inited) initVars();
		var newPos = _items.length;
		insertItem(dataItem,newPos);
		redraw(newPos-1);
		if(!this._visible) this._visible = true;
	}
	
	public function redraw(redrawStartPosition:Number):Void {
		if(!redrawStartPosition) redrawStartPosition = 0;
		// init vars
		var itemCount:Number = _items.length;							// items length
		var sizeProperty:String = (direction=="vertical")?"_height":"_width";			// the name of the size property used to calculate distance between items
		var oppositeSizeProperty:String = (direction=="vertical")?"_width":"_height";		// the name of the opposite size property
		var posProperty:String = (direction=="vertical")?"_y":"_x";				// the name of the position property to use
		var oppositePosProperty:String = (direction=="vertical")?"_x":"_y";			// the name of the opposite position property
		var pos:Number = 0;									// position
		var oppositePos:Number = 0;								// opposite axis pos
		// get the position for the first item to redraw
		if(redrawStartPosition>0) {
			pos = _items[redrawStartPosition][posProperty];
			oppositePos = _items[redrawStartPosition][oppositePosProperty];
		} else if(_headerTemplate.length > 0) {
			pos = header[sizeProperty];
		}
		// items
		for(var i:Number=redrawStartPosition; i<itemCount; i++) {
			var mc = _items[i];
			mc[posProperty] = pos;
			mc[oppositePosProperty] = oppositePos;
			pos += mc[sizeProperty];
			// check for lines
			if((_itemsPerLine > 1) && (i+1) % _itemsPerLine == 0) {
				oppositePos += mc[oppositeSizeProperty];
				pos = 0;
			}
			// separator
			if(_separatorTemplate.length > 0 && i < (itemCount-1)) {
				var sep = this["sep_"+(i+1)];
				sep[posProperty] = pos;
				pos += sep[sizeProperty];
			}
		}
		// footer
		if(_footerTemplate.length > 0) {
			footer[posProperty] = pos;
			pos += footer[sizeProperty];
		}
	}
	
	/**
	* Clears the content (items, separators, header, footer controls) and deletes the reference to the datasource.<br/>
	* The settings like itemTemplate, separatorTemplate, direction, and other properties remains.
	*/ 
	public function reset():Void {
		clear();
	}
	
// private methods:
	
	private function initVars():Void {
		_dataSource = new Array();
		_items = new Array();
		sizeProperty = (direction=="vertical")?"_height":"_width";			// the name of the size property used to calculate distance between items
		oppositeSizeProperty = (direction=="vertical")?"_width":"_height";		// the name of the opposite size property
		posProperty = (direction=="vertical")?"_y":"_x";				// the name of the position property to use
		oppositePosProperty = (direction=="vertical")?"_x":"_y";			// the name of the opposite position property
		pos = 0;									// position
		oppositePos = 0;								// opposite axis pos
		z = 1;										// depth counter
		_selectedItem = undefined							// selected item
		inited = true;
	}
	
	private function insertItem(dataItem:Object,position:Number):Void {
		// attach separator for previous item
		if(_separatorTemplate.length > 0 && position > 0) {
			var sep = this.attachMovie( _separatorTemplate, "sep_"+position, z++);
			sep[posProperty] = pos;
			pos += sep[sizeProperty];
			// fire event
			dispatchEvent( {type:"itemcreated",item:sep,itemType:"separator",sender:this} );
		}
		// attach item
		var mc = LuminicBox.UI.RepeaterItem(this.attachMovie( _itemTemplate, "item_"+position, z++));
		mc.itemPosition = position;
		mc.databind( dataItem );
		// set item position & calculate position for next item
		mc[posProperty] = pos;
		mc[oppositePosProperty] = oppositePos;
		// fire event
		dispatchEvent( {type:"itemcreated",item:mc,itemType:"item",itemPosition:position,sender:this} );
		// subscribe to item events
		mc.addEventListener("ALL", this, "onItemEvent");
		pos += mc[sizeProperty];
		// check for lines
		if((_itemsPerLine > 1) && (position+1) % _itemsPerLine == 0) {
			oppositePos += mc[oppositeSizeProperty];
			pos = 0;
		}
		// add items to inner collection
		_items.push(mc);
	}
		
	private function clear():Void {
		this._visible = false;
		_dummy._width = 0;
		_dummy._height = 0;	
		header.removeMovieClip();
		footer.removeMovieClip();
		for(var i=0; i<_items.length; i++) {
			this["item_"+i].removeMovieClip();
			this["sep_"+i].removeMovieClip();
		}
		// init vars
		initVars();
	}
	
	private function onItemEvent(e):Void {
		//if(e.type == "itemclick") selectedItem = e.item;
		if(e.type == "redraw") redraw(e.item.itemPosition);
		e.sender = this;
		this.dispatchEvent( e );
	}
		
}

/*
* Sat Apr 02 13:55:24 2005
* 	IRepeater interface has been removed
* Mon Mar 07 16:43:17 2005
* 	redraw() method is now public
* 	fixed a redraw bug involving the first separator item
* Wed Jan 19 18:31:38 2005
* 	changed insertItem sequence order, the event is now dispatched before calculating position and size
* 	add $version static var
* Wed Dec 15 10:59:25 2004
* 	fixed selectedItem not getting reseted on reset() and new databind()
* Sat Nov 13 00:47:07 2004
* 	fixed redraw when using addITem (now forcing redraw from the two last items)
* Sun Nov 07 13:39:40 2004
* 	fixed addItem bug (replacing previous items added with addItem())
* 	fixed clear bug (not clearing items added with addItem())
* Tue Sep 07 00:29:26 2004
* 	class documentation 
* 	removed internal log obj
* Thu Aug 05 00:36:18 2004
* 	added redraw functionability
* Sun Aug 08 14:25:12 2004
* 	added addItem & insertItem
* 	added function for internal vars initiation
* 	changed separator creation behavior
*/