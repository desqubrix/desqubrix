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
		public static var id:GameWorld;
		
		public var player:Player;
		public var borders:Borders;
		public var line:Line;
		public var background:Background;
		public var overlay:Overlay;
		
		public function GameWorld() 
		{
			player = new Player(10, 30);
			borders = new Borders();
			line = new Line(borders);
			background = new Background();
			overlay = new Overlay(borders);
			
			id = this;
			
			add(player);
			add(background);
			add(overlay);
		}
		
		override public function update():void 
		{
			borders.update(player.x, player.y);
			line.update(player.x, player.y);
			super.update();
		}
	}

}