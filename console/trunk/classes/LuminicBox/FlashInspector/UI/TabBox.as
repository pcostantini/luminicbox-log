import LuminicBox.UI.Repeater;

class LuminicBox.FlashInspector.UI.TabBox extends LuminicBox.UI.BaseComponent {
		
	private var tabRepeater:Repeater;
	private var _labels:Array;
	

	[Inspectable(type="Array")]
	public function set labels(value:Array) {
		_labels = value;
		if(tabRepeater) tabRepeater.databind(value)
	}
	public function get labels():Array { return _labels; }
	
	public function set selectedTab(label:String) {
		for(var i=0; i<tabRepeater.items.length; i++) {
			if(tabRepeater.items[i].dataItem == label) {
				tabRepeater.selectedItem = tabRepeater.items[i];
				return;
			}
		}
	}
	public function get selectedTab():String { return tabRepeater.selectedItem.dataItem; }
	
	public function TabBox() {
		super();
		this._xscale = 100;
		this._yscale = 100;
		tabRepeater = Repeater(this.attachMovie("Repeater","tabRepeater",1));
		tabRepeater.direction = "horizontal";
		tabRepeater.itemTemplate = "LuminicBox.FlashInspector.UI.TabItem";
		tabRepeater.addEventListener("click", this, "tabRepeater_onClick");
		tabRepeater.databind(_labels);
	}
	
	private function tabRepeater_onClick(e) {
		if(tabRepeater.selectedItem != e.item) {
			tabRepeater.selectedItem = e.item;
			dispatchEvent( {type:"tabChange",label:e.label,index:e.item.itemPosition} );
		}
	}

	
}