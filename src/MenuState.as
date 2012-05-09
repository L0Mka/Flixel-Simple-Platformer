package {
	import org.flixel.*;
	
	public class MenuState extends FlxState {
		private var txtDirection:FlxText;
		
		public function MenuState():void {
			super();
			
			//debug
			trace("MenuState.as Initialized");
		}
		
		public override function create():void {
			super.create();
			
			FlxG.bgColor = 0xD8E9EC;
			
			txtDirection = new FlxText(0, FlxG.height / 2, FlxG.width, "Press SPACE");
			txtDirection.setFormat(null, 8, 0xBAC7CC, "center");
			add(txtDirection);
			
			//debug
			trace("txtDirection.height= " + txtDirection.height);
		}
		
		public override function update():void {
			super.update();
			
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.switchState(new PlayState());
			}
		}
	}
}