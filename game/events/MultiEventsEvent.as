package game.events 
{
	import flash.events.Event;
	
	/**
	 * MultiEvent (such as Combo and Simultaneous Event, single Event)
	 * @author HD.TVA
	 */
	public class MultiEventsEvent extends Event 
	{
		
		public function MultiEventsEvent(type:String, Events:Array , TimesOccur:Array, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			events = Events;
			timesOccur = TimesOccur;
		}
		public var events:Array;
		public var timesOccur:Array;
		
	}

}