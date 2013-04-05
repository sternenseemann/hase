package jascii.test.cases;

import jascii.display.Image;
import jascii.display.Symbol;

import jascii.utils.ParserTypes;

class FrameAreaParserTest extends haxe.unit.TestCase
{
    private function parse(data:Array<String>):Array<Container>
    {
        var img:Image = [
            for (row in data) [for (c in 0...row.length) row.charCodeAt(c)]
        ];
        return (new jascii.utils.FrameAreaParser(img)).parse();
    }

    private inline function assert_row(row:String, actual:Image, pos:Int):Void
    {
        this.assertEquals(row.length, actual.width);
        this.assertFalse(pos >= actual.height);
        actual.map_(inline function(x:Int, y:Int, sym:Symbol) {
            if (y == pos) this.assertEquals(new Symbol(row.charCodeAt(x)), sym);
        });
    }

    public function test_simple():Void
    {
        var result:Array<Container> = this.parse(
            [ "| XXX"
            , "| XXX"
            , "| XXX"
            ]
        );

        this.assertEquals(3, result[0].body.height);
        this.assert_row(" XXX", result[0].body, 0);
        this.assert_row(" XXX", result[0].body, 1);
        this.assert_row(" XXX", result[0].body, 2);
    }

    public function test_heading():Void
    {
        var result:Array<Container> = this.parse(
            [ ":red:"
            , "|XXX|"
            , "|XXX|"
            , "|XXX|"
            ]
        );

        this.assertEquals(3, result[0].body.height);
        this.assert_row("XXX", result[0].body, 0);
        this.assert_row("XXX", result[0].body, 1);
        this.assert_row("XXX", result[0].body, 2);
    }

    public function test_two_headings():Void
    {
        var result:Array<Container> = this.parse(
            [ ":green:blue:"
            , "|AAA  |BBB |"
            , "|AAA  |BBB |"
            , "|AAA  |BBB |"
            ]
        );

        this.assertEquals(3, result[0].body.height);
        this.assert_row("AAA  ", result[0].body, 0);
        this.assert_row("AAA  ", result[0].body, 1);
        this.assert_row("AAA  ", result[0].body, 2);

        this.assertEquals(3, result[1].body.height);
        this.assert_row("BBB ", result[1].body, 0);
        this.assert_row("BBB ", result[1].body, 1);
        this.assert_row("BBB ", result[1].body, 2);
    }

    public function test_four_headings():Void
    {
        var result:Array<Container> = this.parse(
            [ ":plain:ansi:red:green:"
            , "|AAA  |BBB |CCC|DDD  |"
            , "|AAA  |BBB |CCC|DDD  |"
            , "|AAA  |BBB |CCC|DDD  |"
            ]
        );

        this.assertEquals(3, result[0].body.height);
        this.assert_row("AAA  ", result[0].body, 0);
        this.assert_row("AAA  ", result[0].body, 1);
        this.assert_row("AAA  ", result[0].body, 2);

        this.assertEquals(3, result[1].body.height);
        this.assert_row("BBB ", result[1].body, 0);
        this.assert_row("BBB ", result[1].body, 1);
        this.assert_row("BBB ", result[1].body, 2);

        this.assertEquals(3, result[2].body.height);
        this.assert_row("CCC", result[2].body, 0);
        this.assert_row("CCC", result[2].body, 1);
        this.assert_row("CCC", result[2].body, 2);

        this.assertEquals(3, result[3].body.height);
        this.assert_row("DDD  ", result[3].body, 0);
        this.assert_row("DDD  ", result[3].body, 1);
        this.assert_row("DDD  ", result[3].body, 2);
    }

    public function test_difficult_headings():Void
    {
        var result:Array<Container> = this.parse(
            [ ":red:red:plain:"
            , "|:|:|||||:xxx:|"
            , "||:|||||||XXX||"
            , "|:|:|:::||XXX||"
            ]
        );

        this.assertEquals(3, result[0].body.height);
        this.assert_row(":|:", result[0].body, 0);
        this.assert_row("|:|", result[0].body, 1);
        this.assert_row(":|:", result[0].body, 2);

        this.assertEquals(3, result[1].body.height);
        this.assert_row("|||", result[1].body, 0);
        this.assert_row("|||", result[1].body, 1);
        this.assert_row(":::", result[1].body, 2);

        this.assertEquals(3, result[2].body.height);
        this.assert_row(":xxx:", result[2].body, 0);
        this.assert_row("|XXX|", result[2].body, 1);
        this.assert_row("|XXX|", result[2].body, 2);
    }
}