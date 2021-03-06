/* Haxe ASCII Spriting Engine
 *
 * Copyright (C) 2013-2017 aszlig
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License, version 3, as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License
 * for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package hase.display;

abstract Symbol(Int) from Int
{
    public var ordinal(get, set):Int;
    public var fgcolor(get, set):Int;
    public var bgcolor(get, set):Int;

    public inline function new(ord:Int, ?fg:Int, ?bg:Int)
        this = (bg != null ? (1 << 26) | bg << 16 : 0)
             | (fg != null ? (1 << 25) | fg << 8  : 0)
             | ord;

    private inline function get_ordinal():Int
        return this & 0xff;

    private inline function set_ordinal(ord:Int):Int
        return this |= ord;

    private inline function get_fgcolor():Int
        return this >> 25 & 1 == 1 ? (this & 0xff00) >> 8 : 7;

    private inline function set_fgcolor(fg:Int):Int
        return this |= fg == 7 ? 0 : (1 << 25) | (fg << 8);

    private inline function get_bgcolor():Int
        return this >> 26 & 1 == 1 ? (this & 0xff0000) >> 16 : 0;

    private inline function set_bgcolor(bg:Int):Int
        return this |= bg == 0 ? 0 : (1 << 26) | (bg << 16);

    public inline function is_alpha():Bool
        return this & 0xff == 0;

    public inline function get_hash():Int
        return this;

    @:to public inline function toString():String
        return String.fromCharCode(this & 0xff);
}
