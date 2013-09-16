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
		private var points:Vector.<Point>;
		
		public function Overlay() 
		{
			layer  = GC.LAYER_LIGHTING;
			canvas = new BitmapData(FP.width, FP.height, false, 0xffffff);
			size   = new Rectangle(0, 0, FP.width, FP.height);
			points = new Vector.<Point>();
			
			init();
		}
		
		private function init():void
		{
			points.push(new Point(10, 90));
			points.push(new Point(50, 90));
			points.push(new Point(50, 70));
			points.push(new Point(130, 70));
			points.push(new Point(130, 130));
			points.push(new Point(110, 130));
			points.push(new Point(110, 150));
			points.push(new Point(170, 150));
			points.push(new Point(170, 50));
			points.push(new Point(110, 50));
			points.push(new Point(110, 30));
			points.push(new Point(420, 30));
			points.push(new Point(420, 200));
			points.push(new Point(450, 200));
			points.push(new Point(450, 30));
			points.push(new Point(490, 30));
			points.push(new Point(490, 350));
			points.push(new Point(350, 350));
			points.push(new Point(350, FP.screen.height - 10));
			points.push(new Point(10, FP.screen.height - 10));
			/*points.push(new Point());
			points.push(new Point(10, 10));
			points.push(new Point(15, 10));
			points.push(new Point(15, 20));
			points.push(new Point(20, 20));
			points.push(new Point(20, 800));
			points.push(new Point(150, 80));
			points.push(new Point(15, 20));
			points.push(new Point());*/
		}
		
		override public function render():void 
		{
			canvas.fillRect(size, 0xffffff);
			
			FP.sprite.graphics.clear();
			FP.sprite.graphics.beginFill(0x000000);
			//FP.sprite.graphics.moveTo(points[0].x, points[0].y);
			
			for (var i:int = 1; i < points.length; i++)
			{
				FP.sprite.graphics.lineTo(points[i].x, points[i].y);
			}
			FP.sprite.graphics.lineTo(points[0].x, points[0].y);
			
			canvas.draw(FP.sprite);
			
			/*for (var i:int = 0; i < lights.length; i++) 
			{
				lights[i].graphic.render(canvas, new Point(lights[i].x1, lights[i].y1), FP.camera);
			}
			*/
			FP.buffer.draw(canvas, null, colorTransform, BlendMode.SUBTRACT, null, false);
			super.render();
		}
		
	}

}