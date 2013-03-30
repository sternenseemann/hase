package jascii.display;

import haxe.macro.Expr;

typedef FrameData = {
    image:Image,
    ?refpoint_x:Int,
    ?refpoint_y:Int,
};

class Animation extends Sprite
{
    private var frames:Array<FrameData>;
    private var current:Int;

    private var td:Int;
    public var factor:Int;

    public var loopback:Bool;

    public function new(?data:Array<FrameData>)
    {
        super();

        if (frames == null)
            frames = new Array();

        this.frames = data;
        this.current = 0;

        this.td = 0;
        this.factor = 1;

        this.loopback = false;

        this.grow_sprite();
    }

    private inline function grow_sprite():Void
    {
        var width:Int = 0;
        var height:Int = 0;

        for (frame in this.frames) {
            width = frame.image.width > width ? frame.image.width : width;
            height = frame.image.height > height ? frame.image.height : height;
        }

        if (width > this.width)
            this.width = width;

        if (height > this.height)
            this.height = height;
    }

    public inline function add_frame(frame:FrameData):FrameData
    {
        this.frames.push(frame);
        this.grow_sprite();
        return frame;
    }

    private function set_frame_options(frame:FrameData):Void
    {
        if (frame.refpoint_x != null && frame.refpoint_y != null) {
            this.center_x = frame.refpoint_x;
            this.center_y = frame.refpoint_y;
        }
    }

    public override function update():Void
    {
        super.update();

        if (this.frames.length == 0)
            return;

        var frame_id:Int = this.current < 0 ? -this.current : this.current;

        this.set_frame_options(this.frames[frame_id]);
        this.blit(this.frames[frame_id].image);

        if (++this.td >= this.factor) {
            if (++this.current >= this.frames.length) {
                if (this.loopback)
                    this.current = -this.frames.length + 1;
                else
                    this.current = 0;
            }

            this.td = 0;
        }
    }

    macro public static function from_file(path:String):Expr
    {
        var data:Array<FrameData> =
            jascii.utils.AnimationParser.parse_file(path);

        return macro new Animation($v{data});
    }
}
