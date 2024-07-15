package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	static final colors:Array<FlxColor> = [
		FlxColor.WHITE, FlxColor.GRAY, FlxColor.BLACK, FlxColor.GREEN, FlxColor.LIME, FlxColor.YELLOW, FlxColor.ORANGE, FlxColor.RED, FlxColor.PURPLE,
		FlxColor.BLUE, FlxColor.BROWN, FlxColor.PINK, FlxColor.MAGENTA, FlxColor.CYAN
	];

	var curColor:Int = 0;

	override function create():Void
	{
		super.create();

		FlxG.camera.bgColor = 0xFF999999;
		final sprite = new FlxSprite().makeGraphic(1, 1, FlxColor.WHITE);
		sprite.scale.set(FlxG.width * 0.75, FlxG.height * 0.75);
		sprite.updateHitbox();
		add(sprite.screenCenter());

		cycleColors();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		// using private __colorTransform to check color transform directly
		@:privateAccess
		final transform = (FlxG.renderBlit ? FlxG.camera._flashBitmap.transform.__colorTransform : FlxG.camera.canvas.transform.__colorTransform);
		final cameraColor = FlxG.camera.color;
		final cameraTransformColor = FlxColor.fromRGBFloat(transform.redMultiplier, transform.greenMultiplier, transform.blueMultiplier);
		trace(cameraColor.toHexString(), cameraTransformColor.toHexString(), cameraColor == cameraTransformColor);
	}

	function cycleColors(?_)
	{
		FlxG.camera.color = colors[curColor];
		curColor = (++curColor % colors.length);
		new FlxTimer().start(1.0, cycleColors);
	}
}
