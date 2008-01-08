import LuminicBox.FlashInspector.ProjectorController;

class LuminicBox.FlashInspector.UI.StatusBar extends MovieClip {
	
	private var txtInfo:TextField;
	private var txtOptions:TextField;
	
	public var onAbout:Function;
	public var onSettings:Function;
	public var onHelp:Function;
	
	public function StatusBar() {
		var css:TextField.StyleSheet = new TextField.StyleSheet();
		css.parseCSS("a {color:#BEBEBE} a:hover {color:#FFFFFF} a:active{color:#2C77A3}");
		txtOptions.styleSheet = css;
		txtOptions.textColor = 0x666666;
		var hasProjector:Boolean = (ProjectorController.getInstance() != null);
		var htmlTxt:String = '<a href="asfunction:onHelp">HELP</a> | <a href="asfunction:onAbout">ABOUT</a>';
		if(hasProjector) htmlTxt = '<a href="asfunction:onSettings">SETTINGS</a> | ' + htmlTxt;
		txtOptions.htmlText = htmlTxt;
	}
	
	public function reset() {
		txtInfo.text = "";
	}
	
	public function databind(argument) {
		var s;
		var o;
		if(argument.loggerId) {
			var time = argument.time.getHours() + ":" + argument.time.getMinutes() + ":" + argument.time.getSeconds();
			s = "LogId: " + argument.loggerId + "\t\tTime: " + time + "\n";
			o = argument.argument;
			
			//s += "Type: " + typeOf;
			//if(typeOf == "array") s += "\t\tCount: " + argument.argument.value.length;
			
		} else {
			o = argument.value;
			//s += "Type: " + typeOf;
			//if(typeOf == "array") s += "\t\tCount: " + argument.value.value.length;
			if(isNaN(argument.property)) {
				s = "Propery: " + argument.property + "\n";
			} else {
				s = "Index: " + argument.property + "\n";
			}
		}
		
		var typeOf = o.type;

		s += "Type: " + typeOf;
		if(typeOf == "array") s += " (" + o.value.length + ")";
		if(o.reachLimit) s += "\t<font color=\"#FF0000\">MaxDepth reached!</font>"
		if(o.crossRef) s += "\t<font color=\"#FF0000\">Cross-Reference detected</font>"
		
		txtInfo.htmlText = s;
	}
	
	public function setWidth(w:Number) {
		txtOptions._x = w-txtOptions._width-5;
	}
	
}