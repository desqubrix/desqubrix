package net 
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	
	public class Lighting extends Entity 
	{
		
		public var canvas:BitmapData;
		public var lights:Vector.<RemovedSurface> = new Vector.<RemovedSurface>();
		public var size:Rectangle;
		public var light:Image;
		
		private var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 1);
		private var point:Point = new Point();
		
		public function Lighting() 
		{
			layer = GC.LAYER_LIGHTING;
			canvas = new BitmapData(FP.width, FP.height, false, 0xffffff);
			size = new Rectangle(0, 0, FP.width, FP.height);
			light = new Image(new BitmapData(100, 150, false, 0x000000));
		}
		
		public function add(r:RemovedSurface):void
		{
			lights.push(r);
		}
		
		override public function render():void 
		{
			canvas.fillRect(size, 0xffffff);
			
			
			for (var i:int = 0; i < lights.length; i++) 
			{
				lights[i].graphic.render(canvas, new Point(lights[i].x1, lights[i].y1), FP.camera);
			}
			
			FP.buffer.draw(canvas, null, colorTransform, BlendMode.SUBTRACT, null, false);
			super.render();
		}
		
	}

}