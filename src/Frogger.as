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
		public var frogger : sFrog = new sFrog();
		
		private var playerDirectionX 	: 	Number 	= 0;
		private var playerDirectionY 	: 	Number 	= 0;
		
		private var canMove				:	Boolean = true;
		
		public var speed				: 	Number 	= 0;
		
		public function Frogger() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(frogger);
			
			frogger.gotoAndStop(1);
			frogger.x = 325;
			frogger.y = 600;
			
			this.speed = speed;
			
			addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, hoppingFrog);
			stage.addEventListener(KeyboardEvent.KEY_UP, stopHoppingFrog);
		}
		
		private function hoppingFrog(e:KeyboardEvent):void
		{
			
			if ((e.keyCode == 87 || e.keyCode == 38) && canMove == true)
			{
				if (frogger.y > 0 + frogger.height)
				{
					frogger.gotoAndStop(2);
					frogger.y -= 50;
					canMove = false;
					Score.scoreValue += 10
				}
				frogger.rotation = 360;
			}
			if ((e.keyCode == 83 || e.keyCode == 40) && canMove == true)
			{
				if (frogger.y < 650 - frogger.height)
				{
					frogger.gotoAndStop(2);
					frogger.y += 50;
					canMove = false;
					Score.scoreValue -= 10
				}
				frogger.rotation = 180;
			}
			if ((e.keyCode == 68 || e.keyCode == 39) && canMove == true)
			{
				if (frogger.x < stage.stageWidth - frogger.width)
				{
					frogger.gotoAndStop(2);
					frogger.x += 50;
					canMove = false;
				}
				frogger.rotation = 90;
			}
			if ((e.keyCode == 65 || e.keyCode == 37) && canMove == true)
			{
				if (frogger.x > 0 + frogger.width)
				{
					frogger.gotoAndStop(2);
					frogger.x -= 50;
					canMove = false;
				}
				frogger.rotation = 270;
			}
		}
		
		private function stopHoppingFrog(e:KeyboardEvent):void
		{
			if (e.keyCode == 87 || e.keyCode == 38 || e.keyCode == 83 || e.keyCode == 40 || e.keyCode == 68 || e.keyCode == 39 || e.keyCode == 65 || e.keyCode == 37)
			{
				canMove = true;
				frogger.gotoAndStop(1);
			}
		}
		
		private function update(e:Event):void
		{
			this.x += speed;
		}
		
	}

}