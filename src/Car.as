package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Car extends MovieClip
	{
		public var car 	: 	sCar 	= 	new sCar();
		public var speed 	: 	Number 	= 	0;
		
		public function Car(speed : Number)
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.speed = speed;
			
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(car);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void
		{
			this.x += speed;
		}
		
	}
	
}
