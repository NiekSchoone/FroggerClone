package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Main extends Sprite 
	{
		
		private var game : Game;
		private var menu : Menu;
		private var loader : Loader;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			loader = new Loader();
			
			
			addChild(loader);
			loader.addEventListener("startmenu", startMenu);
			
		}
		
		private function startMenu(e:Event):void
		{
			menu = new Menu();
			
			
			addChild(menu);
			menu.addEventListener("startgame", StartGame);
		}
		
		private function StartGame(e:Event):void
		{
			game = new Game();
			menu.visible = false;
			addChild(game);
		}
		
	}
	
}