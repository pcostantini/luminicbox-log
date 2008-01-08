class LuminicBox.UI.CheckBox extends LuminicBox.UI.BaseComponent {
	
	[Inspectable(type="Boolean",defaultValue="false")]
	public function set checked(value:Boolean) {
		_checked = value;
		gotoAndStop( (value)?"checked":"unchecked" );
	}
	public function get checked():Boolean { return _checked; }
	
// Group: Constructor
	public function CheckBox() {
		super();
		this._xscale = 100;
		this._yscale = 100;
	}
	
	
// Group: Private implementation
	private var tilde:MovieClip;
	private var _checked:Boolean;
	
	private var clipParameters:Object = { checked:1 };
	
	private function onRelease():Void {
		checked = !checked;
		dispatchEvent( {type:"click"} );
	}

	
}