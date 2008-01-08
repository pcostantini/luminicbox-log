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
 * Class: LuminicBox.Utils.Delay
 * 
 * 
 */
class LuminicBox.Utils.Delay {
	
// Group: Constructor
	public function Delay() {
		var delay:Number = Number(arguments.shift());
		_tId = setInterval(this, "onTimeout", delay, arguments);
	}
	
// Group: Public Functions
	public function cancel() {
		clear();
	}
	
// Group: Private implementation
	private var _tId:Number;
	
	private function onTimeout(args) {
		clear();
		var scope:Object = args.shift();
		var func:Function = Function(args.shift());
		func.apply(scope, args);
	}
	
	private function clear() {
		clearInterval(_tId);
		delete _tId;
	}
	
}