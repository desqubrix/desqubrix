package  
{
	import net.Lighting;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Background extends Entity 
	{
		[Embed(source="ASSETS/135005106195.jpg")]
		private const BG_IMAGE:Class;
		
		public var img:Image;
		private var x1:int = 0;
		private var y1:int = 0;
		private var x2:int = 0;
		private var y2:int = 0;
		
		private var mouseX:int;
		private var mouseY:int;
		
		private var gameWorld:GameWorld;
		private var lighting:Lighting;
		
		public function Background() 
		{
			img = new Image(BG_IMAGE);
			super(0, 0, img);
			
			layer = GC.LAYER_BG;
			
			lighting = new Lighting();
		}
		
		override public function added():void 
		{
			gameWorld = FP.world as GameWorld;
			gameWorld.add(lighting);
			super.added();
		}
		
		override public function update():void 
		{
			mouseX = Input.mouseX;
			mouseY = Input.mouseY;
			
			eraseSurface();
			
			super.update();
		}
		
		private function eraseSurface():void
		{
			if (Input.mousePressed) {
				x1 = mouseX;
				y1 = mouseY;
				x2 = 0
				y2 = 0;
			}
			if (Input.mouseReleased) {
				if (x1 > mouseX) {
					x2 = x1;
					x1 = mouseX;
				}
				else {
					x2 = mouseX;
				}
				
				if (y1 > mouseY) {
					y2 = y1;
					y1 = mouseY;
				}
				else {
					y2 = mouseY;
				}
				
				
				if (x1 != x2 && y1 != y2) lighting.add(new RemovedSurface(x1, y1, x2, y2));
				x1 = y1 = x2 = y2 = 0;
				
			}
		}
		
		
	}

}