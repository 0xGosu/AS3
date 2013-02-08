package game.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class ResizeEvent extends Event 
	{
		
		public function ResizeEvent(type:String,witdhSize:Number,heightSize:Number=0, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			width = witdhSize;
			if (heightSize) height = heightSize;
			else height = width;
		} 
		public var width:Number;
		public var height:Number;
		public override function clone():Event 
		{ 
			return new ResizeEvent(type,width,height, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ResizeEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}