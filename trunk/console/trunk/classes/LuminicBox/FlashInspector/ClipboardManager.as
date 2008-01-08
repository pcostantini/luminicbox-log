import LuminicBox.Utils.StringUtility;
import LuminicBox.FlashInspector.LogEventCollection;

class LuminicBox.FlashInspector.ClipboardManager {
	
	public static function saveToClipboard(o:Object) {
		var s:String = analize(o,0);
		System.setClipboard(s);
	}
	
	public static function saveCollectionToClipboard(events:LogEventCollection) {
		var s:String = "";
		for(var i=0; i<events.length; i++) {
			s += analize( events[i].argument, 0);
			s += "\n";
		}
		System.setClipboard(s);
	}
	
	private static function analize(o,depth:Number):String {
		var type:String = o.type;
		var isStringable:Boolean = false;
		var s:String;
		switch(type) {
			// toString()
			case("undefined"):
			case("null"):
			case("string"):
			case("number"):
			case("boolean"):
			case("number"):
			case("date"):
			case("xml"):
			case("xmlnode"):
				return o.value
				break;
			case("color"):
				return o.value.toString(16);
			default:
				// open
				if(o.type == "array") {
					s = "(array:"+o.value.length+") {";
				} else if(o.type == "properties") {
					s = "{";
					o.value.reverse();
				} else if(o.id) {
					s = "(" + o.id + ") {";
				} else {
					s = "(" + o.type + ")";
				}
				
				if(o.crossRef) {
					// crossreference
					s += " *CROSS-REFERENCE*";
				} else {
					// iterate
					for(var i=0; i<o.value.length; i++) {
						var subO = o.value[i];
						s += "\n" + StringUtility.multiply("\t",depth+1);
						if(subO.value.type == "properties") {
							s += "(properties) ";
						} else {
							s += subO.property + ": ";
						}
						s += analize(subO.value, depth+1);
					}
				}
				
				// close
				if(o.value.length > 0 && !o.crossRef) {
					s += "\n" + StringUtility.multiply("\t",depth);
				} else {
					s += " ";
				}
				s += "}";
				
				break;
		}
		return s;
	}
	
}