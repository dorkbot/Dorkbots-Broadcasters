package dorkbots.dorkbots_ui
{
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TextPreserveFormat
	{
		public function TextPreserveFormat()
		{
		}
		
		public static function updateText(aTextField:TextField, copy:String):void
		{
			var aTextFormat:TextFormat = aTextField.getTextFormat();
			aTextField.text = copy;
			aTextField.setTextFormat(aTextFormat);
		}
	}
}