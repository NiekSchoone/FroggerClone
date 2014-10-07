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
		private var car : sCar = new sCar();
		private var dir : int = 0;
		public var generalSpeed : Number = 0;
		
		public function Car(speed : Number, dir : int)
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			generalSpeed = speed;
			
			this.dir = dir; 
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(car);
			
			addEventListener(Event.ENTER_FRAME, update);
			
		}
		
		public function update(e:Event):void
		{
			
			this.x += generalSpeed * dir;
		}
		
	}
	
}
