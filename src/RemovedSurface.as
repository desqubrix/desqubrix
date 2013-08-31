package  
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class RemovedSurface 
	{
		public var x1:int = 0;
		public var y1:int = 0;
		public var x2:int = 0;
		public var y2:int = 0;
		public var graphic:Image;
		
		public function RemovedSurface(x1:int, y1:int, x2:int, y2:int) 
		{
			this.x1 = x1;
			this.y1 = y1;
			this.x2 = x2;
			this.y2 = y2;
			graphic = new Image(new BitmapData(Math.abs(x1 - x2), Math.abs(y1 - y2), false, 0x000000));
			
		}
		
	}

}