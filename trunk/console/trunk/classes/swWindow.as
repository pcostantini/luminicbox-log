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
 * swWindow intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class swWindow
{
	//API properties
	static public var DragDrop : screenweaver.window.DragDrop;
	static public var Menu : screenweaver.window.Menu;
	static public var Tray : screenweaver.window.Tray;
	
	//API methods
	static public function allowCtrlA(p_bEnable : Boolean) : Void;
	static public function allowCtrlC(p_bEnable : Boolean) : Void;
	static public function allowCtrlV(p_bEnable : Boolean) : Void;
	static public function allowCtrlX(p_bEnable : Boolean) : Void;
	static public function close(Void) : Void;
	static public function freezeAlpha(Void) : Void;
	static public function getAllowClose(Void) : Boolean;
	static public function getBottom(Void) : Number;
	static public function getClientX(Void) : Number;
	static public function getClientY(Void) : Number;
	static public function getFocusedTextField(Void) : TextField;
	static public function getHeight(Void) : Number;
	static public function getLeft(Void) : Number;
	static public function getMovieFolder(Void) : String;
	static public function getMoviePath(Void) : String;
	static public function getRight(Void) : Number;
	static public function getScriptMode(Void) : Number;
	static public function getTop(Void) : Number;
	static public function getWidth(Void) : Number;
	static public function getWindowHandle(Void) : Number;
	static public function getWindowId(Void);
	static public function getWindowText(Void) : String;
	static public function hide(Void) : Void;
	static public function maximize(Void) : Void;
	static public function minimize(Void) : Void;
	static public function restore(Void) : Void;
	static public function setAllowClose(p_bEnable : Boolean) : Void;
	static public function setCursor(p_nIconId : Number) : Void;
	static public function setParent(p_WinId) : Void;
	static public function setPosition(p_nX : Number, p_nY : Number) : Void;
	static public function setSize(p_nWidth : Number, p_nHeight : Number) : Void;
	static public function setWindowText(p_sText : String) : Void;
	static public function setZOrder(p_nZID : Number) : Void;
	static public function show(Void) : Void;
	static public function startDrag(Void) : Void;
	static public function startResize(p_sDirection : String) : Void;
	static public function toggleVisibility(Void) : Void;
	static public function unFreezeAlpha(Void) : Void;
}