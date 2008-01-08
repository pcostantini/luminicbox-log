import LuminicBox.User.ISettings;

class LuminicBox.User.SettingsSO implements ISettings {
	
	private var _soName:String;
	
	public function SettingsSO(soName:String) {
		_soName = soName
	}
	
	public function get(key:String) {
		return getPersistent().data[key];
	}
	
	public function set(key:String,value:Object):Void {
		var so:SharedObject = getPersistent();
		so.data[key] = value;
		so.flush();
	}

	
	private function getPersistent():SharedObject {
		var so:SharedObject = SharedObject.getLocal(_soName, "/");
		if(so.data.__hasSettings == undefined) {
			// creating new SO
			so.data.__hasSettings = true;
			so.flush();
		}
		return so;
	}
	
}