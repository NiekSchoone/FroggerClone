﻿package  
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFormat;
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
		private var livesCounter:	sLives;
		
		private var homeAmount 	: 	int		= 	5;
		
		//Arrays for the objects
		private var homeArray		: 	Array;
		private var logArray 		: 	Array;
		private var carArray 		: 	Array;
		private var homeFreeArray	:	Array;
		
		//Array for the positions of the objects
		private var logPosArray 	: 	Array;
		private var carPosArray 	: 	Array;
		
		private var standingOnLog 	: 	Boolean = false;
		//private var goToWin			:	Boolean = false;
		
		private var score			:	Score;
		
		private var newHomeFree : sFilledHome;
		
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
			
			livesCounter = new sLives();
			addChild(livesCounter);
			livesCounter.gotoAndStop(3);
			livesCounter.x = 50;
			livesCounter.y = 650;
			
			//Adding the player
			player = new Frogger();
			addChild(player);
			
			//Adding all the arrays
			carArray = new Array();
			
			logArray = new Array();
			
			
			homeFreeArray = new Array();
			
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
			/*row 2*/ SpawnLogs(1, 650, -2); SpawnLogs(1, 870, -2); SpawnLogs(1, 1100, -2);
			/*row 3*/ SpawnLogs(2, 0, 2.5);
			/*row 4*/ SpawnLogs(3, 650, -1); SpawnLogs(3, 975, -1);
			
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
			for (var i:int = carArray.length - 1; i >= 0; i--)
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
			for (var l:int = logArray.length - 1; l >= 0; l--)
			{
				logArray[l].x += logArray[l].speed;
				
				if (logArray[l].hitTestObject(player))
				{
					standingOnLog = true;
					addChild(player);
					player.frogger.speed = logArray[l].speed * 3;
					player.frogger.x += player.frogger.speed;
				}
				
				if (logArray[l].speed < 0 && logArray[l].x <= -50)
				{
					logArray[l].x = 650;
				}
				else if (logArray[l].speed > 0 && logArray[l].x >= 675)
				{
					logArray[l].x = 0;
				}
				
			}
		}
		
		private function spawnHomes():void
		{
			for (var hf : int = 0; hf < homeAmount; hf++ )
			{
				newHomeFree = new sFilledHome();
				homeFreeArray.push(newHomeFree);
				addChild(newHomeFree);
				homeFreeArray[hf].x = stage.stageWidth / homeAmount * hf + homeFreeArray[hf].width + 15;
				homeFreeArray[hf].y = 100;
			}
			
			for (var h : int = 0; h < homeAmount; h++)
			{
				newHome = new Home();
				homeArray.push(newHome);
				addChild(newHome);
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
					
					Score.scoreValue += 1000;
					
					resetPlayerPos();
					
					break;
				}
			}
			
			if (homeArray.length == 0)
			{
				clearGame();
			}
		}
		
		private function update(e:Event):void
		{
			carLogic();
			logLogic();
			homeLogic();
			gameOver();
			
			if (lives == 1)
			{
				livesCounter.gotoAndStop(1)
			}
			
			if (lives == 2)
			{
				livesCounter.gotoAndStop(2)
			}
			
			for (var i : int = 0; i < carArray.length; i++ )
			{
				carArray[i].update(e);
			}
			
			for (var l : int = 0; l < logArray.length; l++ )
			{
				logArray[l].update(e)
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
		
		private function clearGame():void
		{
			removeChild(player);
			removeChild(score);
			removeChild(livesCounter);
			removeChild(background);
			
			removeEventListener(Event.ENTER_FRAME, update);
			
			for (var i:int = carArray.length-1; i>= 0; i--)
			{
				removeChild(carArray[i]);
				carArray.splice(i,1);
			}
			
			for (var h:int = homeArray.length-1; h>= 0; h--)
			{
				removeChild(homeArray[h]);
				homeArray.splice(h,1);
			}
			
			for (var f:int = homeFreeArray.length - 1; f>= 0; f--)
			{
				removeChild(homeFreeArray[f]);
				homeFreeArray.splice(f,1);
			}
			
			for (var l:int = logArray.length-1; l>= 0; l--)
			{
				removeChild(logArray[l]);
				logArray.splice(l,1);
			}
			
			Score.scoreValue = 0;
			
		}
		
		private function gameOver():void
		{
			if (lives == 0)
			{
				clearGame();
				
				var text : TextField = new TextField();
				var format : TextFormat = new TextFormat("Retro Computer", 50, 0xFF0000, true);
				
				text.text = "Game Over";
				
				text.width = 366;
				
				text.x = stage.stageWidth / 2 - 183;
				text.y = stage.stageHeight / 2 - 50;
				
				text.setTextFormat(format);
				
				addChild(text);
			}
		}
		
		private function gameWon():void
		{
			clearGame();
		}
	}
}