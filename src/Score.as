package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	/**
	 * ...
	 * @author Niek Schoone
	 */
	public class Score extends Sprite
	{
		public static var scoreValue  :	int = 0;
		
		private var scoreText	:	TextField;
		
		private var sTF:TextFormat = new TextFormat("impact", 30, 0xFFFFFF, false);
		
		public function Score() 
		{
			trace(scoreValue);
			scoreText = new TextField();
			scoreText.text = "score " + String(scoreValue);
			
			
			scoreText.x = 25;
			scoreText.y = 8;
			
			scoreText.setTextFormat(sTF);
			scoreText.width = 100;
			
			addChild(scoreText);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			scoreText.text = "score " + String(scoreValue);
			scoreText.setTextFormat(sTF);
		}
		
	}

}