package game.events 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class MultiEventsGenerator 
	{
		
		public function MultiEventsGenerator(Subject:EventDispatcher,syncTimer:Timer=null) 
		{
			subject = Subject;
			if (syncTimer) timer = syncTimer;
			else timer = new Timer(MultiEventsGenerator.delay);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, TimerHandle);
		}
		/*duration of an SimultaneousEvent (ms)
		*/
		public var simultaneousDuration:Number = 100;
		/*Minimum number Of Events In SimultaneousEvent to dispatch (>=2)*/
		public var simultaneousMinLength:Number = 2;
		/*Maximum number Of Events In SimultaneousEvent to dispatch (>=2)*/
		public var simultaneousMaxLength:Number = 6;
		
		/*
		maximum different duration between 2 events in a comboEvent (ms)*/
		public var comboDifferent:Number = 300;
		/*Minimum number Of Events In ComboEvent to dispatch (>=2)*/
		public var comboMinLength:Number = 2;
		/*Maximum number Of Events In ComboEvent to dispatch (>=2)*/
		public var comboMaxLength:Number = 20;
				
		/*maximum waiting time to ocurr singleEvent (ms)*/
		public var singleWait:Number = 1000;
		
		/*Subject for catching and dispatching events*/
		private var subject:EventDispatcher;

		/*Timer act as a stopwatch*/
		private var timer:Timer;
		/*list of all Events are listening for checking multiEvent*/
		private var listEventName:Array = new Array();
		
		public function addListeningEvent(eventName:String):void {
			subject.addEventListener(eventName, handleEvents);
			listEventName.push(eventName);
		}
		public function removeListeningEvent(eventName:String):void {
			subject.removeEventListener(eventName, handleEvents);
			listEventName.splice(listEventName.lastIndexOf(eventName), 1);
		}
		public function removeAllListeningEvent():void {
			for each (var eventName:String in listEventName ) 
			{
				subject.removeEventListener(eventName, handleEvents);
			}
			listEventName=new Array;
		}
		
		
		public function catchEvent(evt:Event):void {
			var currentTime:Number = timer.currentCount * timer.delay;
			checkSimultaneousEvent(evt,currentTime);
			checkComboEvent(evt, currentTime);
			checkSingleEvent(evt, currentTime);
		}
		
		private function handleEvents(evt:Event):void {
			catchEvent(evt);
		}
		
		private var simultaneousEvent:Array=new Array;
		private var simultaneousTimesOccur:Array= new Array;
		public function checkSimultaneousEvent(evt:Event,time:Number):Boolean {
			if (simultaneousEvent.length) {
				if (time < simultaneousTimesOccur[0]) return false;
				if(time-simultaneousTimesOccur[0] <= simultaneousDuration) {
					
					simultaneousEvent.push(evt);
					simultaneousTimesOccur.push(time);
					
					if (simultaneousEvent.length == simultaneousMinLength) 
					subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.SimultaneousEventStartEvent, simultaneousEvent, simultaneousTimesOccur));
					if(simultaneousEvent.length >= simultaneousMaxLength){
						subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.SimultaneousEventReachMaxEvent, simultaneousEvent, simultaneousTimesOccur));
						simultaneousEvent = new Array();
						simultaneousTimesOccur = new Array();
					}
					return true;
				}
				
			}else {
				
				simultaneousEvent.push(evt);
				simultaneousTimesOccur.push(time);
				return false;
			}
			return false;
		}
		
		private var comboEvent:Array=new Array;
		private var comboTimesOccur:Array= new Array;
		public function checkComboEvent(evt:Event, time:Number):Boolean { 
			if (comboEvent.length) {
				if (time < comboTimesOccur[comboTimesOccur.length-1]) return false;
				if(time-comboTimesOccur[comboTimesOccur.length-1] <= comboDifferent) {
					
					comboEvent.push(evt);
					comboTimesOccur.push(time);
					
					if (comboEvent.length == comboMinLength) 
					subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.ComboEventStartEvent, comboEvent, comboTimesOccur));
					if (comboEvent.length >= comboMinLength)
					subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.ComboEventEvent, comboEvent, comboTimesOccur));
					if (comboEvent.length >= comboMaxLength){
						subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.ComboEventReachMaxEvent , comboEvent, comboTimesOccur));
						comboEvent = new Array();
						comboTimesOccur = new Array();
					}
					return true;
				}
				
			}else {
				
				comboEvent.push(evt);
				comboTimesOccur.push(time);
				return false;
			}
			return false;
		}
		private var singleEvent:Array=new Array;
		private var singleTimeOccur:Array = new Array;
		public function checkSingleEvent(evt:Event, time:Number):void { 	
				singleEvent[0]=evt;
				singleTimeOccur[0] = time;
		}
		
		private function TimerHandle(evt:TimerEvent):void {
			var currentTime:Number = timer.currentCount * timer.delay;
			if (simultaneousEvent.length && currentTime > simultaneousTimesOccur[0] + simultaneousDuration) {
				if(simultaneousEvent.length>=simultaneousMinLength){
					subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.SimultaneousEventEvent, simultaneousEvent, simultaneousTimesOccur));
					
				}else {
					if(simultaneousEvent.length>=2)
					subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.SimultaneousEventEndSoonEvent, simultaneousEvent, simultaneousTimesOccur));
				}
				simultaneousEvent = new Array();
				simultaneousTimesOccur = new Array();
				
			}
			if (comboEvent.length && currentTime > comboTimesOccur[comboTimesOccur.length-1] + comboDifferent) {
				if(comboEvent.length>=comboMinLength){
					subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.ComboEventFinishEvent, comboEvent, comboTimesOccur));
					
				}else {
					if (comboEvent.length >= 2)
					subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.ComboEventEndSoonEvent, comboEvent, comboTimesOccur));
					
				}
				comboEvent = new Array();
				comboTimesOccur = new Array();
				
			}
			if (singleEvent.length) {
				if (currentTime > singleTimeOccur[0] + singleWait) {
					subject.dispatchEvent(new MultiEventsEvent(MultiEventsGenerator.SingleEventEvent, singleEvent, singleTimeOccur));
					singleEvent = new Array;
					singleTimeOccur = new Array;
				}
			}
		}
		
		
		public static var delay:Number = 100;
		
		public static var SimultaneousEventStartEvent:String = "SimultaneousEventStart";
		public static var SimultaneousEventReachMaxEvent:String = "SimultaneousEventReachMax";
		public static var SimultaneousEventEndSoonEvent:String = "SimultaneousEventEndSoon";
		public static var SimultaneousEventEvent:String = "SimultaneousEvent";
		
		public static var ComboEventStartEvent:String = "ComboEventStart";
		public static var ComboEventEvent:String = "ComboEvent";
		public static var ComboEventEndSoonEvent:String = "ComboEventEndSoon";
		public static var ComboEventReachMaxEvent:String = "ComboEventReachMax";
		public static var ComboEventFinishEvent:String = "ComboEventFinish";
		
		public static var SingleEventEvent:String = "SingleEvent";
		
	}

}