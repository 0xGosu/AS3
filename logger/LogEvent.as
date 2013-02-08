package logger
{
	/**
	 * An Event
	 * @author TVA-Created: 10/25/2010
	 * 
	 */
	public final class LogEvent
	{
		/**
		 *Date event has happened 
		 */
		public var date:Date;
		/**
		 *Event description 
		 */
		public var event:*;
		
		/**
		 * Create a LogEvent 
		 * @param pdate Date happended
		 * @param pevent Description
		 * 
		 */
		public function LogEvent(pdate:Date, pevent:*):void 
		{ 
			date = pdate;
			event = pevent;
		}
		/**
		 * String form 
		 * @return date:event
		 * 
		 */
		public function toString():String{
			return String(date)+":"+String(event);
		}
	}
}