/*
 * Class: LuminicBox.UI.RepeaterItem
 * 
 * 
 * This is an abstract class that implements the basic logic for making a Repeater item.
 * 
 * *ALL REPEATER ITEMS MUST IMPLEMENT THIS CLASS.*
 * 
 * The basic function are:
 * 	- *databind* method. Saves a reference to the item's data
 * 	- event dispatching capabilities. All events are broadcasted to the Repeater and back to the Repeater's observers.
 * 
 * See also:
 * 	- <LuminicBox.UI.Repeater>
 */
class LuminicBox.UI.RepeaterItem extends LuminicBox.UI.BaseComponent {
	
// Group: Properties
	/*
	 * Property: dataItem
	 * 
	 * Gets the data for this item.
	 */
	function get dataItem():Object { return __dataItem; }
	
	/*
	 * Field: itemPosition
	 * 
	 * Gives the item position within the repeater.
	 */
	var itemPosition:Number;

// Group: Public Functions	
	/*
	 * Function: databind
	 * 
	 * Saves a reference of the item's data and calls the *init* method.
	 */
	function databind(o:Object):Void {
		__dataItem = o;
		init();
	}

	/*
	 * Function: init
	 * 
	 * 
	 * The method must be overrided and should change the item's look.
	 * 
	 * Any process to the data should be executed here.
	 * 
	 * Use *dataItem* property to access the item's data.
	 * 
	 * Usage:
	 * (begin example)
	 * function init():Void {
	 *		txtLink.text = dataItem.title;
	 *		this.onRelease = function() { getURL(this.dataItem.url); }
	 * }
	 * (end)
	 */
	function init():Void { }	

// Group: Constructor
	/*
	 * Constructor: RepeaterItem
	 * 
	 * Calls the <LuminicBox.UI.BaseComponent> constructor
	 */
	function RepeaterItem() { super(); }
	
// Group: Private implementation
	private var __dataItem:Object;
	private function dispatchEvent(e:Object) {
		e.itemType = "item";
		if(!e.item) e.item = this;
		super.dispatchEvent( e );
	}
	
	
}


/*
 * Group: Changelog
 * 
 * Wed Apr 27 18:43:41 2005:
 * 	- RepeaterItem can now be used directly as a MovieClip class.
 * 	- changed documentation format into NaturalDocs.
 * 
 * Sat Apr 02 13:55:24 2005:
 * 	- IRepeater interface has been removed.
 * 
 * Wed Sep 08 00:43:02 2004:
 * 	- class documentation.
 * 
 * Thu Aug 05 00:34:38 2004:
 * 	- added itemPosition property.
 * 	- added dispatchEvent function, adds common properties to the event obj.
 */