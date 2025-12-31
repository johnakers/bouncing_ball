package;

import flixel.FlxG;
import flixel.FlxSprite;

class Ball extends FlxSprite
{
  public var z:Float = 0;
  public var zVelocity:Float = 0;
  private var gravity:Float = 800;

  public function new(x:Float, y:Float)
  {
    super(x, y);

    loadGraphic("assets/images/ball.png", true, 16, 16, true, "ball");

    // Add drag (friction) so the ball slows down over time.
    // 200 pixels per second squared deceleration.
    this.drag.set(200, 200);

    this.animation.add("roll", [0, 1, 2, 3], 30, true);

		// Enable collision with world bounds (screen edges by default)
    elasticity = 1;
  }

  override public function update(elapsed:Float)
  {
    super.update(elapsed);

    updateZ(elapsed);
    updateMoving();
    updateRotation(elapsed);
  }

  private function updateZ(elapsed:Float):Void
  {
    if (z > 0 || zVelocity != 0)
    {
      // Apply gravity
      zVelocity -= gravity * elapsed;
      z += zVelocity * elapsed;

      // Ground collision
      if (z < 0)
      {
        z = 0;
        // Bounce on the ground (Z-axis)
        // If moving fast enough, bounce; otherwise stop
        if (Math.abs(zVelocity) > 100)
          zVelocity = -zVelocity * 0.5;
        else
          zVelocity = 0;
      }
    }

    // Visual offset: shift the sprite up by 'z' pixels.
    // Flixel subtracts the offset from the position, so positive z moves it up.
    offset.y = z;

    // Disable ground friction (drag) while in the air
    if (z > 0)
      drag.set(0, 0);
    else
      drag.set(200, 200);
  }

  private function updateMoving():Void
  {
    if (velocity.x != 0 || velocity.y != 0)
    {
      this.animation.play("roll");
      // Sync the animation speed to the movement speed.
      // Dividing by 10 is an arbitrary factor to make it look good.
      var fps = Math.sqrt(velocity.x * velocity.x + velocity.y * velocity.y) / 10;
      this.animation.curAnim.frameRate = (fps < 1) ? 1 : fps;
    }
    else
    {
      this.animation.stop();
    }
  }

  private function updateRotation(elapsed:Float):Void
  {
    // Only allow aiming if the ball is stopped on the ground
    if (velocity.x == 0 && velocity.y == 0 && z == 0)
    {
      if (FlxG.keys.pressed.LEFT)
        angle -= 180 * elapsed;

      if (FlxG.keys.pressed.RIGHT)
        angle += 180 * elapsed;
    }
  }
}
