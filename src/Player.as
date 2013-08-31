package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Player extends Entity 
	{
		private var img:Image;
		private var speed:int = 1;
		private var v:Point;
		private var hInput:int;
		private var vInput:int;
		
		private var directions:Vector.<Point>;
		private var borders:Borders;
		
		private var debugText:Text;
		
		public function Player(x:int, y:int) 
		{
			img = new Image(new BitmapData(10, 10, false));
			img.angle = 45;
			img.centerOrigin();
			
			x = FP.screen.width - 10;
			y = 515;
			
			super(x, y, img);
			layer = -150;
			
			v = new Point();
			borders = new Borders();
			borders.init();
			
			debugText = new Text("", 10, 50);
		}
		
		override public function added():void 
		{
			world.addGraphic(debugText, -200);
		}
		private function shittyCheckInput():void 
		{
			if (Input.check(Key.UP)) {
				y -= 1;
			}
			if (Input.check(Key.DOWN)) {
				y += 1;
			}
			
			if (Input.check(Key.RIGHT)) {
				x += 1;
			}
			if (Input.check(Key.LEFT)) {
				x -= 1;
			}
			
			if (Input.pressed(Key.W)) {
				y -= 1;
			}
			if (Input.pressed(Key.S)) {
				y += 1;
			}
			
			if (Input.pressed(Key.D)) {
				x += 1;
			}
			if (Input.pressed(Key.A)) {
				x -= 1;
			}
		}
		
		override public function update():void 
		{
			shittyCheckInput()
			
			borders.update(x, y);
			debugText.text = borders.isPLayerOnBorders.toString() + "\n" + new Point(x, y).toString();
			super.update();
		}
		
		override public function render():void 
		{
			super.render();
			
			//RECTANGLE
			Draw.line(10, 10, FP.screen.width - 10, 10);
			Draw.line(10, 10, 10, FP.screen.height - 10);
			Draw.line(10, FP.screen.height - 10, FP.screen.width - 10, FP.screen.height - 10);
			Draw.line(FP.screen.width - 10, FP.screen.height - 10, FP.screen.width - 10, 10);
			
			drawBorders();
		}
		
		private function drawBorders():void
		{
			var vBorder:Vector.<Point> = borders.vBorders;
			for (var i:int = 0; i < vBorder.length - 1; i++)
			{
				Draw.line(vBorder[i].x, vBorder[i].y, vBorder[i + 1].x, vBorder[i + 1].y);
				Draw.text(i.toString(), vBorder[i].x, vBorder[i].y)
			}
			Draw.line(vBorder[i].x, vBorder[i].y, vBorder[0].x, vBorder[0].y);
			Draw.text(i.toString(), vBorder[i].x, vBorder[i].y)
		}
	}

}