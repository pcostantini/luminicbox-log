/*
Screenweaver Intrinsic API
Copyright (C) 2005 Romain Ecarnot

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
/**
 * swSystem intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class swSystem
{
	//API properties
	static public var Colors : screenweaver.system.Colors;
	static public var Dialogs : screenweaver.system.Dialogs;
	static public var Messages : screenweaver.system.Messages;
	static public var Plugins : screenweaver.system.Plugins;
	static public var Registry : screenweaver.system.Registry;	static public var Screen : screenweaver.system.Screen;
	static public var Version : screenweaver.system.Version;
	
	//API methods
	static public function getClipBoardText(p_fCallback : Function, p_oScope) : Void	static public function getComputerName(Void) : String	static public function getEnvironmentVar(p_sVar : String, p_fCallback : Function, p_oScope	) : Void	static public function getFlashPluginPath(Void) : String	static public function getMonitorModes(Void) : Void	static public function getMouse(p_fCallback : Function, p_oScope) : Void	static public function getSystemDirectory(Void) : String	static public function getUserName(Void) : String	static public function getWindowsDirectory(Void) : String	static public function registerWindowMessage(p_sMessage : String, p_fHandler : Function, p_oHandlerScope, p_fCallback : Function, p_oScope) : Void	static public function setClipboardText(p_sData : String) : Void	static public function shellEdit(p_sFilename : String, p_fCallback : Function, p_oScope) : Void	static public function shellExecute(p_sOperationId : String, p_sFilename : String, p_sParam : String, p_sWorkingFolder : String, p_nWinState : Number, p_fCallback : Function, p_oScope) : Void	static public function shellExplore(p_sFolder : String, p_fCallback : Function, p_oScope) : Void	static public function shellFind(p_sfolder : String, p_fCallback : Function, p_oScope) : Void	static public function shellMailTo(p_sAddress : String, p_sSubject : String, p_sBody : String) : Void	static public function shellOpenApplication(p_sAppPath, p_sParam : String, p_nWinState : Number, p_fCallback : Function, p_oScope) : Void	static public function shellOpenDocument(p_sFilename : String, p_fCallback : Function, p_oScope) : Void	static public function shellPrint(p_sFilename : String, p_fCallback : Function, p_oScope) : Void
}

