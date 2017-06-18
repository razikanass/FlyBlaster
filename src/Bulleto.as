package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Anass
	 */
	public class Bulleto extends FlxSprite 
	{
		
		public function Bulleto(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			makeGraphic(6, 2, 0xFFFF0000);
			velocity.x = 600;
		}
		
	}

}