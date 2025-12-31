package;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxBar;

class PowerMeter extends FlxSpriteGroup
{
	public var power:Float = 0.0;
	private var bar:FlxBar;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		// Create the bar at (0,0) relative to this group
		this.bar = new FlxBar(0, 0, null, 200, 20, this, "power", 0, 100, true);
		this.bar.createFilledBar(0xFF333333, 0xFFFF0000);
		add(this.bar);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.SPACE)
		{
			this.power += 60 * elapsed;
			if (this.power > 100) this.power = 100;
		}
	}
}