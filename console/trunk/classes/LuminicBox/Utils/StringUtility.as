/*
 * Copyright (c) 2005 Pablo Costantini (www.luminicbox.com). All rights reserved.
 * 
 * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.mozilla.org/MPL/MPL-1.1.html
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * Class: LuminicBox.Utils.StringUtility
 * 
 * Helper class for string manipulation
 * 
 */
class LuminicBox.Utils.StringUtility {
	
// Group: NO Constructor
	private function StringUtility() { }
	
// Group: Static Public Functions
	/*
	 * Static Function: multiply
	 * 
	 * Duplicates a given string for the amount of given times.
	 * 
	 * Parameters:
	 * 	str - String. String to duplicate.
	 * 	n - Number. Amount of times to duplicate the provided string.
	 */
	public static function multiply(str:String, n:Number):String {
		var ret:String = "";
		for(var i=0;i<n;i++) ret += str;
		return ret;
	}
	
	/*
	 * Static Function: replace
	 * 
	 * String replacement function. These implementation causes some perform penalties.
	 * 
	 * Parameters:
	 * 	string - String. Original string
	 * 	oldValue - String. A string to be replaced
 	 * 	newValue - String. A string to replace all occurrences of oldValue.
	 */
	public static function replace(string:String, oldValue:String, newValue:String):String {
		return string.split(oldValue).join(newValue);
	}
	
	/*
	 * Static Function: htmlEncode
	 * 
	 * Escapes special characters into HTML
	 * 
	 * Parameters:
	 * 	str - String. Original string
	 */
	public static function htmlEncode(str:String):String {
		str = str.split("&").join("&amp;");
		str = str.split("\"").join("&quot;");
		str = str.split("'").join("&apos;");
		str = str.split("<").join("&lt;");
		str = str.split(">").join("&gt;");
		return str;
	}

	/*
	 * Static Function: htmlDecode
	 * 
	 * Unescapes special characters into HTML
	 * 
	 * Parameters:
	 * 	str - String. Original string
	 */
	public static function htmlDecode(str:String):String {
		str = str.split("&amp;").join("&");
		str = str.split("&quot;").join("\"");
		str = str.split("&apos;").join("'");
		str = str.split("&lt;").join("<");
		str = str.split("&gt;").join(">");
		str = str.split("&aacute;").join("á");
		str = str.split("&eacute;").join("é");
		str = str.split("&iacute;").join("í");
		str = str.split("&oacute;").join("ó");
		str = str.split("&uacute;").join("ú");
		str = str.split("&ntilde;").join("ñ");
		return str;
	}
	
	/*
	 * Static Function: trim
	 * 
	 * Removes space characters from both end of a string.
	 * 
	 * Parameters:
	 * 	s - String. String to trim
	 */
	public static function trim(s):String {
	    var mx:Number;
	    var i;
		for (mx = s.length; mx > 0; --mx) {
			if (ord(s.substring(mx, 1))>32) break;
		}
		for (i = 1; i < mx; ++i) {
			if (ord(s.substring(i, 1))>32) break;
		}
		return s.substring(i, mx + 1 - i);
	}
	
}