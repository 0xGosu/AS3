package game.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class DropEvent extends Event 
	{
		
		public function DropEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new DropEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DropEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}