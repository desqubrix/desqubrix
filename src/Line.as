package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Line 
	{
		private var _nodes:Vector.<Point>;
		private var _vBorder:Vector.<Point>;
		private var _borders:Borders;
		
		private var _borderPosition:Array;
		
		private var _playerX:int;
		private var _playerY:int;
		
		private var _currentDirection:Point;
		private var _previousDirection:Point
		
		private var _didChangeDirection:Boolean;
		
		private var _canMoveUp:Boolean;
		private var _canMoveDown:Boolean;
		private var _canMoveLeft:Boolean;
		private var _canMoveRight:Boolean;
		
		private var _borderA:int;
		private var _borderB:int;
		
		private var _isDrawing:Boolean;
		
		public function Line(borders:Borders) 
		{
			_borders = borders;
			_nodes = new Vector.<Point>();
			_currentDirection = new Point();
			_previousDirection = new Point();
			_borderPosition = new Array();
		}
		
		public function init():void {
			//DO I NEED TO EVER RESET THIS ONE?
		}
		
		public function addNodesToBorders():void
		{
			_borderPosition.sort();
			
			
			
			// ######################################################
			//		STIL TRYING TO FIGURE OUT THIS ONE!
			// ######################################################
			
			var deleteAmount:int = _borderPosition[_borderPosition.length - 1] - _borderPosition[0] - 1;
			
			//_borders.vBorders.splice(_borderPosition[1] - 1, deleteAmount);
			
			trace("borders pre :", _borders.vBorders);
			
			var firstPart:Vector.<Point> = _vBorder.slice(0, _borderPosition[1]);
			var secondPart:Vector.<Point> = _vBorder.slice(_borderPosition[1] + deleteAmount);
			
			_borders.vBorders = firstPart.concat(secondPart, _nodes);
			
			/*
			 * 
			 */
			
			trace("1st          ", firstPart);
			trace("2nd          ", secondPart);
			trace("borders post:", _borders.vBorders);
			trace("nodos        ", _nodes);
			trace("array con posiciones", _borderPosition);
			_nodes = new Vector.<Point>();
			_borderPosition = new Array();
		}
		
		public function addNode(node:Point):void
		{
			_nodes.push(node);
		}
		
		public function update(x:int, y:int):void
		{
			_playerX = x;
			_playerY = y;
			updatePossibleMovements();
			//trace(_nodes);
			//trace(_borderPosition);
		}
		
		private function updatePossibleMovements():void
		{
			_vBorder = _borders.vBorders;
			
			_canMoveDown = _borders.canMoveDown;
			_canMoveLeft = _borders.canMoveLeft;
			_canMoveRight = _borders.canMoveRight;
			_canMoveUp = _borders.canMoveUp;
			
			_borderA = _borders.borderA
			_borderB = _borders.borderB;
			
			
			if (_borders.isPLayerOnBorders && !_borders.isPlayerOnVertex) 
			{
				//VERTICAL BORDER
				if (_vBorder[_borderA].x == _vBorder[_borderB].x) 
				{
					if (_vBorder[_borderA].y < _vBorder[_borderB].y) _canMoveLeft = true;
					else if (_vBorder[_borderA].y > _vBorder[_borderB].y) _canMoveRight = true;
				}
				
				//HORIZONTAL BORDER
				if (_vBorder[_borderA].y == _vBorder[_borderB].y)
				{
					if (_vBorder[_borderA].x < _vBorder[_borderB].x) _canMoveDown = true;
					else if (_vBorder[_borderA].x > _vBorder[_borderB].x) _canMoveUp = true;
				}
			}
			else {
				_canMoveDown = _canMoveLeft = _canMoveRight = _canMoveUp = true;
			}
		}

		
		public function get canMoveLeft():Boolean 	  { return _canMoveLeft 	 }
		public function get canMoveRight():Boolean 	  { return _canMoveRight 	 }
		public function get canMoveDown():Boolean 	  { return _canMoveDown 	 }
		public function get canMoveUp():Boolean 	  { return _canMoveUp 		 }
		
		public function get currentDirection():Point  { return _currentDirection  }
		public function get previousDirection():Point { return _previousDirection }
		
		public function set currentDirection(p:Point):void  { _currentDirection = p }
		public function set previousDirection(p:Point):void { _previousDirection = p }
		
		public function get nodes():Vector.<Point> { return _nodes }
		
		public function get borderPosition():Array { return _borderPosition }
	}

}