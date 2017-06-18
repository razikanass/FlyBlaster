package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxColor;
	
	/**
	 * ...
	 * @author Anass
	 */
	public class Enemy extends FlxSprite 
	{
		
		[Embed(source="../assets/sprites/enemy1.png")] private var enemy1:Class;
		[Embed(source = "../assets/sprites/enemy2.png")] private var enemy2:Class;
		private var enemies:Array;
		private var index:int;
		public var speed:Number = -(Math.random() * 300 - 50);
		
		public function Enemy(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			enemies = new Array(enemy1,enemy2);
			index = int(Math.random() * 2);
			
			loadGraphic(enemies[index], true, false, 15, 14);
			width = 15;
			height = 15;
			scale.x = 2;
			scale.y = 2;
			addAnimation("idle", [0, 1], 4, true);
			maxVelocity.x = 300;
			velocity.x = speed;
		}
		
		override public function update():void 
		{
			play("idle");
			
			if (y >= FlxG.height-height) {
				velocity.y *= -1;
			}
			else if (y <= 0) {
				velocity.y *= -1;
			}
			super.update();
			velocity.y = -Math.cos(x / 50) * 50;			
		}
		
	}

}