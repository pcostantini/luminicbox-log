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
 * swSystem Dialog intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class screenweaver.system.Dialogs
{
	public function BrowseForFile_Open(p_Filename : String, p_aFilter : Array, p_sPath : String, p_sTitle : String, p_fCallback : Function, p_oScope) : Void;	public function BrowseForFiles_Open(p_Filename : String, p_aFilter : Array, p_sPath : String, p_sTitle : String, p_fCallback : Function, p_oScope) : Void;	public function BrowseForFile_Save(p_Filename : String, p_aFilter : Array, p_sPath : String, p_sTitle : String, p_sExtension : String, p_fCallback : Function, p_oScope) : Void;	public function BrowseForFolder(p_sTitle : String, p_fCallback : Function, p_oScope) : Void;	public function ChooseColor(p_nColor : Number, p_fCallback : Function, p_oScope) : Void;	public function ChooseFont(p_sFontName : String, p_nSize : Number, p_nColor : Number,p_bIsBold : Boolean, p_bIsItalic : Boolean, p_fCallback : Function, p_oScope) : Void;
}