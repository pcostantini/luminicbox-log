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
 * swInterface intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class swInterface
{
	static public function callComMethod(p_sMethod : String, p_oArguments, p_fCallback : Function, p_oScope) : Void	static public function callDLLMethod (p_sDLL : String, p_sMethod : String, p_oArguments, p_fCallback : Function, p_oScope) : Void	static public function callMethod(p_sMethodName : String, p_oArgument, p_fCallback : Function, p_oScope) : Void	static public function init(Void) : Void
}