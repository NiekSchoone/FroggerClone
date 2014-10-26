package  
{
	import flash.events.Event;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Log extends MovieClip
	{
		private var log		:	sLog 	= 	new sLog();
		//public var dir 		: 	int 	= 	0;
		public var speed	:	Number 	= 	0;
		
		public function Log(speed : Number) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.speed = speed;
			
			//this.dir = dir; 
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(log);
			
			addEventListener(Event.ENTER_FRAME, update);
			
		}
		
		public function update(e:Event):void
		{
			this.x += speed;
		}
		
	}

}