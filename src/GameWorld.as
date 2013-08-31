package  
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.Lighting;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author ...
	 */
	public class GameWorld extends World 
	{
		private var lighting:Lighting;
		private var x1:int = 0;
		private var y1:int = 0;
		private var x2:int = 0;
		private var y2:int = 0;
		
		private var debugTxt:Text;
		
		[Embed(source="ASSETS/135005106195.jpg")]
		private const img:Class;
		
		public function GameWorld() 
		{
			add(lighting = new Lighting());
			debugTxt = new Text("WOLOLO!", 10, 10);
			//addGraphic(debugTxt, -120);
			addGraphic(new Image(img));
			
			add(new Player(10, 30));
		}
		
		override public function update():void 
		{
			
			if (Input.mousePressed) {
				x1 = mouseX;
				y1 = mouseY;
				x2 = 0
				y2 = 0;
				refreshText()
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
				
				refreshText()
				
				if (x1 != x2 && y1 != y2) lighting.add(new RemovedSurface(x1, y1, x2, y2));
				x1 = y1 = x2 = y2 = 0;
			}
			
			
			super.update();
		}
		
		private function refreshText():void 
		{
			/*debugTxt.text = "x1: " + x1.toString() + "\ny1: " + y1.toString() + 
						  "\nx2: " + x2.toString() + "\ny2: " + y2.toString();*/
		}
	}

}