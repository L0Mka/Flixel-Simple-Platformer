package {
	import org.flixel.*;
	
	public class Enemy extends FlxSprite {
		private const SPRITE_HEIGHT:uint = 12;
		private const SPRITE_WIDTH:uint = 12;
		
		[Embed(source = '../assets/enemy/enemy_bacteria.png')]
		private var imgEnemy:Class;
		
		private var sprHero:Hero;
		
		public function Enemy(X:Number, Y:Number, hero:Hero):void {
			super(X, Y);
			
			sprHero = hero;
			
			loadGraphic(imgEnemy, true, true, SPRITE_WIDTH, SPRITE_HEIGHT);
			
			acceleration.y = 500;
			drag.x = 100;
			maxVelocity.x = 100;
			maxVelocity.y = 1000;
			
			addAnimation("idle", [4]);
			addAnimation("jump", [0]);
			addAnimation("walk", [1, 2, 3], 12);
		}
		
		public override function update():void {
			super.update();
			
			acceleration.x = 0;
			
			if (sprHero.x > x) {
				acceleration.x += drag.x;
				
				play("walk");
				facing = RIGHT;
			}
			else if (sprHero.x < x) {
				acceleration.x -= drag.x;
				
				play("walk");
				facing = LEFT;
			}
		}
	}
}