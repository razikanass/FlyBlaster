package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxColor;
	
	/**
	 * ...
	 * @author Anass
	 */
	public class Player extends FlxSprite 
	{
		[Embed(source = "../assets/sprites/spaceShip.png")] private var spaceShip:Class;
		private var Veloc:Number = 200;
		private var index:int = 0;
		public var bullet:Bulleto;
		
		public function Player(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
			loadGraphic(spaceShip, true, false, 10, 11);
			addAnimation("idle", [0, 1], 15, true);
			width = 16;
			height = 16;
			scale.x = 4;
			scale.y = 4;
			maxVelocity.y = 200;
			drag.y = 600;
		}
		
		override public function update():void 
		{
			super.update();
			
			acceleration.y = 0;
			play("idle");
			if (y >= FlxG.height-height) {
				y = FlxG.height - height;
				velocity.y *= -1;
			}
			else if (y <= 0) {
				y = 0;
				velocity.y *= -1;
			}
			
			if (FlxG.keys.pressed("UP")) {
				acceleration.y = -Veloc;
			}
			else if (FlxG.keys.pressed("DOWN")) {
				acceleration.y = Veloc;
			}
			
		}
		
	}

}