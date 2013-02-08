package game.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class CatchEvent extends Event 
	{
		
		public function CatchEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new CatchEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CatchEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}