package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Background extends Sprite 
	{
		private var safeZone 	: 	Sprite 	= 	new Sprite();
		private var safeZone2 	: 	Sprite 	= 	new Sprite();
		private var water 		: 	Sprite 	= 	new Sprite();
		private var road	 	: 	Sprite 	= 	new Sprite();
		private var scoreBar	: 	Sprite	=	new Sprite();
		private var gras		:	Sprite	=	new Sprite();
		
		public function Background() 
		{	
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			
			//safeZone 1
			safeZone.graphics.beginFill(0x990099);
			safeZone.graphics.drawRect(0,0,stage.stageWidth, 50);
			safeZone.graphics.endFill();
			
			safeZone.x = 0;
			safeZone.y = 575;
			
			addChild(safeZone);
			
			//safeZone 2
			safeZone2.graphics.beginFill(0x990099);
			safeZone2.graphics.drawRect(0,0,stage.stageWidth, 50);
			safeZone2.graphics.endFill();
			
			safeZone2.x = 0;
			safeZone2.y = 325;
			
			addChild(safeZone2);
			
			//water
			water.graphics.beginFill(0x000099);
			water.graphics.drawRect(0,0,stage.stageWidth, 250);
			water.graphics.endFill();
			
			water.x = 0;
			water.y = 75;
			
			addChild(water);
			
			//gras
			gras.graphics.beginFill(0x009900);
			gras.graphics.drawRect(0, 0, stage.stageWidth, 75);
			gras.graphics.endFill();
			
			gras.x = 0
			gras.y = 50
			
			addChild(gras);
		}
		
	}

}