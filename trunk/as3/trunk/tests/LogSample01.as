/*
 * Copyright(c) 2007 Pablo Costantini and Mark Walters. All rights reserved.
 * http://code.google.com/p/luminicbox-log/
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
package
{
	import flash.display.Sprite;
	
	/**
	 * LuminicBox.Log
	 * @author Pablo Costantini ( http://www.luminicbox.com )
	 * @author Mark Walters ( http://www.digitalflipbook.com )
	 * 
	 * Example #1
	 * Using TracePublisher
	 */	
	public class LogSample01 extends Sprite
	{
		public function LogSample01()
		{	 
			// import com.luminicbox.log classes
			import com.luminicbox.log.*;
			// create logger instance
			var log:Logger = new Logger( "sample#1" );
			// add TracePublisher
			log.addPublisher( new TracePublisher() );
			
			// sending log messages
			log.debug( "this is a debug message" );
			log.info( "this is an info message" );
			
			// inspecting objs
			var o = new Object();
			o.paramString = "Hello World";
			o.paramNum = 8;
			o.paramDate = new Date();
			
			log.debug(o);
			
			var nestingObj = new Object();
			nestingObj.nestedObj = o;
			nestingObj.paramArray = new Array( "One", "Two", "Three", "Four", "Five" );
			
			log.debug( nestingObj );
			
			// inspecting movieclips
			log.debug( root );
		}
	}
}
