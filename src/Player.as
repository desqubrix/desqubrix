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
			layer = -150;
			
			x = 350;
			y = 350;
			
			super(x, y, img);
			
			
			v = new Point();
			
			borders = new Borders();
			borders.init();
		}
		
		override public function added():void 
		{
			debugText = new Text("", 50, 200);
			world.addGraphic(debugText, -200);
		}
		private function shittyCheckInput():void 
		{
			if (Input.check(Key.UP)) y -= speed;
			if (Input.check(Key.DOWN)) y += speed;
			if (Input.check(Key.RIGHT))x += speed;
			if (Input.check(Key.LEFT))x -= speed;
			
			if (Input.pressed(Key.W))y -= 1;
			if (Input.pressed(Key.S))y += 1;
			if (Input.pressed(Key.D))x += 1;
			if (Input.pressed(Key.A))x -= 1;
			
			if (Input.pressed(Key.DIGIT_1)) {
				x = borders.vBorders[0].x;
				y = borders.vBorders[0].y;
			}
		}
		
		override public function update():void 
		{
			
			
			borders.update(x, y);
			
			if (Input.check(Key.CONTROL)) speed = 10;
			else speed = 1;
			
			//ARE WE DRAWING?
			if (Input.check(Key.SPACE)) {
				//CAN MOVE "FREELY"
				shittyCheckInput()
			}
			else {
				if (!borders.isPLayerOnBorders) {
					
				}
				else {
					if (Input.check(Key.UP) 	&& borders.canMoveUp) 		y -= speed;
					if (Input.check(Key.DOWN)	&& borders.canMoveDown) 	y += speed;
					if (Input.check(Key.RIGHT) 	&& borders.canMoveRight)	x += speed;
					if (Input.check(Key.LEFT) 	&& borders.canMoveLeft)		x -= speed;
				}
			}
			
			
			debugText.text = "position: " + new Point(x, y).toString()
				+ "\non Vertex: " + borders.isPlayerOnVertex.toString()
				+ "\non Border:" + borders.isPLayerOnBorders.toString() 
				+ "\nborderA: " + borders.borderA.toString()
				+ "\nborderB: " + borders.borderB.toString();
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
			
			//if(Input.check(Key.T)) drawBorders();
			//drawBorders();
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
			
			Draw.circle(vBorder[borders.borderA].x, vBorder[borders.borderA].y, 3);
			Draw.circle(vBorder[borders.borderB].x, vBorder[borders.borderB].y, 3);
		}
	}

}
