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
		
		
		
		public function Drawing() 
		{
			
		}
		
		public function init(borders:Borders):void {
			_nodes = new Vector.<Point>();
			_borders = borders;
			_vBorder = borders.vBorders;
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
			_canMoveDown = _canMoveLeft = _canMoveRight = _canMoveUp = false;
			
		}
		
		public function set isDrawing(value:Boolean):void 	{ _isDrawing = value }
		public function get isDrawing():Boolean 			{ return _isDrawing }
		
	}

}