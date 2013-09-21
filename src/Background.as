package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import net.Lighting;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Background extends Entity 
	{
		[Embed(source="ASSETS/background_placeholder.jpg")]
		private const BG_IMAGE:Class;
		
		public var img:Image;
		
		public function Background() 
		{
			img = new Image(BG_IMAGE);
			super(0, 0, img);
			
			layer = GC.LAYER_BG;
		}
		
		
	}

}