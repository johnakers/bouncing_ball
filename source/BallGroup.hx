package;

import flixel.FlxObject;
import flixel.group.FlxGroup;

class BallGroup extends FlxGroup
{
	public var balls:Array<Ball> = [];
	private var shadows:Array<Shadow> = [];

	public function new(X:Float = 0, Y:Float = 0)
	{
		super();
		addBall(X, Y);
	}

	public function addBall(X:Float, Y:Float):Void
	{
		var shadow = new Shadow(X, Y);
		// shadow.allowCollisions = FlxObject.NONE;
		add(shadow);
		this.shadows.push(shadow);

		var ball = new Ball(X, Y);
		add(ball);
		this.balls.push(ball);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		for (i in 0...this.balls.length)
		{
			this.shadows[i].x = this.balls[i].x;
			this.shadows[i].y = this.balls[i].y;
		}
	}
}