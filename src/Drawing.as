package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Drawing 
	{
		private var _nodes:Vector.<Point>;
		private var _vBorder:Vector.<Point>;
		private var _borders:Borders;
		private var _isDrawing:Boolean;
		
		private var _playerX:int;
		private var _playerY:int;
		
		private var _canMoveUp:Boolean;
		private var _canMoveDown:Boolean;
		private var _canMoveLeft:Boolean;
		private var _canMoveRight:Boolean;
		
		private var _borderA:int;
		private var _borderB:int;
		
		public function Drawing() 
		{
			
		}
		
		public function init(borders:Borders):void {
			_nodes = new Vector.<Point>();
			_borders = borders;
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
		
		public function set isDrawing(value:Boolean):void 	{ _isDrawing = value }
		public function get isDrawing():Boolean 			{ return _isDrawing }
		
		public function get canMoveLeft():Boolean 	{ return _canMoveLeft }
		public function get canMoveRight():Boolean 	{ return _canMoveRight }
		public function get canMoveDown():Boolean 	{ return _canMoveDown }
		public function get canMoveUp():Boolean 	{ return _canMoveUp }
	}

}