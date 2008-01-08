import LuminicBox.FlashInspector.*;
import LuminicBox.FlashInspector.UI.*;
import LuminicBox.Log.*;
import LuminicBox.UI.*;
import LuminicBox.Utils.Delay;
import LuminicBox.User.*
import mx.utils.Delegate;

class LuminicBox.FlashInspector.UIController {

// Group: Private vars
	// constants
	private var _minWidth:Number = 450;
	private var _minHeight:Number = 350;
	// internal vars
	private var log:Logger;
	private var _logReciever:LogReciever;
	private var _level:Level;
	private var _settings:ISettings;
	private var _projector:ProjectorController;
	
// Group: Private MovieClips & Components
	// ui mcs
	private var mcRoot:MovieClip;
	private var mcGradient:MovieClip;
	private var mcBackground:MovieClip;
	private var mcCorner:MovieClip;
	// components
	private var uiDisabler:UIDisabler;
	private var tabBox:TabBox;
	private var eventWindow:EventWindow;
	private var statusBar:StatusBar;
	private var activeWindow:Window;
	private var controlBox:ControlBox;
	
// Group: Constructor
	public function UIController(mcRoot:MovieClip, logReciever:LogReciever) {
		log = new Logger("FI:UIController");
		log.addPublisher( new TracePublisher() );
		log.setLevel( Level.NONE );
		log.info("cstr()");
		// setup logReceiver
		_logReciever = logReciever;
		_logReciever.onLogEvent = Delegate.create(this, logReciever_onLogEvent);
		_logReciever.onError = Delegate.create(this, logReciever_onError);
		// projector
		_projector = ProjectorController.getInstance();
		// read settings
		_settings = new SettingsSO("FISettings");
		if(_projector != null && _settings.get("window_remember")) {
			var settingsPos = _settings.get("window_position");
			if(settingsPos != undefined) _projector.setPosition(settingsPos.x, settingsPos.y);
			var settingsSize = _settings.get("window_size");
			if(settingsSize != undefined) _projector.setSize(settingsSize.width, settingsSize.height);
			if(_settings.get("window_ontop")) toggleOnTop();
		}
		// setup stage
		Stage.scaleMode = "noScale";
		Stage.align = "TL";
		Stage.addListener(this);
		// save references
		this.mcRoot = mcRoot;
		mcGradient = mcRoot.mcGradient;
		mcBackground = mcRoot.mcBackground;
		mcCorner = mcRoot.mcCorner;
		controlBox = mcRoot.controlBox;
		tabBox = TabBox(mcRoot.tabBox);
		eventWindow = EventWindow(mcRoot.eventWindow);
		statusBar = StatusBar(mcRoot.statusBar);
		// component event handlers
		eventWindow.addEventListener("eventInfo", this, "onEventInfo")
		eventWindow.addEventListener("eventInfoOut", this, "onEventInfoOut")
		eventWindow.addEventListener("eventInspect", this, "onEventInspect")
		tabBox.addEventListener("tabChange", this, "mcTabBox_onTabChange");
		controlBox.onClear = Delegate.create(this, controlBox_onClear);
		controlBox.onTogglePause = Delegate.create(this, controlBox_onTogglePause);
		controlBox.onToggleOnTop = Delegate.create(this, controlBox_onToggleOnTop);
		controlBox.allowOnTop = (ProjectorController.getInstance() != null);
		statusBar.onHelp = Delegate.create(this, statusBar_onHelp);
		statusBar.onAbout = Delegate.create(this, statusBar_onAbout);
		statusBar.onSettings = Delegate.create(this, statusBar_onSettings);
		// menu
		MenuManager.getItems().push( new ContextMenuItem("Clear", Delegate.create(this, menu_onClear)) );
		MenuManager.getItems().push( new ContextMenuItem("Copy All", Delegate.create(this, menu_onCopyAll)) );
		var cMenu = MenuManager.getMenu();
		//cMenu.onSelect = Delegate.create(this, menu_onOpen);
		mcRoot.menu = cMenu;
		// create other objs
		uiDisabler = UIDisabler.create( mcRoot );
		// 1st time setup
		onResize();
		tabBox.selectedTab = "ALL";
		_level = Level.ALL;
		connectLog();
	}
	
