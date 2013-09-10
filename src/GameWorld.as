package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.Lighting;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author ...
	 */
	public class GameWorld extends World 
	{
		private var background:Background;
		private var player:Player;
		
		private var debugTxt:Text;
		
		public function GameWorld() 
		{
			background = new Background();
			player = new Player(10, 30);
			
			add(background);
			add(player);
			
			debugTxt = new Text("WOLOLO!", 10, 10);
			//addGraphic(debugTxt, -120);
		}
		
		
		private function refreshText():void 
		{
			/*debugTxt.text = "x1: " + x1.toString() + "\ny1: " + y1.toString() + 
						  "\nx2: " + x2.toString() + "\ny2: " + y2.toString();*/
		}
	}

}