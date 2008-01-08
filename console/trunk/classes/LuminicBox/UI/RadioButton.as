import LuminicBox.UI.RadioButtonGroup;

class LuminicBox.UI.RadioButton extends LuminicBox.UI.BaseComponent {
	

// Group: Properties
	[Inspectable(type="string",defaultValue="radioGroup1")]
	public function set groupName(value:String) { _groupName = value; }	
	public function get groupName():String { return _groupName; }
	
	[Inspectable(type="Boolean",defaultValue="false")]
	public function set selected(value:Boolean) {
		if(value && _group.selectedItem != undefined) {
			var radio:RadioButton = RadioButton(_group.selectedItem);
			radio.selected = false;
		}
		if(value) {
			showSelected();
		} else {
			showUnselected();
		}
		_selected = value;
	}
	public function get selected():Boolean { return _selected; }
	
	[Inspectable]
	public function set value(value:Object) { _value = value; }
	public function get value():Object { return _value; }
	
	public function get group():RadioButtonGroup { return _group; }
	
// Group: Constructor
	public function RadioButton() {
		super();
		// create group
		if(_parent[_groupName] == undefined) _parent[_groupName] = new RadioButtonGroup();
		_group = _parent[_groupName];
		_group.push(this);
		this.addEventListener("click",_group,"onItem_Click");
		// init
		_inited = true;
		// set properties
		if(_selected) selected = true;
		this.onRelease = click;
	}
	
// Group: Private implementation
	private var _inited:Boolean=false;
	private var _group:RadioButtonGroup;
	private var _groupName:String;
	private var _selected:Boolean;
	private var _value:Object;
	
	private var clipParameters:Object = {
		groupName:1,
		selected:1,
		value:1
	};
	
	private function showSelected() {
		this.gotoAndPlay("checked");
	}

	private function showUnselected() {
		this.gotoAndPlay("unchecked");
	}
	
	private function click() {
		if(!_selected) selected = true;
		dispatchEvent( {type:"click"} );
	}
	
}