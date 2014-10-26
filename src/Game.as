package  
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Niek Schoone
	 */
	
	public class Game extends Sprite
	{
		private var player 		: 	Frogger;
		
		private var newCar		:	Car;
		private var newLog		:	Log;
		private var newHome		:	Home;
		private var background	:   Background;
		
		private var lives 		:	Number	=	3;
		
		private var homeAmount 	: 	int		= 	5;
		
		//Arrays for the objects
		private var homeArray		: 	Array;
		private var logArray 		: 	Array;
		private var carArray 		: 	Array;
		
		//Array for the positions of the objects
		private var logPosArray 	: 	Array;
		private var carPosArray 	: 	Array;
		
		private var standingOnLog 	: 	Boolean = false;
		//private var goToWin			:	Boolean = false;
		
		private var score			:	Score;
		
		//sounds
		private var startupMusic	:	Sound = new sGameStart(); 
		private var froggerDeath	:	Sound = new sFroggerDeath();
		private var frogReset		:	Sound = new sResetFrog();
		
		public function Game()
		{	
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			startupMusic.play();
			
			background = new Background();
			addChild(background);
			
			score = new Score();
			addChild(score);
			
			//Adding the player
			player = new Frogger();
			addChild(player);
			
			//Adding all the arrays
			carArray = new Array();
			
			logArray = new Array();
			
			homeArray = new Array();
			
			//Declares positions for cars / logs with an array
			carPosArray = new Array(400, 450, 500, 550);
			
			logPosArray = new Array(300, 250, 200, 150);
			
			addEventListener(Event.ENTER_FRAME, update);
			
			spawnHomes();
			
			//Spawn cars
			/*row 1*/ SpawnCars(0, 0, 4, 5); SpawnCars(0, -325, 4, 5);
			/*row 2*/ SpawnCars(1, 650, -2, 4); SpawnCars(1, 950, -2, 4);
			/*row 3*/ SpawnCars(2, 0, 2.5, 2); SpawnCars(2, -400, 2.5, 2);
			/*row 4*/ SpawnCars(3, 650, -1, 1); SpawnCars(3, 900, -1, 1); SpawnCars(3, 1150, -1, 1);
			
			//Spawn logs
			/*row 1*/ SpawnLogs(0, 0, 1.5);
			/*row 2*/ SpawnLogs(1, 650, -2);
			/*row 3*/ SpawnLogs(2, 0, 2.5);
			/*row 4*/ SpawnLogs(3, 650, -3);
			
		}
		
		private function SpawnLogs(logY:int, logX:int, speed:Number):void
		{
			newLog = new Log(speed);
			newLog.y = logPosArray[logY];
			newLog.x = logX;
			newLog.speed = speed;
			logArray.push(newLog);
			addChild(newLog);
		}
		
		private function SpawnCars(carY:int, carX:int, speed:Number, carType:int):void
		{
			newCar = new Car(speed);
			newCar.y = carPosArray[carY];
			newCar.x = carX;
			newCar.car.gotoAndStop(carType);
			carArray.push(newCar);
			addChild(newCar);
		}
		
		private function carLogic():void
		{
			for (var i = carArray.length - 1; i >= 0; i--)
			{
				carArray[i].x += carArray[i].speed;
				
				if (carArray[i].hitTestObject(player))
				{
					
					froggerDeath.play();
					trace("SPLAT");
					lives--;
					resetPlayerPos();
				}
				
				if (carArray[i].speed < 0 && carArray[i].x <= -50)
				{
					carArray[i].x = 650;
				}
				else if (carArray[i].speed > 0 && carArray[i].x >= 675)
				{
					carArray[i].x = 0;
				}
			}
		}
		
		//on a death event, call to this function to reset the player to the start of the level.
		private function resetPlayerPos():void
		{
			frogReset.play();
			player.frogger.x = 325;
			player.frogger.y = 600;
		}
		
		private function logLogic():void
		{
			standingOnLog = false;
			for (var i = logArray.length - 1; i >= 0; i--)
			{
				logArray[i].x += logArray[i].speed;
				
				if (logArray[i].hitTestObject(player))
				{
					standingOnLog = true;
					addChild(player);
					player.frogger.speed = logArray[i].speed * 3;
					player.frogger.x += player.frogger.speed;
				}
				
				if (logArray[i].speed < 0 && logArray[i].x <= -50)
				{
					logArray[i].x = 650;
				}
				else if (logArray[i].speed > 0 && logArray[i].x >= 675)
				{
					logArray[i].x = 0;
				}
				
			}
		}
		
		private function spawnHomes():void
		{
			for (var h : int = 0; h < homeAmount; h++)
			{
				newHome = new Home();
				homeArray.push(newHome);
				addChild(newHome);
				newHome.home.gotoAndStop(1);
				homeArray[h].x = stage.stageWidth / homeAmount * h + homeArray[h].width + 15;
				homeArray[h].y = 100;
			}
		}
		
		private function homeLogic():void
		{
			for (var homeIndex:int = homeArray.length - 1; homeIndex >= 0; homeIndex--)
			{
				if (player.hitTestObject(homeArray[homeIndex]))
				{
					removeChild(homeArray[homeIndex]);
					
					homeArray.splice(homeIndex, 1);
					
					addChild()
					
					Score.scoreValue += 1000;
					
					resetPlayerPos();
					
					break;
				}
			}
			
			if (homeArray.length == 0)
			{
				resetPlayerPos();
			}
		}
		
		private function update(e:Event):void
		{
			carLogic();
			logLogic();
			homeLogic();
			gameOver();
			
			
			for (var i : int = 0; i < carArray.length; i++ )
			{
				carArray[i].update(e);
			}
			
			for (var i : int = 0; i < logArray.length; i++ )
			{
				logArray[i].update(e)
			}
			
			if (homeArray.length == 0)
			{
				gameWon();
			}
			
			if (player.frogger.y < 350)
			{
				if (!standingOnLog)
				{
					
					froggerDeath.play();
					trace("BLUB");
					lives--;
					resetPlayerPos();
				}
			}
		}
		
		private function clearGame()
		{
			removeChild(player);
			removeChild(score);
			
			for (var i = carArray.length-1; i>= 0; i--)
			{
				removeChild(carArray[i]);
				carArray.splice(i,1);
			}
			
			for (var i = homeArray.length-1; i>= 0; i--)
			{
				removeChild(homeArray[i]);
				homeArray.splice(i,1);
			}
			
			for (var i = logArray.length-1; i>= 0; i--)
			{
				removeChild(logArray[i]);
				logArray.splice(i,1);
			}
			
			Score.scoreValue = 0;
			
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		private function gameOver():void
		{
			if (lives == 0)
			{
				clearGame();
			}
		}
		
		private function gameWon():void
		{
			for (var i = carArray.length-1; i>= 0; i--)
			{
				removeChild(carArray[i]);
				carArray.splice(i,1);
			}
			
			for (var i = homeArray.length-1; i>= 0; i--)
			{
				removeChild(homeArray[i]);
				homeArray.splice(i,1);
			}
			
			for (var i = logArray.length-1; i>= 0; i--)
			{
				removeChild(logArray[i]);
				logArray.splice(i,1);
			}
			
			removeChild(player);
			removeChild(score);
			
			removeEventListener(Event.ENTER_FRAME, update);
			
		}
	}
}