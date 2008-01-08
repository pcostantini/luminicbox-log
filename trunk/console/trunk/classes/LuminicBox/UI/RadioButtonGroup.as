import LuminicBox.UI.RadioButton;

class LuminicBox.UI.RadioButtonGroup extends Array {
	
// Group: properties
	public function get groupName():String { return _groupName; }
	
	public function get selectedItem():RadioButton {
		for(var i:Number=0; i<this.length; i++) {
			var radio:RadioButton = RadioButton(this[i]);
			if(radio.selected) return radio;
		}
		return undefined;
	}
	
	public function get selectedValue():Object { return selectedItem.value; }
	public function set selectedValue(value:Object) {
		for(var i:Number=0; i<this.length; i++) {
			var radio:RadioButton = RadioButton(this[i]);
			if(radio.value == value) {
				radio.selected = true;
				return;
			}
		}
	}
	
// Group: Constructor
	public function RadioButtonGroup() {
		super();
		GDispatcher.initialize(this);
	}
	
// Group: Private implementation
	public function addEventListener() {}
	public function removeEventListener() {}
	public function removeAllEventListeners() {}
	private function dispatchEvent() {}
	
	private function onItem_Click(e) {
		dispatchEvent( {type:"click",item:e.target} );
		if(e.target.selected != undefined) dispatchEvent( {type:"selectionChange",target:e.target} );
	}
	
}