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
		private var player 		: 	Frogger 	= 	new Frogger;
		private var newCar		:	Car;
		private var carSpeed 	: 	Number		=	1;
		
		//Arrays
		private var homeArray		: 	Array;
		private var logArray 		: 	Array;
		private var carArray 		: 	Array;
		private var logPosArray 	: 	Array;
		private var carPosArray 	: 	Array;
		
		
		public function Game() 
		{
			addChild(player);
			
			carArray = new Array();
			
			//Declares positions for cars in the 
			carPosArray = new Array(375, 425, 475, 525)
			
			addEventListener(Event.ENTER_FRAME, update);
			
			//Spawns all the cars with different variables
			SpawnCars(0, 0, 4, 1);
			SpawnCars(1, 750, 3, -1);
			SpawnCars(2, 0, 6, 1);
			SpawnCars(3, 750, 5, -1);
		}
		
		private function SpawnCars(carY:int,carX:int, speed:Number, dir : int):void
		{
			newCar = new Car(speed,dir);
			newCar.y = carPosArray[carY];
			newCar.x = carX;
			carArray.push(newCar);
			addChild(newCar);
			
			trace (carArray.length);
		}
		
		private function update(e:Event):void
		{
			for (var i : int = 0; i < carArray.length; i++ )
			{
				carArray[i].update(e);
			}
		}
		
	}
}