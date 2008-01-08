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
 * swSystem Screen intrinsic class.
 * 
 * @author Romain Ecarnot
 */
intrinsic class screenweaver.system.Screen
{
	public function getArea(p_nMonitorNum : Number) : Object;	public function getBottom(p_nMonitorNum : Number) : Number;	public function getHeight(p_nMonitorNum : Number) : Number;	public function getLeft(p_nMonitorNum : Number) : Number;	public function getMode(p_nMonitorNum : Number, p_fCallback : Function, p_oScope) : Void;	public function getModes(p_nMonitorNum : Number) : Array;	public function getMonitorCount(Void) : Number;	public function getName(p_nMonitorNum : Number) : String;	public function getRight(p_nMonitorNum : Number) : Number;	public function getTop(p_nMonitorNum : Number) : Number;	public function getWidth(p_nMonitorNum : Number) : Number;	
	public function getWorkspaceArea(p_nMonitorNum : Number) : Object;	public function getWorkspaceBottom(p_nMonitorNum : Number) : Number;	public function getWorkspaceHeight(p_nMonitorNum : Number) : Number;	public function getWorkspaceLeft(p_nMonitorNum : Number) : Number;	public function getWorkspaceRight(p_nMonitorNum : Number) : Number;	public function getWorkspaceTop(p_nMonitorNum : Number) : Number;	public function getWorkspaceWidth(p_nMonitorNum : Number) : Number;	public function restoreMode(p_nMonitorNum : Number, p_fCallback : Function, p_oScope) : Void;	public function setMode(p_nWidth : Number, p_nHeight : Number, p_nDepth : Number, p_nFreq : Number , p_nMonitorNum : Number, p_fCallback : Function, p_oScope, p_bTestMode : Boolean, p_bRegistry : Boolean) : Void;	public function tryMode(p_nWidth : Number, p_nHeight : Number, p_nDepth : Number, p_nFreq : Number , p_nMonitorNum : Number, p_fCallback : Function, p_oScope) : Void;
}