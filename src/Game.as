package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Niek Schoone
	 */
	
	public class Game extends Sprite
	{
		private var player : Frogger = new Frogger;
		
		//Arrays
		private var homeA 	: 	Array;
		private var logA 	: 	Array;
		private var carA 	: 	Array;
		private var logPos 	: 	Array;
		private var carPos 	: 	Array;
		
		
		public function Game() 
		{
			addChild(player);
		}
		
	}

}