	public function togglePause():Void {
		if(_logReciever.isPaused) {
			_logReciever.resume();
		} else {
			_logReciever.pause();
		}
		controlBox.setPause(_logReciever.isPaused);
	}
	
	public function toggleOnTop():Void {
		var projector = ProjectorController.getInstance();
		var isTopMost:Boolean = projector.toogleAlwaysOnTop();
		controlBox.setOnTop(isTopMost);
		_settings.set("window_ontop", isTopMost);
	}
	
	public function clear():Void {
		statusBar.reset();
		eventWindow.clear();
		_logReciever.logEvents.clear();
	}
	
	public function copyItemToClipboard():Void {
		log.info("copyItemToClipboard()");
		if(LogInspectionItem.activeItem != null) ClipboardManager.saveToClipboard( LogInspectionItem.activeItem.getObj() );
	}
	
	public function copyAllToClipboard():Void {
		log.info("copyAllToClipboard()");
		ClipboardManager.saveCollectionToClipboard( _logReciever.logEvents.getByLevel(_level) );
	}

// Group: Private functions
	private function connectLog():Void {
		if(!_logReciever.connect()) {
			// halt
			uiDisabler.enabled = true;
			var win = Window.createWindow(mcRoot, 260, 90, "WarningWindow");
			win.onClose = Delegate.create(this, connectLog);
		} else {
			uiDisabler.enabled = false;
			setUserInputEnabled(true);
		}
	}
	
	private function setUserInputEnabled(enabled:Boolean):Void {
		if(enabled) {
			Key.addListener(this);
			Mouse.addListener(this);
		} else {
			Key.removeListener(this);
			Mouse.removeListener(this);
		}
	}
	
// Group: UserInput handlers
	//private function
	private function onKeyDown() {
		if(Key.isDown(67)) {
			// C key
			if(Key.isDown(Key.SHIFT)) {
				copyAllToClipboard();		// ALL
			} else {
				copyItemToClipboard();		// ITEM
			}
		} else
		if(Key.isDown(80)) {
			// P key
			togglePause();
		} else
		if(Key.isDown(Key.DELETEKEY)) {
			// CLEAR
			clear();
		} else
		if(Key.getCode() >= 49 && Key.getCode <= 54) {
			// 1, 2, 3, 4, 5, 6
			var level;
			switch(Key.getCode()) {
				case(49):
					_level = LuminicBox.Log.Level.ALL;
					break;
				case(50):
					_level = LuminicBox.Log.Level.DEBUG;
					break;
				case(51):
					_level = LuminicBox.Log.Level.INFO;
					break;
				case(52):
					_level = LuminicBox.Log.Level.WARN;
					break;
				case(53):
					_level = LuminicBox.Log.Level.ERROR;
					break;
				case(54):
					_level = LuminicBox.Log.Level.FATAL;
					break;
				}
			tabBox.selectedTab = _level.getName()
			eventWindow.populate( _logReciever.logEvents.getByLevel(_level) );
		} else 
		// SCROLL
		if(Key.isDown(Key.UP)) {
			eventWindow.scrollLine(1);
		} else 
		if(Key.isDown(Key.DOWN)) {
			eventWindow.scrollLine(-1);
		} else 
		if(Key.isDown(Key.PGUP)) {
			eventWindow.scrollPage(1);
		} else 
		if(Key.isDown(Key.PGDN)) {
			eventWindow.scrollPage(-1);
		} else 
		if(Key.isDown(Key.HOME)) {
			eventWindow.scrollToTop();
		} else 
		if(Key.isDown(Key.END)) {
			eventWindow.scrollToBottom();
		}
	}
	
