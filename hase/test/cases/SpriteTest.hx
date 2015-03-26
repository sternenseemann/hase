/* Copyright (C) 2013 aszlig
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package hase.test.cases;

import hase.geom.PVector;

class SpriteTest extends hase.test.SurfaceTestCase
{
    public function test_simple():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        this.root.add_child(circle);
        this.update();

        this.assert_area(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ], 0, 0, 9, 5
        );
    }

    public function test_move_x():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        this.root.add_child(circle);
        this.update();
        circle.x = 5;
        this.update();

        this.assert_area(
            [ "        _._   "
            , "      .'   `. "
            , "      :     ; "
            , "       `-.-'  "
            , "              "
            ], 0, 0, 14, 5
        );
    }

    public function test_move_y():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        this.root.add_child(circle);
        this.update();
        circle.y = 5;
        this.update();

        this.assert_area(
            [ "         "
            , "         "
            , "         "
            , "         "
            , "         "
            , "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ], 0, 0, 9, 10
        );
    }

    public function test_overlay():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        var rect:hase.display.Sprite = this.create_sprite(
            [ ",-------."
            , "|       |"
            , "|       |"
            , "|       |"
            , "|       |"
            , "`-------'"
            ]
        );

        var dot:hase.display.Sprite = this.create_sprite(
            [ "     "
            , "     "
            , "    ^"
            ]
        );

        rect.add_child(circle);
        circle.add_child(dot);
        this.root.add_child(rect);

        circle.y = 1;
        this.update();

        this.assert_area(
            [ ",-------."
            , "|  _._  |"
            , "|.'   `.|"
            , "|:  ^  ;|"
            , "| `-.-' |"
            , "`-------'"
            ], 0, 0, 9, 6
        );
    }

    public function test_overlay_double_update():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        var rect:hase.display.Sprite = this.create_sprite(
            [ ",-------."
            , "|       |"
            , "|       |"
            , "|       |"
            , "|       |"
            , "`-------'"
            ]
        );

        rect.add_child(circle);
        this.root.add_child(rect);

        circle.y = 1;
        this.update();
        this.update();

        this.assert_area(
            [ ",-------."
            , "|  _._  |"
            , "|.'   `.|"
            , "|:     ;|"
            , "| `-.-' |"
            , "`-------'"
            ], 0, 0, 9, 6
        );
    }

    public function test_overlay_intersect():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        var rect:hase.display.Sprite = this.create_sprite(
            [ ",-------."
            , "|       |"
            , "|       |"
            , "|       |"
            , "`-------'"
            ]
        );

        rect.add_child(circle);
        this.root.add_child(rect);

        rect.x = 4;
        rect.y = 1;

        circle.x = -4;
        circle.y = -1;

        this.update();

        this.assert_area(
            [ "   _._       "
            , " .' ,-`.----."
            , " :  |  ;    |"
            , "  `-.-'     |"
            , "    |       |"
            , "    `-------'"
            ], 0, 0, 13, 6
        );
    }

    public function test_centering():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        var rect:hase.display.Sprite = this.create_sprite(
            [ ",-------."
            , "|       |"
            , "|       |"
            , "|       |"
            , "`-------'"
            ]
        );

        rect.add_child(circle);
        this.root.add_child(rect);

        rect.x = 4;
        rect.y = 1;

        circle.center_x = 4;
        circle.center_y = 1;

        this.update();

        this.assert_area(
            [ "   _._       "
            , " .' ,-`.----."
            , " :  |  ;    |"
            , "  `-.-'     |"
            , "    |       |"
            , "    `-------'"
            ], 0, 0, 13, 6
        );
    }

    public function test_move_around_multiple():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "         "
            , "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        var rect:hase.display.Sprite = this.create_sprite(
            [ ",-------."
            , "|       |"
            , "|       |"
            , "|       |"
            , "`-------'"
            ]
        );

        var tri:hase.display.Sprite = this.create_sprite(
            [ "     .     "
            , "   ,' `.   "
            , " ,'     `. "
            , "`---------'"
            ]
        );

        rect.add_child(circle);
        rect.add_child(tri);
        this.root.add_child(rect);

        rect.x += 4;
        tri.y += 5;
        circle.z = 3;

        this.update();

        rect.x += 4;
        circle.y += 5;

        this.update();

        rect.x += 2;

        this.update();

        circle.x -= 5;

        this.update();

        tri.x += 5;
        circle.y -= 3;
        circle.x += 9;

        this.update();

        this.assert_area(
            [ " ,-------.       "
            , " |       |       "
            , " |       |       "
            , " |      _._      "
            , " `----.'-' `.    "
            , "      :    .;    "
            , "       `-.-'`.   "
            , "       ,'     `. "
            , "      `---------'"
            ], 9, 0, 17, 9
        );
    }

    public function test_unnecessary_update():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        this.root.add_child(circle);
        this.update();

        this.assert_area(
            [ "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ], 0, 0, 9, 5
        );

        this.clear_surface();
        this.update();

        this.assert_area(
            [ "         "
            , "         "
            , "         "
            , "         "
            , "         "
            ], 0, 0, 9, 5
        );
    }

    public function test_destroy():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "         "
            , "   _._   "
            , " .'   `. "
            , " :     ; "
            , "  `-.-'  "
            , "         "
            ]
        );

        var rect:hase.display.Sprite = this.create_sprite(
            [ ",-------."
            , "|       |"
            , "|       |"
            , "|       |"
            , "|       |"
            , "`-------'"
            ]
        );

        var another:hase.display.Sprite = this.create_sprite(
            [ "-.`-.-'.-"
            , "  `.|,'  "
            , "---)|(---"
            , "  ,'|`.  "
            , "-'  |  `-"
            , "    |    "
            ]
        );

        rect.add_child(circle);
        this.root.add_child(rect);

        this.root.add_child(another);

        this.update();

        this.root.remove_child(rect);

        this.update();

        this.assert_area(
            [ "-.`-.-'.-"
            , "  `.|,'  "
            , "---)|(---"
            , "  ,'|`.  "
            , "-'  |  `-"
            , "    |    "
            ], 0, 0, 9, 6
        );
    }

    public function test_z_order():Void
    {
        var circle:hase.display.Sprite = this.create_sprite(
            [ "   _._   "
            , " .'   `. "
            , " :     : "
            , "  `-.-'  "
            , "         "
            ]
        );

        var rect:hase.display.Sprite = this.create_sprite(
            [ ".-------."
            , "|       |"
            , "|       |"
            , "|       |"
            , "|       |"
            , "`-------'"
            ]
        );

        var bar:hase.display.Sprite = this.create_sprite(
            [ ".-----------------------."
            , "|                       |"
            , "|                       |"
            , "`-----------------------'"
            ]
        );

        circle.x += 8;
        circle.y += 1;
        circle.z = 20;

        rect.x += 8;
        rect.z = 10;

        bar.y += 1;
        bar.z = 15;

        this.root.add_child(circle);
        this.root.add_child(rect);
        this.root.add_child(bar);

        this.update();

        this.assert_area(
            [ "        .-------.        "
            , ".----------_._----------."
            , "|       |.'   `.|       |"
            , "|       |:     :|       |"
            , "`---------`-.-'---------'"
            , "        `-------'        "
            ], 0, 0, 25, 6
        );

        bar.y -= 1;

        this.update();

        this.assert_area(
            [ ".-----------------------."
            , "|       |  _._  |       |"
            , "|       |.'   `.|       |"
            , "`--------:-----:--------'"
            , "        | `-.-' |        "
            , "        `-------'        "
            ], 0, 0, 25, 6
        );

        rect.y += 1;

        this.update();

        this.assert_area(
            [ ".-----------------------."
            , "|       .--_._--.       |"
            , "|       |.'   `.|       |"
            , "`--------:-----:--------'"
            , "        | `-.-' |        "
            , "        |       |        "
            , "        `-------'        "
            ], 0, 0, 25, 7
        );

        rect.z = 30;

        this.update();

        this.assert_area(
            [ ".-----------------------."
            , "|       .-------.       |"
            , "|       |.'   `.|       |"
            , "`-------|:-----:|-------'"
            , "        | `-.-' |        "
            , "        |       |        "
            , "        `-------'        "
            ], 0, 0, 25, 7
        );
    }

    public function test_distance_vector():Void
    {
        var copter:hase.display.Sprite = this.create_sprite(
            [ "   _________   "
            , " _     | __    "
            , " ;`---/'[__>.  "
            , "  ;```-.--.--' "
            , "     --'--'--' "
            ]
        );

        var house:hase.display.Sprite = this.create_sprite(
            [ "              ~             "
            , "            ~~~~            "
            , "          ~~~~~             "
            , "         ~~~                "
            , "        ~~                  "
            , "      ~~                    "
            , "      ~                     "
            , "     |`'|-.'-.'-.'-.        "
            , "     |  |.''.'.'.'.'`.      "
            , "   ,'.'.'.''.'.'.'.'.'`.    "
            , " ,'.'.'.'.''.'.'.'.'.'.'`.  "
            , " ``'|  __    __    __  |`'' "
            , "    | |  |  |  |  |  | |    "
            , "    | |__|  |__|  |__| |    "
            , "    |  __    __    __  |    "
            , "    | |  |  |  |  |  | |    "
            , "    | |__|  | '|  |__| |    "
            , "    |_______|__|_______|    "
            ]
        );

        house.x = 27;
        house.y = 16;
        house.center_x = 14;
        house.center_y = 16;

        copter.x = 9;
        copter.y = 15;
        copter.center_x = 9;
        copter.center_y = 2;

        this.root.add_child(house);
        this.root.add_child(copter);

        this.update();

        this.assert_area(
            [ "                           ~            "
            , "                         ~~~~           "
            , "                       ~~~~~            "
            , "                      ~~~               "
            , "                     ~~                 "
            , "                   ~~                   "
            , "                   ~                    "
            , "                  |`'|-.'-.'-.'-.       "
            , "                  |  |.''.'.'.'.'`.     "
            , "                ,'.'.'.''.'.'.'.'.'`.   "
            , "              ,'.'.'.'.''.'.'.'.'.'.'`. "
            , "              ``'|  __    __    __  |`''"
            , "                 | |  |  |  |  |  | |   "
            , "   _________     | |__|  |__|  |__| |   "
            , " _     | __      |  __    __    __  |   "
            , " ;`---/'[__>.    | |  |  |  |  |  | |   "
            , "  ;```-.--.--'   | |__|  | '|  |__| |   "
            , "     --'--'--'   |_______|__|_______|   "
            ], 0, 0, 40, 18
        );

        var dist:PVector = house.center_distance_to(copter);
        this.assertEquals(-18.0, dist.x);
        this.assertEquals(-1.0, dist.y);

        copter.y -= 4;
        copter.x += 4;
        this.update();

        this.assert_area(
            [ "                           ~            "
            , "                         ~~~~           "
            , "                       ~~~~~            "
            , "                      ~~~               "
            , "                     ~~                 "
            , "                   ~~                   "
            , "                   ~                    "
            , "                  |`'|-.'-.'-.'-.       "
            , "                  |  |.''.'.'.'.'`.     "
            , "       _________,'.'.'.''.'.'.'.'.'`.   "
            , "     _     | __'.'.'.'.''.'.'.'.'.'.'`. "
            , "     ;`---/'[__>.|  __    __    __  |`''"
            , "      ;```-.--.--' |  |  |  |  |  | |   "
            , "         --'--'--' |__|  |__|  |__| |   "
            , "                 |  __    __    __  |   "
            , "                 | |  |  |  |  |  | |   "
            , "                 | |__|  | '|  |__| |   "
            , "                 |_______|__|_______|   "
            ], 0, 0, 40, 18
        );

        var dist:PVector = house.center_distance_to(copter);
        this.assertEquals(-14.0, dist.x);
        this.assertEquals(-5.0, dist.y);

        copter.y -= 9;
        copter.x += 14;
        this.update();

        this.assert_area(
            [ "       _________          "
            , "     _     |~__           "
            , "     ;`---/'[__>.         "
            , "      ;```-.--.--'        "
            , "       ~~--'--'--'        "
            , "     ~~                   "
            , "     ~                    "
            , "    |`'|-.'-.'-.'-.       "
            , "    |  |.''.'.'.'.'`.     "
            , "  ,'.'.'.''.'.'.'.'.'`.   "
            , ",'.'.'.'.''.'.'.'.'.'.'`. "
            , "``'|  __    __    __  |`''"
            , "   | |  |  |  |  |  | |   "
            , "   | |__|  |__|  |__| |   "
            , "   |  __    __    __  |   "
            , "   | |  |  |  |  |  | |   "
            , "   | |__|  | '|  |__| |   "
            , "   |_______|__|_______|   "
            ], 14, 0, 26, 18
        );

        var dist:PVector = house.center_distance_to(copter);
        this.assertEquals(0.0, dist.x);
        this.assertEquals(-14.0, dist.y);
    }
}
