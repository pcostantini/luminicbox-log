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
 * swSystem Registry intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class screenweaver.system.Registry
{
	public function read(p_sRootKey : String, p_sSubKey : String, p_sKeyName : String, p_fCallback : Function, p_oScope) : Void;	public function removeKey(p_sRootKey : String, p_sSubKey : String, p_fCallback : Function, p_oScope) : Void;	public function removeValue(p_sRootKey : String, p_sSubKey : String, p_sKeyName : String, p_fCallback : Function, p_oScope) : Void;	public function write(p_sRootKey : String, p_sSubKey : String, p_sKeyName : String, p_sKeyValue : String, p_fCallback : Function, p_oScope) : Void;
}