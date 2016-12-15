package dorkbots.dorkbots_ui.shape_creators
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;

	// ABSTRACT CLASS (Should be subclassed and not instantiated)
	public class AbstractShapeCreator
	{
		private var _lineThickness:Number = 1;
		private var _lineColor:Number = 0xFFFFFF;
		private var _lineAlpha:Number = 0;
		private var _fillColor:Number = 0xFFFFFF;
		private var _fillAlpha:Number = 1;
		protected var _width:Number = 10;
		protected var _height:Number = 10;
		private var _center:Boolean = false;
		
		public function AbstractShapeCreator()
		{
		}

		public final function set lineThickness(value:Number):void
		{
			_lineThickness = value;
		}

		public final function set fillAlpha(value:Number):void
		{
			_fillAlpha = value;
		}

		public function set lineAlpha(value:Number):void
		{
			_lineAlpha = value;
		}

		public final function set center(value:Boolean):void
		{
			_center = value;
		}

		public final function set height(value:Number):void
		{
			_height = value;
		}
		
		public final function get height():Number
		{
			return _height;
		}

		public final function set width(value:Number):void
		{
			_width = value;
		}
		
		public final function set fillColor(value:Number):void
		{
			_fillColor = value;
		}

		public final function set lineColor(value:Number):void
		{
			_lineColor = value;
		}
		
		// ABSTRACT METHOD (must be overriden in a subclass)
		public function getShape(a_mc:Sprite = null):Sprite
		{
			throw new IllegalOperationError("getShape operation not supported in CreateShape");
		}
		
		protected final function initGraphics(graphics:Graphics):void
		{
			graphics.clear();
			graphics.lineStyle(_lineThickness, _lineColor, _lineAlpha);
			graphics.beginFill(_fillColor, _fillAlpha);
		}
		
		protected final function getStartPoint():Point
		{
			var startPoint:Point = new Point();
			
			if (_center)
			{
				startPoint.x -= _width * .5;
				startPoint.y -= _height * .5;
			}
			
			return startPoint;
		}
		
		protected final function checkSpriteParameter(a_mc:Sprite = null):Sprite
		{
			var this_mc:Sprite;
			
			if (a_mc == null)
			{
				this_mc = new Sprite();
			}
			else
			{
				this_mc = a_mc;
			}
			
			return this_mc;
		}
	}
}