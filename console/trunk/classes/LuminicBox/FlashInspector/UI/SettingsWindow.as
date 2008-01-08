import LuminicBox.User.*
import LuminicBox.Utils.Delay;
import mx.utils.Delegate;


class LuminicBox.FlashInspector.UI.SettingsWindow extends MovieClip {
	
	private var chkOnTop:LuminicBox.UI.CheckBox;
	private var chkRememberSize:LuminicBox.UI.CheckBox;
	private var btnAccept:Button;
	private var btnCancel:Button;
	
	private var _settings:ISettings;
	
	public var onToggleOnTop:Function;
	
	public function get settings():ISettings { return _settings; }
	public function set settings(value:ISettings) {
		_settings = value;
		new Delay(50, this, init);
	}
	
	public function SettingsWindow() {
		btnAccept.onRelease = Delegate.create(this, acceptChanges);
		btnCancel.onRelease = Delegate.create(_parent, _parent.close);
	}
	
	private function init() {
		chkOnTop.checked = _settings.get("window_ontop");
		chkRememberSize.checked = _settings.get("window_remember");
	}
	
	private function acceptChanges() {
		trace("acceptChanges()");
		_settings.set("window_remember", chkRememberSize.checked);
		//_settings.set("window_ontop", chkOnTop.checked); // done with event
		if(_settings.get("window_ontop") != chkOnTop.checked) onToggleOnTop();
		_parent.close();
	}
		
}