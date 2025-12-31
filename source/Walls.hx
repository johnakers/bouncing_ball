package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class Walls extends FlxTypedGroup<FlxSprite>
{
	public function new()
	{
		super();

		var topWall = new FlxSprite(0, 0);
		topWall.makeGraphic(FlxG.width, 8, FlxColor.LIME);
		topWall.immovable = true;
		add(topWall);

		var bottomWall = new FlxSprite(0, FlxG.height - 8);
		bottomWall.makeGraphic(FlxG.width, 8, FlxColor.LIME);
		bottomWall.immovable = true;
		add(bottomWall);

		var leftWall = new FlxSprite(0, 0);
		leftWall.makeGraphic(8, FlxG.height, FlxColor.LIME);
		leftWall.immovable = true;
		add(leftWall);

		var rightWall = new FlxSprite(FlxG.width - 8, 0);
		rightWall.makeGraphic(8, FlxG.height, FlxColor.LIME);
		rightWall.immovable = true;
		add(rightWall);
	}
}