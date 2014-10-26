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
		private var startButton : 	sStartbutton 	= 	new sStartbutton();
		private var tittle		:	sFroggerTittle	=	new sFroggerTittle();
		
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
			//Adding the tittle
			addChild(tittle);
			tittle.x = 325;
			tittle.y = 250;
			
			//Adding startbutton
			addChild(startButton);
			startButton.gotoAndStop(1);
			startButton.x = 175;
			startButton.y = 535;
			
			var buttonHolder:MovieClip = new MovieClip();
			
			addChild(buttonHolder);
			buttonHolder.addChild(startButton);
			
			startButton.addEventListener(MouseEvent.CLICK, click);
			startButton.addEventListener(MouseEvent.MOUSE_OVER, onHoover);
			startButton.addEventListener(MouseEvent.MOUSE_OUT, ofHoover);
		}
		
		private function ofHoover(e:MouseEvent):void
		{
			if (e.target == startButton)
			{
				startButton.gotoAndStop(1);
			}
		}
		
		private function onHoover(e:MouseEvent):void
		{
			if (e.target == startButton)
			{
				startButton.gotoAndStop(2);
			}
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