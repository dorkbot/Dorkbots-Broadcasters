package dorkbots.dorkbots_ui
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class MinimizeTextFieldLines
	{
		public function MinimizeTextFieldLines()
		{
		}
		
		public static function minimize(textField:TextField, lines:uint, truncate:Boolean = false):void
		{
			var textString:String = "";
			var numLinesTooMany:Boolean = false;
			while (textField.numLines > lines)
			{
				numLinesTooMany = true;
				textString = textField.text;
				textField.text = textString.slice(0, -1);
			}
			
			if (truncate && numLinesTooMany) 
			{
				textField.height = textField.textHeight + 4;
				textField.autoSize = TextFieldAutoSize.NONE;
				// adds text to the end to trigger the truncating code
				textField.appendText("&&");
				TruncateTextField.truncateText(textField, true, lines);
				textField.height = textField.textHeight + 4;
			}
		}
	}
}