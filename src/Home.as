package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Home extends MovieClip
	{
		public var home : MovieClip;
		
		public function Home() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			home = new sHome();
			addChild(home);
			
			home.gotoAndStop(1);
		}
		
	}

}