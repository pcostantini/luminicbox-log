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
 * swWindow Tray intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class screenweaver.window.Tray
{
	public function disable(Void) : Void;	public function enable(Void) : Void;	public function removeIcon(Void) : Void;	public function setIcon(p_sIconPath : String, p_sHint : String) : Void;
}