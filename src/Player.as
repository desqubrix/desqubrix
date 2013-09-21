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
		
		private var line:Line;
		private var borders:Borders;
		
		public var beginStepX:int;
		public var beginStepY:int;
		
		private var debugText:Text;
		
		public function Player(x:int, y:int) 
		{
			img = new Image(new BitmapData(10, 10, false));
			img.angle = 45;
			img.centerOrigin();
			layer = GC.LAYER_PLAYER;
			
			x = 350;
			y = 350;
			
			super(x, y, img);
			
			v = new Point();
		}
		
		override public function added():void 
		{
			borders = 	GameWorld.id.borders;
			line    = 	GameWorld.id.line;
			
			debugText = new Text("", 50, 200);
			world.addGraphic(debugText, -200);
			borders.drawBorders();
		}

		override public function update():void 
		{
			beginStepX = x;
			beginStepY = y;
			
			if (Input.check(Key.CONTROL)) speed = 10;
			else speed = 1;
			
			if (Input.pressed(Key.R)) {
				borders.drawBorders();
				var t:Array = new Array();
				FP.world.getAll(t)
				trace(t);
			}
			
			//ARE WE DRAWING?
			if (Input.check(Key.SPACE)) {
				line.previousDirection.x = line.currentDirection.x;
				line.previousDirection.y = line.currentDirection.y;
				
				move();
				
				borders.update(x, y);
				
				if (line.nodes.length <= 0)
				{
					if (!borders.isPLayerOnBorders) {
						line.addNode(new Point(beginStepX, beginStepY));
						line.borderPosition.push(borders.lastBorderA);
						line.borderPosition.push(borders.lastBorderB);
					}
				}
				else 
				{
					if (borders.isPLayerOnBorders) {
						line.addNode(new Point(x, y));
						line.borderPosition.push(borders.borderA);
						line.borderPosition.push(borders.borderB);
						line.addNodesToBorders();
					}
					
					//did the cursor change direction?
					if (line.previousDirection.x != line.currentDirection.x &&
					line.previousDirection.y != line.currentDirection.y) 
					{
						line.addNode(new Point(beginStepX, beginStepY));
					}
					
					
					
				}
			}
			else {
				if (!borders.isPLayerOnBorders) {
					//SHOULD STOP TRACING BACK ITS PATH TO THE BORDER
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
				+ "\nborderB: " + borders.borderB.toString()
				+ "\nlastBorderA: " + borders.lastBorderA.toString()
				+ "\nlastBorderB: " + borders.lastBorderB.toString()
				
			super.update();
		}
		
		private function move():void
		{
			if (Input.check(Key.UP) 	&& line.canMoveUp) {
				y -= speed;
				line.currentDirection.y = -1;
				line.currentDirection.x = 0;
				return;
			}
			if (Input.check(Key.DOWN)	&& line.canMoveDown) {
				y += speed;
				line.currentDirection.y = 1;
				line.currentDirection.x = 0;
				return;
			}
			if (Input.check(Key.RIGHT) 	&& line.canMoveRight) {
				x += speed;
				line.currentDirection.y = 0;
				line.currentDirection.x = 1;
				return;
			}
			if (Input.check(Key.LEFT) 	&& line.canMoveLeft) {
				x -= speed;
				line.currentDirection.y = 0;
				line.currentDirection.x = -1;
				return;
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			//RECTANGLE
			Draw.line(10, 10, FP.screen.width - 10, 10);
			Draw.line(10, 10, 10, FP.screen.height - 10);
			Draw.line(10, FP.screen.height - 10, FP.screen.width - 10, FP.screen.height - 10);
			Draw.line(FP.screen.width - 10, FP.screen.height - 10, FP.screen.width - 10, 10);
		}
		
	}

}
