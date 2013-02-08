package game
{
	import flash.display.Sprite;

	/**
	 * 
	 * @author TVA-Created 11/14/2010
	 * 
	 */
	public class Gobject
	{
		public function Gobject(system:Gsystem)
		{
			
			sys=system;
			system.push(this);
		}
		public var sys:Gsystem;
		public function step():void{
		}
	}
}