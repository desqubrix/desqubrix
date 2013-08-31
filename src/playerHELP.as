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
		private var borders:Vector.<Point>;
		
		private var borderA:int;
		private var borderB:int;
		
		private var canMoveAlongX:Boolean;
		private var canMoveAlongY:Boolean;
		
		private var didChange:Boolean;
		private var isDrawing:Boolean;
		
		private var previousDirection:Point;
		private var currentDirection:Point;
		
		private const STATE_DRAWING:String = "drawing";
		private const STATE_BORDERS:String = "borders";
		private var state:String;
		
		private var debugText:Text;
		
		public function Player(x:int, y:int) 
		{
			img = new Image(new BitmapData(10, 10, false));
			img.angle = 45;
			img.centerOrigin();
			super(x, y, img);
			layer = -150;
			
			v = new Point();
			directions = new Vector.<Point>();
			directions.push(new Point(x, y));
			
			
			
			borders = new Vector.<Point>();
			borders.push(new Point(10, 30));
			borders.push(new Point(20, 30));
			borders.push(new Point(20, 20));
			borders.push(new Point(40, 20));
			borders.push(new Point(40, 10));
			
			borders.push(new Point(FP.screen.width - 10, 10));
			borders.push(new Point(FP.screen.width - 10, FP.screen.height - 10));
			borders.push(new Point(10, FP.screen.height - 10));
			
			didChange = false;
			
			debugText = new Text("", 10, 50);
			currentDirection = new Point();
			previousDirection = new Point();
			
			borderA = 0;
			borderB = borders.length - 1;
			
			state = STATE_BORDERS;
			
			canMoveAlongX = false;
			canMoveAlongY = false;
			isDrawing = false;
		}
		
		override public function added():void 
		{
			world.addGraphic(debugText, -200);
		}
		
		private function checkInputOnBorders():void
		{
			if (Input.check(Key.LEFT) && canMoveAlongX) {
					hInput = -1;
					vInput = 0;
					return;
				}
				if (Input.check(Key.RIGHT) && canMoveAlongX) {
					hInput = 1;
					vInput = 0;
					return;
				}
				if (Input.check(Key.UP) && canMoveAlongY) {
					hInput = 0;
					vInput = -1;
					return;
				}
				if (Input.check(Key.DOWN) && canMoveAlongY) {
					hInput = 0;
					vInput = 1;
					return;
				}
				hInput = 0;
				vInput = 0;
		}
		
		override public function update():void 
		{
			debugText.text = state;
			
			
			if (Input.check(Key.SPACE)) {
				//DRAWING
				checkInputDrawing();
				previousDirection.x = currentDirection.x;
				previousDirection.y = currentDirection.y;
				
				
				if (previousDirection.x != currentDirection.x && previousDirection.y != currentDirection.y) {
					didChange = true;
				}
				
				if (didChange) {
					directions.push(new Point(x, y));
					didChange = false;
				}
			}
			else {
				//IS IT ON A BORDER?
				if (isOnBorders()) {
					//YES, IT IS. THEN YOU CAN MOVE CONSTRAINING BY BORDERS
					//INSIDE BORDERS
					checkInputOnBorders();
					checkBorders();
				}
				else {
					//NO? THEN IT DRAW SOMETHING, TRACE THAT PATH BACK
				}
			}
			
			v.x = hInput * speed;
			v.y = vInput * speed;
			
			x += v.x;
			y += v.y
			
			//trace(" alongX", canMoveAlongX, "/", "alongY", canMoveAlongY)
			debugText.text = isOnBorders().toString() + "\n" + new Point(x,y).toString();
			//borders[borderA].toString() + "\n" + borders[borderB].toString() + "\n" + new Point(x, y).toString();*/
			super.update();
		}
		
		private function isOnBorders():Boolean
		{
			for (var i:int = 0; i < borders.length - 1; i++) {
				//trace(x, y, "/", borders[i], i);
				//CHECK IF IT IS ON A VERTEX
				if (x == borders[i].x && y == borders[i].y) return true;
				
					//IS IT A VERTICAL BORDER		//IS THE DOT ON THE SAME AXIS?
				if (borders[i].x == borders[i + 1].x && borders[i].x == x) {
					//CHECK IF IT IS AN ASCENDING OR DESCENDING BORDER
					//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
					if (borders[i].y > borders[i + 1].y) {
						return y < borders[i].y && y > borders[i + 1].y;
					}
					else if (borders[i].y < borders[i + 1].y) {
						return y > borders[i].y && y < borders[i + 1].y;
					}
				}
					//IS IT AN HORIZONTAL BORDER	//IS THE DOT ON THE SAME AXIS?
				if (borders[i].y == borders[i + 1].y && borders[i].y == y) {
					//CHECK IF BORDER GOES FROM LEFT TO RIGHT OR THE OTHER WAY
					//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
					if (borders[i].x < borders[i + 1].x) {
						return x > borders[i].x && x < borders[i + 1].x;
					}
					else if (borders[i].x > borders[i + 1].x) {
						return x < borders[i].x && x > borders[i+1].x;
					}
				}
			}
			
			//## OUTSIDE OF THE LOOP VALUE OF i IS NOW 7##
			//##### CHECKING LAST AND FIRST VERTEX ######
			
			//CHECK IF IT IS ON THE LAST VERTEX
			if (x == borders[i].x && y == borders[i].y) return true;
			
				//IS IT A VERTICAL BORDER	//IS THE DOT ON THE SAME AXIS?
			if (borders[i].x == borders[0].x && borders[i].x == x) {
				//CHECK IF IT IS AN ASCENDING OR DESCENDING BORDER
				//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
				if (borders[i].y > borders[0].y) {
					return y < borders[i].y && y > borders[0].y;
				}
				else if (borders[i].y < borders[0].y) {
					return y > borders[i].y && y < borders[0].y;
				}
			}
			
				//IS IT A VERTICAL BORDER	//IS THE DOT ON THE SAME AXIS?
			if (borders[i].y == borders[0].y && borders[i].y == y) {
				//CHECK IF BORDER GOES FROM LEFT TO RIGHT OR THE OTHER WAY
				//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
				if (borders[i].x < borders[0].x) {
					return x > borders[i].x && x < borders[0].x;
				}
				else if (borders[i].x > borders[0].x) {
					return x < borders[i].x && x > borders[0].x;
				}
			}
			trace("-------");
			//ALL CHECKS FAILED, IT IS NOT ON A BORDER
			return false
		}
		
		private function checkBorders():void {
			if (x == borders[borderA].x && y == borders[borderA].y) {
				if (Input.pressed("cursor")) {
					borderA++;
					borderB++;
				}
			}
			else if (x == borders[borderB].x && y == borders[borderB].y) {
				if (Input.pressed("cursor")) {
					borderA--;
					borderB--;
				}
			}
			
			if (borderA > borders.length - 1) borderA = 0;
			if (borderA < 0) borderA = borders.length - 1;
			if (borderB > borders.length - 1) borderB = 0;
			if (borderB < 0) borderB = borders.length - 1;
			
			
			
			if (borders[borderA].x == borders[borderB].x) {
				canMoveAlongY = true;
			}
			else canMoveAlongY = false;
			
			if (borders[borderA].y == borders[borderB].y) {
				canMoveAlongX = true;
			}
			else canMoveAlongX = false;
			
			if (y < borders[borderA].y || y > borders[borderB].y) {
				//trace("STOPPING MOVEMENT ON Y!");
				y -= v.y;
			}
			if (x > borders[borderA].x || x < borders[borderB].x) {
				//trace("STOPPING MOVEMENT ON X!");
				x -= v.x;
			}
			
			
		}
		
		private function checkInputDrawing():void
		{
			if (Input.check(Key.LEFT)) {
				hInput = -1;
				vInput = 0;
				currentDirection.x = hInput;
				currentDirection.y = vInput;
				return;
			}
			if (Input.check(Key.RIGHT)) {
				hInput = 1;
				vInput = 0;
				currentDirection.x = hInput;
				currentDirection.y = vInput;
				return;
			}
			if (Input.check(Key.UP)) {
				hInput = 0;
				vInput = -1;
				currentDirection.x = hInput;
				currentDirection.y = vInput;
				return;
			}
			if (Input.check(Key.DOWN)) {
				hInput = 0;
				vInput = 1;
				currentDirection.x = hInput;
				currentDirection.y = vInput;
				return;
			}
			hInput = 0;
			vInput = 0;
		}
		
		
		
		override public function render():void 
		{
			super.render();
			
			//CURRENT LINE
			Draw.line(directions[directions.length - 1].x, directions[directions.length - 1].y, x, y);
			
			for (var i:int = 0; i < directions.length - 1; i++) {
				Draw.line(directions[i].x, directions[i].y, directions[i + 1].x, directions[i + 1].y);
			}
			
			for (i = 0; i < borders.length - 1; i++) {
				Draw.line(borders[i].x, borders[i].y, borders[i + 1].x, borders[i + 1].y);
				
			}
			Draw.line(borders[i].x, borders[i].y, borders[0].x, borders[0].y)
			
			//RECTANGLE
			Draw.line(10, 10, FP.screen.width - 10, 10);
			Draw.line(10, 10, 10, FP.screen.height - 10);
			Draw.line(10, FP.screen.height - 10, FP.screen.width - 10, FP.screen.height - 10);
			Draw.line(FP.screen.width - 10, FP.screen.height - 10, FP.screen.width - 10, 10);
			
			
			
			Draw.circle(borders[borderA].x, borders[borderA].y, 3, 0xFF0000);
			Draw.circle(borders[borderB].x, borders[borderB].y, 3, 0xFF0000);
		}
	}

}