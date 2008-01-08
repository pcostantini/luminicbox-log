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
 * swSystem Plugins intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class screenweaver.system.Plugins
{
	public function load(p_sPluginId : String) : Void;	public function loadByFile(p_sFilename : String) : Void;	public function register(p_sPluginPath : String) : Void;	public function unregister(p_sPluginPath : String) : Void;
}