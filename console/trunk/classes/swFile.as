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
 * swFile intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class swFile
{
	static public function copyFile(p_sSourceFile : String, p_sDestFile : String, p_bOverWriting : Boolean,	p_sCreatingPath : Boolean, p_fCallback : Function, p_oScope) : Void
	static public function createDirectory(p_sPath : String, p_fCallback : Function, p_oScope) : Void
	static public function createShortcut( p_sLabel : String, p_sLocation : String,	p_sTargetPath : String, p_sArguments : String, p_sIconPath : String, p_nIconNumber : Number, p_fCallback : Function, p_oScope) : Void
	static public function createProjector(p_sFlashPlayerPath : String, p_sFlashMoviePath : String,	p_sOutputPath : String, p_fCallback : Function, p_oScope) : Void									
}