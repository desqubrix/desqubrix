package  
{
	
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Borders 
	{
		private var _borders:Vector.<Point>;
		private var _borderA:int;
		private var _borderB:int;
		
		private var _isPlayerOnBorders:Boolean;
		private var _isPlayerOnVertex:Boolean;
		
		private var _playerX:int;
		private var _playerY:int;
		
		private var _canMoveLeft:Boolean;
		private var _canMoveRight:Boolean;
		private var _canMoveUp:Boolean;
		private var _canMoveDown:Boolean;
		
		private var canvas:BitmapData;
		private var canvasEntity:Entity;
		
		public function Borders() 
		{
			init();
		}
		
		public function init():void
		{
			_borders = new Vector.<Point>();
			
			_borders.push(new Point(10, 90));
			_borders.push(new Point(50, 90));
			_borders.push(new Point(50, 70));
			_borders.push(new Point(130, 70));
			_borders.push(new Point(130, 130));
			_borders.push(new Point(110, 130));
			_borders.push(new Point(110, 150));
			_borders.push(new Point(170, 150));
			_borders.push(new Point(170, 50));
			_borders.push(new Point(110, 50));
			_borders.push(new Point(110, 30));
			_borders.push(new Point(420, 30));
			_borders.push(new Point(420, 200));
			_borders.push(new Point(450, 200));
			_borders.push(new Point(450, 30));
			_borders.push(new Point(490, 30));
			_borders.push(new Point(490, 350));
			_borders.push(new Point(350, 350));
			_borders.push(new Point(350, FP.screen.height - 10));
			_borders.push(new Point(10, FP.screen.height - 10));
			
			_borderA = 0;
			_borderB = 0;
			_isPlayerOnBorders = false;
			_isPlayerOnVertex = false;
			
			canvas = new BitmapData(FP.width, FP.height, true, 0xff0000);
			trace("some")
			FP.world.addGraphic(new Image(canvas), -200)//GC.LAYER_BORDERS);
		}
		
		public function update(x:Number, y:Number):void
		{
			_playerX = x;
			_playerY = y;
			checkPlayerOnBorders();
			updatePossibleMovementsOnBorders();
			
		}
		
		public function drawBorders():void
		{
			if (canvasEntity) FP.world.remove(canvasEntity);
			canvas.fillRect(new Rectangle(0, 0, FP.width, FP.height), 0x000000);
			Draw.setTarget(canvas);
			
			for (var i:int = 0; i < _borders.length - 1; i++) 
			{
				Draw.line(_borders[i].x, _borders[i].y, _borders[i + 1].x, _borders[i + 1].y);
				Draw.text(i.toString(), _borders[i].x, _borders[i].y);
			}
			Draw.line(_borders[i].x, _borders[i].y, _borders[0].x, _borders[0].y);
			Draw.text(i.toString(), _borders[i].x, _borders[i].y);
			
			Draw.circle(_borders[_borderA].x, _borders[_borderA].y, 3);
			Draw.circle(_borders[_borderB].x, _borders[_borderB].y, 3);
			
			canvasEntity = FP.world.addGraphic(new Image(canvas), -150);
			
			Draw.resetTarget();
		}
		
		private function updatePossibleMovementsOnBorders():void
		{
			_canMoveDown = _canMoveLeft = _canMoveRight = _canMoveUp = false;
			if (_isPlayerOnVertex) {
				//STORE POSSIBLE POSITIONS TO MOVE
				var previousVertex:int = _borderA - 1;
				var nextVertex:int = _borderA + 1;
				
				//MAKE SURE THEY ARE POSITIONS ON THE ARRAY
				if (previousVertex < 0) {
					previousVertex = _borders.length - 1;
				}
				if (nextVertex > _borders.length - 1) {
					nextVertex = 0;
				}
				
				//WHERE ARE THE PREVIOUS AND NEXT VERTEX?
				if ((_playerX < _borders[nextVertex].x 		&& 	_playerY < _borders[previousVertex].y) ||
					(_playerX < _borders[previousVertex].x 	&& 	_playerY < _borders[nextVertex].y)) 
				{
					_canMoveDown = true;
					_canMoveRight = true;
					return;
				}
				
				if ((_playerX < _borders[nextVertex].x 		&& 	_playerY > _borders[previousVertex].y) ||
					(_playerX < _borders[previousVertex].x 	&& 	_playerY > _borders[nextVertex].y)) 
				{
					_canMoveUp = true;
					_canMoveRight = true;
					return;
				}
				
				if ((_playerX > _borders[nextVertex].x 		&& 	_playerY < _borders[previousVertex].y) ||
					(_playerX > _borders[previousVertex].x 	&& 	_playerY < _borders[nextVertex].y)) 
				{
					_canMoveLeft = true;
					_canMoveDown = true;
					return;
				}
				
				if ((_playerX > _borders[nextVertex].x 		&& 	_playerY > _borders[previousVertex].y) ||
					(_playerX > _borders[previousVertex].x 	&& 	_playerY > _borders[nextVertex].y)) 
				{
					_canMoveUp = true;
					_canMoveLeft = true;
					return
				}
				
			}
			else if (_isPlayerOnBorders) {
				//SAME X = VERTICAL LINE
				if (_borders[_borderA].x == _borders[_borderB].x) {
					_canMoveDown = true;
					_canMoveUp = true;
					return;
				}
				//SAME Y = HORIZONTAL LINE
				if (_borders[_borderA].y == _borders[_borderB].y) {
					_canMoveLeft = true;
					_canMoveRight = true;
					return;
				}
			}
		}
		
		// STORES INDEXES FOR PLAYER POSITION ON _border
		// STORES BOOLEANS FOR PLAYER COLLISIONS
		private function checkPlayerOnBorders():void
		{
			for (var i:int = 0; i < _borders.length - 1; i++) {
				_borderA = i;
				_borderB = i + 1;
				_isPlayerOnVertex = false;
				
				//CHECK IF IT IS ON A VERTEX
				if (_playerX == _borders[i].x && _playerY == _borders[i].y) {
					_isPlayerOnBorders = true;
					_isPlayerOnVertex = true;
					_borderB = _borderA;
					return;
				}
				
					 //IS IT A VERTICAL BORDER			//IS THE DOT ON THE SAME AXIS?
				if (_borders[i].x == _borders[i + 1].x && _borders[i].x == _playerX) {
					//CHECK IF IT IS AN ASCENDING OR DESCENDING BORDER
					//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
					if (_borders[i].y > _borders[i + 1].y) {
						if (_playerY < _borders[i].y && _playerY > _borders[i + 1].y) {
							_isPlayerOnBorders = true;
							return;
						}
					}
					if (_borders[i].y < _borders[i + 1].y) {
						if (_playerY > _borders[i].y && _playerY < _borders[i + 1].y) {
							_isPlayerOnBorders = true;
							return;
						}
					}
				}

					 //IS IT AN HORIZONTAL BORDER		//IS THE DOT ON THE SAME AXIS?
				if (_borders[i].y == _borders[i + 1].y && _borders[i].y == _playerY) {
					//CHECK IF BORDER GOES FROM LEFT TO RIGHT OR THE OTHER WAY
					//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
					if (_borders[i].x < _borders[i + 1].x) {
						if (_playerX > _borders[i].x && _playerX < _borders[i + 1].x) {
							_isPlayerOnBorders = true;
							return;
						}
					}
					if (_borders[i].x > _borders[i + 1].x) {
						if (_playerX < _borders[i].x && _playerX > _borders[i + 1].x) {
							_isPlayerOnBorders = true;
							return;
						}
					}
				}
			}
			
			//############ OUTSIDE OF THE LOOP VALUE OF i IS NOW 7###############
			//############### CHECKING LAST AND FIRST VERTEX ####################
			
			//UPDATING BORDERS
			_borderA = i;
			_borderB = 0;
			
			//IS IT ON THE LAST VERTEX?
			if (_playerX == _borders[i].x && _playerY == _borders[i].y) {
				_isPlayerOnBorders = true;
				_isPlayerOnVertex = true;
				_borderB = _borderA;
				return;
			}
			
				//IS IT A VERTICAL BORDER	//IS THE DOT ON THE SAME AXIS?
			if (_borders[i].x == _borders[0].x && _borders[i].x == _playerX) {
				//CHECK IF IT IS AN ASCENDING OR DESCENDING BORDER
				//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
				if (_borders[i].y > _borders[0].y) {
					if (_playerY < _borders[i].y && _playerY > _borders[0].y){
						_isPlayerOnBorders = true;
						return;
					}
				}
				if (_borders[i].y < _borders[0].y) {
					if (_playerY > _borders[i].y && _playerY < _borders[0].y) {
						_isPlayerOnBorders = true;
						return;
					}
				}
			}
			
			 //IS IT AN HORIZONTAL BORDER		//IS THE DOT ON THE SAME AXIS?
			if (_borders[i].y == _borders[0].y && _borders[i].y == _playerY) {
				//CHECK IF BORDER GOES FROM LEFT TO RIGHT OR THE OTHER WAY
				//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
				if (_borders[i].x < _borders[0].x) {
					if (_playerX > _borders[i].x && _playerX < _borders[0].x) {
						_isPlayerOnBorders = true;
						return;
					}
				}
				if (_borders[i].x > _borders[0].x) {
					if (_playerX < _borders[i].x && _playerX > _borders[0].x) {
						_isPlayerOnBorders = true;
						return;
					}
				}
			}
			
			_isPlayerOnBorders = false;
			return;
		}
		
		public function get isPLayerOnBorders():Boolean { return _isPlayerOnBorders }
		public function get isPlayerOnVertex():Boolean { return _isPlayerOnVertex }
		
		public function get vBorders():Vector.<Point> { return _borders }
		
		public function get borderA():int { return _borderA }
		public function get borderB():int {	return _borderB }
		
		public function get canMoveLeft():Boolean 	{ return _canMoveLeft }
		public function get canMoveRight():Boolean 	{ return _canMoveRight }
		public function get canMoveDown():Boolean 	{ return _canMoveDown }
		public function get canMoveUp():Boolean 	{ return _canMoveUp }
	}

}
