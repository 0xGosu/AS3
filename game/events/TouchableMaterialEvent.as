package game.events 
{
	import flash.display.InteractiveObject;
	import flash.events.TouchEvent;
	import game.touch.TouchPoint;
	
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class TouchableMaterialEvent extends TouchEvent 
	{
		
		public function TouchableMaterialEvent(type:String,FirstTouch:TouchPoint,SecondTouch:TouchPoint,touchEvent:TouchEvent, bubbles:Boolean = true, cancelable:Boolean = false) 
		{
			super(type,bubbles,cancelable,touchEvent.touchPointID,touchEvent.isPrimaryTouchPoint,touchEvent.localX,touchEvent.localY,touchEvent.sizeX,touchEvent.sizeY,touchEvent.pressure,touchEvent.relatedObject,touchEvent.ctrlKey,touchEvent.altKey);
			firstTouch = FirstTouch.clone();
			secondTouch = SecondTouch.clone();
		}
		public var firstTouch:TouchPoint = new TouchPoint;
		public var secondTouch:TouchPoint = new TouchPoint;
	}

}