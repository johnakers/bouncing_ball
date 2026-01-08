package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var ballGroup:BallGroup;
	private var powerMeter:PowerMeter;
	private var walls:Walls;
	private var addBallButton:FlxButton;

	// https://www.ohsat.com/tutorial/flixel/hf-breakout/hf-breakout-2/
	override public function create()
	{
		super.create();

		// For debugging
		// FlxG.debugger.visible = true;
		// FlxG.debugger.drawDebug = true;
		// FlxG.log.redirectTraces = true;

		this.ballGroup = new BallGroup(0, 0);
		this.ballGroup.balls[0].screenCenter();
		this.add(this.ballGroup);

		this.powerMeter = new PowerMeter(10, 10);
		this.add(this.powerMeter);

		this.addBallButton = new FlxButton(130, 10, "Add Ball", clickAddBall);
		this.addBallButton.label.setFormat("assets/fonts/04B_03__.TTF", 10, FlxColor.BLACK, FlxTextAlign.CENTER);
		add(this.addBallButton);

		this.walls = new Walls();
		add(this.walls);

		var instructions = new FlxText(10, FlxG.height - 32, 0, "Use LEFT/RIGHT arrow keys to aim ball\nHold SPACEBAR to launch ball", 10);
		instructions.font = "assets/fonts/04B_03__.TTF";
		add(instructions);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(this.ballGroup, this.walls, additionalBallExecutes);

		if (FlxG.keys.justReleased.SPACE)
		{
			// Launch the ball!
			// Multiply power (0-100) by a factor (e.g. 10) to get speed in pixels/sec
			var speed = this.powerMeter.power * 10;

			for (ball in this.ballGroup.balls)
			{
				var radians = ball.angle * (Math.PI / 180);
				ball.velocity.set(Math.cos(radians) * speed, Math.sin(radians) * speed);
				// Launch into the air!
				ball.zVelocity = this.powerMeter.power * 5;
			}

			// Reset the meter
			this.powerMeter.power = 0;
		}
	}

	// FIXME: When we bounce off top/bottom walls, it seems the angle gets reversed
	private function additionalBallExecutes(ball:Dynamic, wall:Dynamic)
	{
		// ball.angle = 180 - ball.angle;
		FlxG.sound.play("assets/sounds/Hit43.wav");
	}

	private function clickAddBall():Void
	{
		var randomX = FlxG.random.float(50, FlxG.width - 50);
		var randomY = FlxG.random.float(50, FlxG.height - 200);
		ballGroup.addBall(randomX, randomY);
		FlxG.sound.play("assets/sounds/Pickup35.wav");
	}
}
