package {
	[Frame(factoryClass = "Preloader")]
	[SWF(width="320",height="320",backgroundColor="#ECE9D8")]
	
	import org.flixel.*;
	
	public class Main extends FlxGame {
		public function Main():void {
			super(320, 320, MenuState, 1, 60, 60);
			
			//debug
			trace("Main.as Initialized");
		}
	}
}