package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Anass
	 */
	public class PowerUp extends FlxSprite 
	{
		[Embed(source = "../assets/sprites/powerUp.png")]private var powerUp:Class;
		private var speed:Number;		
		
		public function PowerUp(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
			loadGraphic(powerUp, true, false, 5, 5);
			scale.x = 2;
			scale.y = 2;
			addAnimation("idle", [0, 1, 2], 15, true);
		}
		
	    override public function update():void 
		{
			super.update();
			acceleration.x = -200;
		}
	}

}