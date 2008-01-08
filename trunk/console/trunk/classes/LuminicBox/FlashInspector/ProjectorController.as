class LuminicBox.FlashInspector.ProjectorController {
	
	public static function getInstance():ProjectorController {
		if(_instance == null) {
			if(swApplication) _instance = new ProjectorController();
		}
		return _instance;
	}
	private static var _instance:ProjectorController = null;
	
	private var _alwaysOnTop:Boolean;
	
	private function ProjectorController() {
		_alwaysOnTop = false;
	}
	
	public function toogleAlwaysOnTop():Boolean {
		_alwaysOnTop = !_alwaysOnTop;
		swWindow.setZOrder( (_alwaysOnTop)? 1 : 0 );
		return _alwaysOnTop;
	}
	
	public function getPosition():Object { return { x:swWindow.getLeft(), y:swWindow.getTop() }; }
	
	public function setPosition(x:Number, y:Number):Void { swWindow.setPosition(x, y); }
	
	public function getSize():Object { return { width:swWindow.getWidth(), height:swWindow.getHeight() }; }
	
	public function setSize(w:Number, h:Number):Void { swWindow.setSize(w, h); }
	
	
	
}