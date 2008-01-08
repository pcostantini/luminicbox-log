import com.gskinner.net.GDispatcher;
/**
* @class Configuration
* @tooltip No description available.
* @author LuminicBox
* @version N/A
* @see XML
* @see LuminicBox.Core.Framework
*/
class LuminicBox.Core.Configuration extends XML {

// GDispatch implementation
	function dispatchEvent() {}
	function addEventListener() {}
	function removeEventListener() {}
	function removeAllEventListeners() {}

// methods:
	function Configuration(source:String) {
		super(source);
		this.ignoreWhite = true;
		GDispatcher.initialize(this);
	}

	/**
	* @method getGroup	* @param key (String) key parameter.
	* @return LuminicBox.PortalServices.Core.Configuration
	*/
	function getGroup(id:String):Configuration {
		for (var i:Number=0;i<this.firstChild.childNodes.length;i++){
			var currentNode:XMLNode = this.firstChild.childNodes[i];
			if ((currentNode.nodeName == "config")&&(currentNode.attributes["id"]==id)) {
				var group = new Configuration();
				group.parseXML(currentNode.toString());
				return group;
			}
		}
		return undefined;
	}

	/**
	* @method getKey
	* @param key (String) key parameter.
	* @return String
	*/
	function getKey(key:String):String {
		for (var i:Number=0;i<this.firstChild.childNodes.length;i++){
			var currentNode:XMLNode = this.firstChild.childNodes[i];
			if ((currentNode.nodeName == "item")&&(currentNode.attributes["key"]==key)){
				return LuminicBox.Utils.StringUtility.htmlDecode(currentNode.attributes["value"]);
			}
		}
		return undefined;
	}
	
	/**
	* @method toObject
	* @return Object
	*/
	function toObject():Object{
		var o:Object = new Object;
		for (var i:Number=0;i<this.firstChild.childNodes.length;i++){
			var currentNode:XMLNode = this.firstChild.childNodes[i];
			if (currentNode.nodeName == "item"){
				o[currentNode.attributes["key"]] = LuminicBox.Utils.StringUtility.htmlDecode(currentNode.attributes["value"]);
			} else if (currentNode.nodeName == "config"){
				o[currentNode.attributes["id"]] = this.getGroup(currentNode.attributes["id"]).toObject();
			}
		}
		return o;
	}
	
	private function onLoad(success:Boolean) {
		if(success && status == 0) {
			// LOAD!
			dispatchEvent({type:"load"});
		} else {
			// ERROR!
			if(!success) {
				dispatchEvent({type:"error",message:"error loading xml file"});
			} else {
				dispatchEvent({type:"error",message:"error parsing xml file",errorCode:status});
			}
		}
	}

// events:

}

// ** END LuminicBox.PortalServices.Core.Configuration ***************************************************