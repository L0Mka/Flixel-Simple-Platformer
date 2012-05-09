package {
	import org.flixel.*;
	
	public class Hero extends FlxSprite {
		private const SPRITE_HEIGHT:uint = 16;
		private const SPRITE_WIDTH:uint = 16;
		
		[Embed(source = '../assets/hero/hero_robot.png')]
		private var imgHero:Class;
		
		public function Hero(X:Number, Y:Number) {
			super(X, Y);
			
			loadGraphic(imgHero, true, true, SPRITE_WIDTH, SPRITE_HEIGHT);
			
			acceleration.y = 500;
			drag.x = 500;
			maxVelocity.x = 100;
			maxVelocity.y = 1000;
			
			addAnimation("idle", [0]);
			addAnimation("jump", [1]);
			addAnimation("walk", [2, 3], 12);
		}
		
		public function getBulletSpawnPositionLeft():FlxPoint{
			var p:FlxPoint = new FlxPoint(x - 5, y + 5);
			return p;
		}
		
		public function getBulletSpawnPositionRight():FlxPoint {
			var p:FlxPoint = new FlxPoint(x + 5, y + 5);
			return p;
		}
		
		public function getDirection():uint {
			var direction:uint = this.facing;
			return direction;
		}
		
		public override function update():void {
			super.update();
			
			acceleration.x = 0;
			
			if (FlxG.keys.RIGHT) {
				acceleration.x += drag.x;
				
				facing = RIGHT;
				play("walk");
			}
			else if (FlxG.keys.LEFT) {
				acceleration.x -= drag.x;
				
				facing = LEFT;
				play("walk");
			}
			else {
				play("idle");
			}
			
			if (FlxG.keys.justPressed("Z") && velocity.y == 0) {
				velocity.y -= 300;
			}
			
			if (velocity.y != 0) {
				play("jump");
			}
		}
	}
}