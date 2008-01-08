/*
 * Copyright (c) 2005 Pablo Costantini (www.luminicbox.com). All rights reserved.
 * 
 * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.mozilla.org/MPL/MPL-1.1.html
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
import com.gskinner.net.GDispatcher;

/*
 * Class: LuminicBox.Core.EventBroadcaster
 * 
 * Provides event notification. It's based on on GDispatcher by Grant Skinner (http://www.gskinner.com/blog/archives/000027.html)
 * 
 * Example:
 * (begin example)
 *	import LuminicBox.Core.EventBroadcaster;
 *
 *	class ItemCollection extends EventBroadcaster {
 *
 *		private var _items:Array;
 *
 *		public function EventBroadcaster() {
 *			super();
 *			_items = new Array();
 *		}
 *
 *		public function addSomething(newItem:Object):Void {
 *			_items.push(newItem);
 *			dispatchEvent( {type:"itemAdded",item:newItem,target:this} );
 *		}
 *
 *		public function clear():Void {
 *			dispatchEvent( {type:"itemsCleared"} );
 *		}
 *
 *	}
 *
 *	// ..
 *
 *	var collection:ItemCollection = new ItemCollection();
 *	collection.addEventListener("itemAdded", this, "collection_onItemAdded");
 *	collection.addEventListener("itemsCleared", this, "collection_onItemsCleared");
 *
 *	collection.addItem( {firstname:"Pablo", lastname:"Costantini", occupation:"Developer"} );
 *	collection.addItem( {firstname:"John", lastname:"Doe", occupation:"Crash Test Dummy"} );
 *	collection.clear();
 *
 *	function collection_onItemAdded(e) {
 *		trace("---");
 *		trace("item added");
 *		trace(e.item.firstname + " " + e.item.lastname);
 *	}
 *	function collection_onItemsCleared(e) {
 *		trace("---");
 *		trace("items cleared!");
 *	}
 * (end)
 * 
 */
class LuminicBox.Core.EventBroadcaster {
	
// Group: Constructor
	/*
	 * Constructor: EventBroadcaster
	 * 
	 * Initializes de event broadcaster.
	 * 
	 * Uses GDispatcher internally: <http://www.gskinner.com/blog/archives/2003/09/gdispatcher_bug.html>
	 * 
	 */
	function EventBroadcaster() {
		GDispatcher.initialize(this);
	}
	

// Group: Public Functions
	/*
	 * Function: dispatchEvent
	 * 
	 * Broadcasts an event.
	 * 
	 * Parameters:
	 * 	e - Object. The event's type is defined within the 'type' field of the event object
	 * 
	 * See also:
	 * 	GDispatcher usage: <http://www.gskinner.com/blog/archives/000027.html>
	 */
	function dispatchEvent() {}
	
	/*
	 * Function: addEventListener
	 * 
	 * Adds an observer to object's events.
	 * 
	 * Parameters:
	 * 	type - String. The event's type you want to subscribe to.
	 * 		You can also pass 'ALL' for subscribing to any event.
	 * 	listener - Object. A reference to the listener.
	 * 	handler - String (optional). The name of the function to call.
	 * 
	 * See also:
	 * 	GDispatcher usage: <http://www.gskinner.com/blog/archives/000027.html>
	 */
	function addEventListener() {}
	
	/*
	 * Function: dispatchEvent
	 * 
	 * Removes an event listener.
	 * 
	 * Parameters:
	 * 	Same as addEventListener.
	 * 
	 * 	type - String. The event's type you want to subscribe to.
	 * 		You can also pass 'ALL' for subscribing to any event.
	 * 	listener - Object. A reference to the listener.
	 * 	handler - String (optional). The name of the function to call.
	 * 
	 * See also:
	 * 	GDispatcher usage: <http://www.gskinner.com/blog/archives/000027.html>
	 */
	function removeEventListener() {}
	
	/*
	 * Function: removeAllEventListeners
	 * 
	 * Removes all event listeners from the dispatcher .
	 * 
	 * See also:
	 * 	GDispatcher usage: <http://www.gskinner.com/blog/archives/000027.html>
	 */
	function removeAllEventListeners() {}
	
}