	private function onMouseWheel(delta,scrollTarget) {
		eventWindow.scrollLine(delta);
	}

	
// Group: UI & Components Event Handlers
	private var _saveSizeDelay:Delay;
	private function onResize():Void {
		var w = Stage.width;
		var h = Stage.height
		var l = false;
		if(w<_minWidth) { w=_minWidth; l=true; }
		if(h<_minHeight) { h=_minHeight; l=true; }
		// stage
		mcGradient._width = w;
		mcBackground.setSize(w-10,h-54);
		controlBox._x = w-Math.round(controlBox._width)-10;
		mcCorner._visible = l;
		if(l) {
			mcCorner._x = Stage.width-2;
			mcCorner._y = Stage.height-2;
		}
		// components
		eventWindow.setSize(w-26,h-84);
		statusBar._y = h-statusBar._height;
		statusBar.setWidth(w-16);
		// activeWindow
		if(activeWindow && activeWindow.getContent() instanceof InspectionWindow) activeWindow.setSize(w-50, h-100);
		// save settings
		if(_settings.get("window_remember")) {			
			_saveSizeDelay.cancel();
			_saveSizeDelay = new Delay(250, this, saveSize);
		}
	}
	private function saveSize():Void {
		delete _saveSizeDelay;
		if(_projector != null) {
			_settings.set("window_size", _projector.getSize());
			_settings.set("window_position", _projector.getPosition());
		}
	}
	
	//private function menu_onOpen(obj:Object, menu:ContextMenu):Void {}
	
	private function menu_onCopyAll(obj:Object, menu:ContextMenu):Void { copyAllToClipboard(); }
	
	private function menu_onClear(obj:Object, menu:ContextMenu):Void { clear(); }
	
	private function onEventInspect(e):Void {
		// halt
		uiDisabler.enabled = true;
		activeWindow = Window.createWindow(mcRoot, 250, 105, "InspectionWindow");
		activeWindow._visible = false;
		activeWindow.onClose = Delegate.create(this, activeWindow_onClose);
		activeWindow.getContent().bind( e.argument );
		// TODO: find a better way to do this :X
		new Delay(10, this, onResize);
		new Delay(15, this, function() { activeWindow._visible = true; });
	}
	
	private function onEventInfo(e):Void {
		statusBar.databind( e.argument );
	}
	
	private function onEventInfoOut():Void {
		statusBar.reset();
	}
	
	private function mcTabBox_onTabChange(e):Void {
		_level = eval("LuminicBox.Log.Level." + e.label.toUpperCase());
		eventWindow.populate( _logReciever.logEvents.getByLevel(_level) );
	}
	
	private function controlBox_onClear():Void { clear(); }
	
	private function controlBox_onTogglePause():Void { togglePause(); }
	
	private function controlBox_onToggleOnTop():Void { toggleOnTop(); }
	
	private function statusBar_onHelp():Void {
		uiDisabler.enabled = true;
		activeWindow = Window.createWindow(mcRoot, 370, 190, "HelpWindow");
		activeWindow.onClose = Delegate.create(this, activeWindow_onClose);

	}
	
	private function statusBar_onAbout():Void {
		uiDisabler.enabled = true;
		activeWindow = Window.createWindow(mcRoot, 300, 165, "AboutWindow");
		activeWindow.onClose = Delegate.create(this, activeWindow_onClose);
	}
	
	private function statusBar_onSettings():Void {
		uiDisabler.enabled = true;
		activeWindow = Window.createWindow(mcRoot, 310, 140, "SettingsWindow");
		activeWindow.onClose = Delegate.create(this, activeWindow_onClose);
		
		activeWindow.getContent().settings = _settings;
		activeWindow.getContent().onToggleOnTop = Delegate.create(this, controlBox_onToggleOnTop)
		//controlBox.onToggleOnTop = Delegate.create(this, controlBox_onToggleOnTop);
	}
	
	private function activeWindow_onClose() {
		uiDisabler.enabled = false;
		delete activeWindow;
	}
	
// Group: LogReciever Event Handlers
	private function logReciever_onLogEvent(event:LogEvent) {
		if(_level.getValue() <= event.level.getValue()) {
			eventWindow.addItem(event);
		}
	}
	
	private function logReciever_onError(error):Void {
		log.error("logReciever.onError");
		log.error(error);
	}
		
	
}