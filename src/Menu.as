package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Menu extends MovieClip
	{
		private var startButton : sSquare = new sSquare;
		
		public function Menu() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Starting "startMenu" function
			startMenu();
		}
		
		private function startMenu():void
		{
			//Adding startbutton
			addChild(startButton);
			startButton.x = stage.stageWidth/2
			startButton.y = 300;
			
			var buttonHolder:MovieClip = new MovieClip();
			
			addChild(buttonHolder);
			buttonHolder.addChild(startButton);
			buttonHolder.addEventListener(MouseEvent.CLICK, click);
		}
		
		private function click(e:MouseEvent):void
		{
			//Dispatching function if startbutton is clicked dispatch to "Start" function in Main class
			if (e.target == startButton)
			{
				dispatchEvent(new Event("startgame"));
			}
		}
		
	}

}