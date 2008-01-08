class LuminicBox.FlashInspector.UI.LogEventItem extends LuminicBox.FlashInspector.UI.LogInspectionItem {
	
	private static var _levelColors:Object = {LOG:0x999999, DEBUG:0x0066CC, INFO:0x009999, WARN:0xFF9900, ERROR:0xFF6600, FATAL:0xFF0000};
	
	private var txtLevel:TextField;
	
	private function init():Void {
		super.init();
		txtLevel.textColor = _levelColors[dataItem.level.getName()];
		txtLevel.text = dataItem.level.getName();
		showBg = (itemPosition%2!=0);
	}
	
	private function getObj():Object {
		return dataItem.argument;
	}
	
}

/*
 * Group: Changelog
 * 
 * Tue Jul 19 01:59:05 2005:
 * 	- removed getLevelColors() method, replaced with _levelColors static var
 * 
 * Tue Apr 26 01:10:26 2005:
 * 	- showBg is now called within init() method
 * 
 */