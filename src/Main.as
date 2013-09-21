package 
{
	import net.flashpunk.FP;
	import net.flashpunk.Engine;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;

	
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
			/*var a:Vector.<int> = new Vector.<int>();
			var b:Vector.<int> = new Vector.<int>();
			
			var firstPart:Vector.<int>;
			var secondPart:Vector.<int>;
			
			
			a.push(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
			b.push(3, 4);
			
			trace("a:", a);
			trace("b:", b);
			
			firstPart = a.slice(0, 3);
			secondPart = a.slice(3 + 6);
			trace("1st", firstPart);
			trace("2nd", secondPart);
			
			a = new Vector.<int>();
			a = firstPart.concat(secondPart, b);
			
			//a.concat
			
			//a.splice(3, 6, 3, 4);
			trace(a);*/
			
			
			
		}
	}
	
}