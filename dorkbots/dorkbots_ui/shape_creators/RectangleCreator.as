package dorkbots.dorkbots_ui.shape_creators
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class RectangleCreator extends AbstractShapeCreator
	{
		public function RectangleCreator()
		{
			super();
		}
		
		override public function getShape(a_mc:Sprite = null):Sprite
		{
			var this_mc:Sprite = checkSpriteParameter(a_mc);
			
			var startPoint:Point = getStartPoint();
			
			initGraphics(this_mc.graphics);
			
			this_mc.graphics.drawRect(startPoint.x, startPoint.y, _width, _height);
			
			this_mc.graphics.endFill();
			
			return this_mc;
		}
	}
}