package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.LoaderInfo;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Loader extends Sprite
	{
		private var loadingBar 	: 	MovieClip;
		private var loader_txt	:	TextField;
		private var format		:	TextFormat;
		
		public function Loader()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			loadingBar 	= 	new sSquare();
			loader_txt 	= 	new TextField();
			format			= 	new TextFormat("impact", 30, 0xFFFFFF, false);
			
			loadingBar.scaleY = 0.2;
			loadingBar.x = stage.stageWidth / 2;
			loadingBar.y = 325;
			
			loader_txt.x = stage.stageWidth / 2 - loader_txt.width / 3;
			loader_txt.y = 400;
			
			loader_txt.width = 75;
			
			loader_txt.setTextFormat(format);
			
			addChild(loader_txt);
			addChild(loadingBar);
			
			addEventListener(Event.ENTER_FRAME, loadingLogic);
		}
		
		private function loadingLogic(e:Event):void
		{
			var totalLoad		:	Number	=	this.stage.loaderInfo.bytesTotal;
			var amountLoaded	:	Number	=	this.stage.loaderInfo.bytesLoaded;
			
			loader_txt.setTextFormat(format);
				
			loadingBar.scaleX 	= 	amountLoaded/totalLoad;
			loader_txt.text		=	String (Math.floor((amountLoaded / totalLoad) * 100) + "%");
			
			if ( totalLoad == amountLoaded)
			{
				removeChild(loader_txt);
				removeChild(loadingBar);
				dispatchEvent(new Event("startmenu"));
				this.removeEventListener(Event.ENTER_FRAME, loadingLogic);
			}
		}
		
		
	}
	
}