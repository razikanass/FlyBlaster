package  
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Anass
	 */
	public class MenuState extends FlxState 
	{
		[Embed(source = "../assets/sounds/Holding_misc.mp3")] private var Holding_misc:Class;
		private var Titlegame:FlxText;
		private var Inputstart:FlxText;
		private var waitingTime:Number = 0.0;
		
		public function MenuState() 
		{ 
			Titlegame = new FlxText(0, 0, FlxG.width, "SimpleFlyBlaster");
			Titlegame.setFormat(null, 30, 0xFF00FFFF, "center", 0xFFFF0000);
			Inputstart = new FlxText(0, FlxG.height - 30, FlxG.width, "Hold on the spacebar to start");
			Inputstart.setFormat(null, 20, 0xFFFFFF00, "center", 0xFFFF0000);
			FlxG.bgColor = 0xFF00FFFF;	
		}
		
		override public function create():void 
		{
			super.create();
			add(Titlegame);
			add(Inputstart);
		}
		
		override public function update():void 
		{
			super.update();
			
			Titlegame.velocity.y = Math.cos(Titlegame.x) * 50;
			
			if (Titlegame.y > FlxG.height / 3 || Titlegame.y < 0) {
				Titlegame.velocity.y *= -1;
			}
			
			if (FlxG.keys.pressed("SPACE")) {
				waitingTime += FlxG.elapsed;
				FlxG.camera.shake(0.01, 0.5);
				if (waitingTime >= 2) {
					// After 2 seconds has passed, the timer will reset.
					FlxG.switchState(new PlayState());
					waitingTime = 0;
				}
			}
		}
	}
}