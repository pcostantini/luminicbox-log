import LuminicBox.FlashInspector.*;

class LuminicBox.FlashInspector.Application {
	
	public static var $version:String = "0.4.1.0";
	
	public static function main(mcRoot:MovieClip):Application {
		return new Application(mcRoot);
	}
	
	private var _uiController:UIController;
	
	private function Application(mcRoot:MovieClip) {
		_uiController = new UIController(mcRoot, new LogReciever("_luminicbox_log_console") );
	}
	
	
}