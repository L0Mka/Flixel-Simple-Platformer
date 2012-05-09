package {
	import org.flixel.*;
	
	public class Bullet extends FlxSprite {
		public function Bullet(X:Number, Y:Number, direction:uint):void {
			super(X, Y);
			
			makeGraphic(16, 4, 0xFFDB5D24);
			
			if (direction == RIGHT) {
				velocity.x = 500;
			}
			else if (direction == LEFT) {
				velocity.x = -500;
			}
		}
		
		public override function update():void {
			super.update();
		}
	}
}