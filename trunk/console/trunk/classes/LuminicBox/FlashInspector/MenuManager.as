class LuminicBox.FlashInspector.MenuManager {
	
	private static var _items:Array = new Array();
	
	public static function getItems():Array { return _items; }
	
	public static function getMenu():ContextMenu {
		var menu:ContextMenu = new ContextMenu();
		menu.hideBuiltInItems();
		menu.customItems = _items.slice(0);
		return menu;
	}
	
}

/*
 * Group: Changelog
 * 
 * Wed Nov 16 21:30:18 2005:
 *  - first version
 * 
 */