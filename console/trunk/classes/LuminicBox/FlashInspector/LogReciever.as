import LuminicBox.Log.LogEvent;
import LuminicBox.FlashInspector.LogEventCollection;

class LuminicBox.FlashInspector.LogReciever extends Object {
	
	private var _minRequiredVersion:Number = 0.1;		// the ConsolePublisher minimal required version
	private var _lc:LocalConnection;			// local connection obj
	private var _lcId:String;
	private var _isConnected:Boolean;
	private var _logEvents:LogEventCollection;
	private var _isPaused:Boolean;
	
	
	public var onError:Function;
	public var onLogEvent:Function;
	public function get isConnected():Boolean { return _isConnected; }
	public function get logEvents():LogEventCollection { return _logEvents; }
	public function get isPaused():Boolean { return _isPaused; }
	
	function LogReciever(lcId:String) {
		// create LogEventCollection
		_logEvents = new LogEventCollection();
		_lcId = lcId;
		_isConnected = false;
		_isPaused = false;
	}
	
	public function connect():Boolean {
		// create local connection obj
		if(!_lc) {
			_lc = new LocalConnection();
			_lc.allowDomain = function(domain) { return true; }
			_lc["log"] = mx.utils.Delegate.create(this, onEvent);
		}
		_isConnected = _lc.connect(_lcId);
		return _isConnected;
	}
	
	public function pause():Void {
		_isPaused = true;
	}
	
	public function resume():Void {
		_isPaused = false;
	}
	
	private function onEvent(e) {
		if(!_isPaused) {
			// check for minimal required version
			/*if(e.version >= _minRequiredVersion) {
				onError( {type:"versionMismatch",logId:e.loggerId,logVersion:e.version,minVersion:_minRequiredVersion} );
				return;
			}*/
			// save log message
			var logEvent:LogEvent = LogEvent.deserialize(e);
			_logEvents.push( logEvent );
			onLogEvent( logEvent )
		}
	}
	
}

/*
* Tue Apr 19 01:50:18 2005
* 	added isConnected() property
* 	changed event model to callbacks
*/