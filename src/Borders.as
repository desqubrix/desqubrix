package  
{
	import flash.geom.Point;
	import net.flashpunk.FP;
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
		
		private var _playerX:int;
		private var _playerY:int;
		
		public function Borders() 
		{
			init();
		}
		
		public function init():void
		{
			_borders = new Vector.<Point>();
			
			_borders.push(new Point(10, 30));
			_borders.push(new Point(20, 30));
			_borders.push(new Point(20, 20));
			_borders.push(new Point(40, 20));
			_borders.push(new Point(40, 10));
			
			_borders.push(new Point(FP.screen.width - 10, 10));
			_borders.push(new Point(FP.screen.width - 10, FP.screen.height - 10));
			_borders.push(new Point(10, FP.screen.height - 10));
			_borderA = 0;
			_borderB = 0;
		}
		
		public function update(x:Number, y:Number):void
		{
			_playerX = x;
			_playerY = y;
			_isPlayerOnBorders = checkPlayerOnBorders();
		}
		
		private function checkPlayerOnBorders():Boolean
		{
			for (var i:int = 0; i < _borders.length - 1; i++) {
				//CHECK IF IT IS ON A VERTEX
				if (_playerX == _borders[i].x && _playerY == _borders[i].y) return true;
				
					 //IS IT A VERTICAL BORDER			//IS THE DOT ON THE SAME AXIS?
				if (_borders[i].x == _borders[i + 1].x && _borders[i].x == _playerX) {
					//CHECK IF IT IS AN ASCENDING OR DESCENDING BORDER
					//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
					if (_borders[i].y > _borders[i + 1].y) {
						if (_playerY < _borders[i].y && _playerY > _borders[i + 1].y) return true;
					}
					if (_borders[i].y < _borders[i + 1].y) {
						if (_playerY > _borders[i].y && _playerY < _borders[i + 1].y) return true;
					}
				}

					 //IS IT AN HORIZONTAL BORDER		//IS THE DOT ON THE SAME AXIS?
				if (_borders[i].y == _borders[i + 1].y && _borders[i].y == _playerY) {
					//CHECK IF BORDER GOES FROM LEFT TO RIGHT OR THE OTHER WAY
					//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
					if (_borders[i].x < _borders[i + 1].x) {
						if (_playerX > _borders[i].x && _playerX < _borders[i + 1].x) return true;
					}
					if (_borders[i].x > _borders[i + 1].x) {
						if (_playerX < _borders[i].x && _playerX > _borders[i + 1].x) return true;
					}
				}
			}
			
			//############ OUTSIDE OF THE LOOP VALUE OF i IS NOW 7###############
			//############### CHECKING LAST AND FIRST VERTEX ####################
			
			if (_playerX == _borders[i].x && _playerY == _borders[i].y) return true;
			
				//IS IT A VERTICAL BORDER	//IS THE DOT ON THE SAME AXIS?
			if (_borders[i].x == _borders[0].x && _borders[i].x == _playerX) {
				//CHECK IF IT IS AN ASCENDING OR DESCENDING BORDER
				//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
				if (_borders[i].y > _borders[0].y) {
					if (_playerY < _borders[i].y && _playerY > _borders[0].y) return true;
				}
				if (_borders[i].y < _borders[0].y) {
					if (_playerY > _borders[i].y && _playerY < _borders[0].y) return true;
				}
			}
			
			 //IS IT AN HORIZONTAL BORDER		//IS THE DOT ON THE SAME AXIS?
			if (_borders[i].y == _borders[0].y && _borders[i].y == _playerY) {
				//CHECK IF BORDER GOES FROM LEFT TO RIGHT OR THE OTHER WAY
				//RETURN THE CHECK OF THE DOT CONTAINED ON THE LINE
				if (_borders[i].x < _borders[0].x) {
					if (_playerX > _borders[i].x && _playerX < _borders[0].x) return true;
				}
				if (_borders[i].x > _borders[0].x) {
					if (_playerX < _borders[i].x && _playerX > _borders[0].x) return true;
				}
			}
			
			return false;
		}
		
		public function get isPLayerOnBorders():Boolean 
		{
			return _isPlayerOnBorders;
		}
		
		public function get vBorders():Vector.<Point>
		{
			return _borders;
		}
	}

}