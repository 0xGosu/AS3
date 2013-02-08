package game.events 
{
	import flash.events.Event;
	import mathematic.Vector2D;
	
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class ThrowEvent extends Event 
	{
		
		public function ThrowEvent(type:String, v:Vector2D=null , bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			if(v!=null)velocity = v.clone();
		} 
		public var velocity:Vector2D =null;
		public override function clone():Event 
		{ 
			return new ThrowEvent(type,velocity, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ThrowEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}