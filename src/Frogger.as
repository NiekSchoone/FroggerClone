package  
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Frogger extends MovieClip
	{
		private var frogger : sFrog = new sFrog();
		
		private var playerDirectionX 	: 	Number = 0;
		private var playerDirectionY 	: 	Number = 0;
		private var canMove				:	Boolean = true;
		
		public function Frogger() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(frogger);
			frogger.x = 375;
			frogger.y = 575;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, hoppingFrog);
			stage.addEventListener(KeyboardEvent.KEY_UP, stopHoppingFrog);
			
		}
		
		private function hoppingFrog(e:KeyboardEvent):void
		{
			if ((e.keyCode == 87 || e.keyCode == 38) && canMove == true)
			{
				if (frogger.y > 0 + frogger.height)
				{
					frogger.y -= 50;
					canMove = false;
				}
				frogger.rotation = 360;
			}
			if ((e.keyCode == 83 || e.keyCode == 40) && canMove == true)
			{
				if (frogger.y < 600 - frogger.height)
				{
					frogger.y += 50;
					canMove = false;
				}
				frogger.rotation = 180;
			}
			if ((e.keyCode == 68 || e.keyCode == 39) && canMove == true)
			{
				if (frogger.x < stage.stageWidth - frogger.width)
				{
					frogger.x += 50;
					canMove = false;
				}
				frogger.rotation = 90;
			}
			if ((e.keyCode == 65 || e.keyCode == 37) && canMove == true)
			{
				if (frogger.x > 0 + frogger.width)
				{
					frogger.x -= 50;
					canMove = false;
				}
				frogger.rotation = 270;
			}
		}
		
		private function stopHoppingFrog(e:KeyboardEvent)
		{
			if (e.keyCode == 87 || e.keyCode == 38 || e.keyCode == 83 || e.keyCode == 40 || e.keyCode == 68 || e.keyCode == 39 || e.keyCode == 65 || e.keyCode == 37)
			{
				canMove = true;
			}
		}
		
	}

}