package  
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	
	public class Overlay extends Entity 
	{
		
		public var canvas:BitmapData;
		private var size:Rectangle;
		
		private var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 1);
		
		private var _borders:Borders;
		
		public function Overlay(borders:Borders) 
		{
			layer  = GC.LAYER_LIGHTING;
			canvas = new BitmapData(FP.width, FP.height, false, 0xffffff);
			size   = new Rectangle(0, 0, FP.width, FP.height);
			_borders = borders;
		}
		
		override public function render():void 
		{
			canvas.fillRect(size, 0xFFFFFF);
			canvas.fillRect(new Rectangle(10, 10, FP.width - 20, FP.height - 20), 0x000000);
			
			FP.sprite.graphics.clear();
			FP.sprite.graphics.beginFill(0xFFFFFF);
			FP.sprite.graphics.moveTo(_borders.vBorders[0].x, _borders.vBorders[0].y);
			
			for (var i:int = 1; i < _borders.vBorders.length; i++)
			{
				FP.sprite.graphics.lineTo(_borders.vBorders[i].x, _borders.vBorders[i].y);
			}
			FP.sprite.graphics.lineTo(_borders.vBorders[0].x, _borders.vBorders[0].y);
			
			canvas.draw(FP.sprite);
			
			FP.buffer.draw(canvas, null, colorTransform, BlendMode.SUBTRACT, null, false);
			super.render();
		}
	}

}