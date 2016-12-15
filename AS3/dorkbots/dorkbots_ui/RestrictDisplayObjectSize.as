package dorkbots.dorkbots_ui
{
	import flash.display.DisplayObject;

	public class RestrictDisplayObjectSize
	{
		public function RestrictDisplayObjectSize()
		{
		}
		
		public static function restrictSize(a_mc:DisplayObject, maxHeight:Number = 0, maxWidth:Number = 0):void
		{
			var scaleX:Number = 1;
			var scaleY:Number = 1;
			
			if (maxHeight != 0 && a_mc.height > maxHeight)
			{
				scaleY = maxHeight / a_mc.height;
			}
			
			if (maxWidth != 0 && a_mc.width > maxWidth)
			{
				scaleX = maxWidth / a_mc.width;
			}
			
			if (scaleX > scaleY)
			{
				a_mc.scaleX = a_mc.scaleY = scaleY;
			}
			else if (scaleX < scaleY)
			{
				a_mc.scaleX = a_mc.scaleY = scaleX;
			}
		}
	}
}