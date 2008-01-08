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
	static public var Registry : screenweaver.system.Registry;
	static public var Version : screenweaver.system.Version;
	
	//API methods
	static public function getClipBoardText(p_fCallback : Function, p_oScope) : Void
}
