package dorkbots.dorkbots_ui
{
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TextAutoSize
	{
		public function TextAutoSize()
		{
		}
		
		public static function autoSize(txt:TextField, widthBuffer:int = 0, heightBuffer:int = 0):void
		{
			//TextField's dimensions
			var maxTextWidth:int = Math.ceil(txt.width) - widthBuffer; 
			var maxTextHeight:int = Math.ceil(txt.height) - heightBuffer; 
			
			var f:TextFormat = txt.getTextFormat();
			
			//decrease font size until the text fits  
			while (txt.textWidth > maxTextWidth || txt.textHeight > maxTextHeight) 
			{
				f.size = int(f.size) - 1;
				txt.setTextFormat(f);
			}
		} 
	}
}