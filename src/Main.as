package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Main extends Engine 
	{
		public function Main():void
		{
			super(700, 525, 60, false);
			FP.screen.color = 0x123f456;
			FP.console.enable();
		}
		
		override public function init():void 
		{
			FP.world = new GameWorld();
			Input.define("cursor", Key.LEFT, Key.RIGHT, Key.UP, Key.DOWN);
		}
	}
	
}