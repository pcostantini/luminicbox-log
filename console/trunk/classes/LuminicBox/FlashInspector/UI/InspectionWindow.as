import LuminicBox.Log.LogEvent;

class LuminicBox.FlashInspector.UI.InspectionWindow extends MovieClip {
	
	private var txtData:TextField;
	private var scrollbar:MovieClip;
	
	public function InspectionWindow() {
		txtData.text = "";
		txtData.embedFonts = true;
		txtData.backgroundColor = 0xEEEEEE;
		txtData.borderColor = 0xCCCCCC;
	}
	
	public function bind(argument:Object) {
		var sType = argument.type;
		if(sType == "xml" || sType == "xmlnode") {
			var xml = new XML();
			xml.ignoreWhite = true;
			xml.parseXML(argument.value.toString());
			txtData.htmlText = XMLHighlighter.highlight( xml );
		} else {
			txtData.text = argument.value.toString();
		}
	}
	
	public function setSize(w:Number, h:Number) {
		txtData._width = w - 13 - scrollbar._width;
		txtData._height = h - 30 - 1;
		scrollbar._x = txtData._width + txtData._x;
		scrollbar.setSize(h - 30, scrollbar._width);
	}
	
}