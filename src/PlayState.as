package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FX.GlitchFX;
	//import org.flixel.plugin.photonstorm.FX.GlitchFX;

	/**
	 * ...
	 * @author Anass
	 */
	
	public class PlayState extends FlxState 
	{
		[Embed(source = "../assets/sounds/Laser_Shoot.mp3")]private var laser_shoot:Class;
		[Embed(source = "../assets/sounds/Explosion.mp3")]private var explosion:Class;
		[Embed(source = "../assets/sprites/powerUp.png")]private var powerUp:Class;

		private var player:Player;
		private var enemyManager:FlxGroup;
		private var bulletManager:FlxGroup;
		private var powerUpManager:FlxGroup;
		private var reproduce_timer:Number = 0.0;
		private var waiting:Number = 1.5;
		private var score:FlxText;
		private var gameOver:FlxText;
		
		//public var bulletManager:FlxGroup;
		
		public function PlayState() 
		{
		}
		override public function create():void 
		{
			super.create();
			FlxG.score = 0;
			score = new FlxText(0, 0, FlxG.width, "0");
			score.setFormat(null, 12, 0xFF00FFFF, "center", 0xFFFF0000);
			add(score);
			gameOver = new FlxText(0 , FlxG.height / 2, FlxG.width, "GAME OVER \n Press escape to play again");
			gameOver.setFormat(null, 18, 0xFFFFFFFF, "center", 0xFFFF0000);
			player = new Player(FlxG.width / 20, FlxG.height / 2);
			add(player);
			enemyManager = new FlxGroup();
			add(enemyManager);
			bulletManager = new FlxGroup();
			add(bulletManager);
			powerUpManager = new FlxGroup();
		}
				
		override public function update():void 
		{
			
			FlxG.overlap(player, enemyManager, collisionEnemyPlayer);
			FlxG.overlap(bulletManager, enemyManager, collisionBulletEnemy);
			FlxG.overlap(player, powerUpManager, collisionPlayerPowerUp);
			
			reproduce_timer -= FlxG.elapsed;

			if (FlxG.keys.justPressed("SPACE")&&player.alive) {
				var bullet:Bulleto = new Bulleto(player.x + player.width, player.y + player.height / 2);
				bulletManager.add(bullet);
				FlxG.play(laser_shoot);
				if (bullet.x >= FlxG.height) {
					bulletManager.remove(bullet);
				}
			}

			if (FlxG.keys.ESCAPE && !player.alive) {
				FlxG.switchState(new PlayState());
			}
			
			if (reproduce_timer < 0) {
				//enemy production
				var posX:Number = FlxG.width;
				var posY:Number = Math.random() * (FlxG.height - 100) + 50;
				enemyManager.add(new Enemy(posX, posY));

				//resetting reproduction timer
				reproduce_timer = waiting;
				waiting *= 0.95;
				if (waiting < 0.1) {
					waiting = 0.1;
				}
			}
			
			super.update();
		}
		
		public function collisionBulletEnemy(bullet:FlxObject, enemy:FlxObject):void {
			var power:FlxSprite = new FlxSprite(enemy.x, enemy.y);
			power.loadGraphic(powerUp, true, false, 5, 5);
			power.addAnimation("idle", [0, 1, 2], 15, true);
			power.play("idle");
			add(power);
			power.velocity.x = -200;
			enemy.kill();
			FlxG.play(explosion);
			bullet.kill();
			FlxG.score += 10;
			score.text = FlxG.score.toString();
		}
		
		public function collisionEnemyPlayer(player:FlxObject ,enemy:FlxObject):void {
			player.alive = false;
			player.kill();
			FlxG.camera.flash(0xFFFF0000);
			add(gameOver);
		}
		
		public function collisionPlayerPowerUp(player:FlxObject , powerUp:FlxObject):void {
			trace("player and powerup collided");
		}
	}
}