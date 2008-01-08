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
 * swApplication intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class swApplication
{
	static public function call( p_nWinId, p_sFunction : String, p_aArgs : Array, p_fCallback : Function, p_oScope) : Void	static public function closeWindow(p_nWinId) : Void	static public function createWindow(p_oSetting : Object, p_fCallback  : Function, p_oScope) : Void	static public function getActiveWindowId(Void) : Number	static public function getActiveWindowHandle(Void) : Number	static public function getCmdLineArg(Void) : String	static public function getCmdLineArgCount(Void) : Number	static public function getFilePath(p_sFile : String) : String	static public function getPlayerPath(p_sFile : String) : String	static public function getWindowId(Void) : Number	static public function hideWindow(p_nWindId) : Void	static public function loadMovie(p_nWinId, p_nFilename : String, p_nLevel : Number, p_fCallback : Function, p_oScope) : Void	static public function quit(Void) : Void	static public function send(p_nWinId, p_oData, p_fCallback : Function, p_oScope) : Void	static public function setForegroundWindow(p_nId) : Void	static public function showWindow(p_nWinId) : Void	static public function toggleWindowVisibility(p_nWinId) : Void
}