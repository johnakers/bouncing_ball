package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var ball:Ball;
	private var shadow:Shadow;
	private var powerMeter:PowerMeter;
	private var wallsGroup:FlxTypedGroup<FlxSprite>;

	// https://www.ohsat.com/tutorial/flixel/hf-breakout/hf-breakout-2/
	override public function create()
	{
		super.create();

		// For debugging
		// FlxG.debugger.visible = true;
		// FlxG.debugger.drawDebug = true;
		// FlxG.log.redirectTraces = true;

		this.shadow = new Shadow(0, 0);
		this.add(this.shadow);

		this.ball = new Ball(0, 0);
		this.ball.screenCenter();
		this.add(this.ball);

		this.powerMeter = new PowerMeter(10, 10);
		this.add(this.powerMeter);

		this.wallsGroup = new FlxTypedGroup<FlxSprite>();

		var topWall = new FlxSprite(0, 0);
		topWall.makeGraphic(FlxG.width, 8, FlxColor.LIME);
		this.wallsGroup.add(topWall);

		var bottomWall = new FlxSprite(0, FlxG.height - 8);
		bottomWall.makeGraphic(FlxG.width, 8, FlxColor.LIME);
		this.wallsGroup.add(bottomWall);

		var leftWall = new FlxSprite(0, 0);
		leftWall.makeGraphic(8, FlxG.height, FlxColor.LIME);
		this.wallsGroup.add(leftWall);

		var rightWall = new FlxSprite(FlxG.width - 8, 0);
		rightWall.makeGraphic(8, FlxG.height, FlxColor.LIME);
		this.wallsGroup.add(rightWall);

		add(this.wallsGroup);

		for (wall in this.wallsGroup)
		{
			wall.immovable = true;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(ball, this.wallsGroup, updateBallAngle);

		if (FlxG.keys.justReleased.SPACE)
		{
			// Launch the ball!
			// Multiply power (0-100) by a factor (e.g. 10) to get speed in pixels/sec
			var speed = this.powerMeter.power * 10;
			var radians = this.ball.angle * (Math.PI / 180);
			this.ball.velocity.set(Math.cos(radians) * speed, Math.sin(radians) * speed);

			// Launch into the air!
			this.ball.zVelocity = this.powerMeter.power * 5;

			// Reset the meter
			this.powerMeter.power = 0;
		}

		updateShadow();
	}

	private function updateBallAngle(ball:Dynamic, wall:Dynamic)
	{
		ball.angle = 180 - ball.angle;
	}

	private function updateShadow()
	{
		this.shadow.x = this.ball.x;
		this.shadow.y = this.ball.y;
	}
}
