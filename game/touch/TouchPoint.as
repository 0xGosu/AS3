package game.touch 
{
	import flash.events.TouchEvent;
	import game.effects.transformEffects;
	import mathematic.Vector2D;
	import flash.display.DisplayObject;
	/**
	 * Store date of a touch point eg: possition,status,state,....
	 * @author HD.TVA
	 */
	public class TouchPoint 
	{
		
		public function TouchPoint(evt:TouchEvent=null) 
		{
			if(evt!=null)begin(evt);
		}
		/*
		 * touch point's ID
		 * */
		public var ID:Number = 0 ;
		/*
		 * ID of the last touchPoint that be used by this object
		 * */
		public var previousID:Number = 0;
		/*
		 * possition when the touch point Begin
		*/
		public var beginLocal:Vector2D = new Vector2D;
		public var beginStage:Vector2D = new Vector2D;
		public var beginState:String;
		/*
		 * current possition of the touch point 
		*/
		public var currentLocal:Vector2D = new Vector2D;
		public var currentStage:Vector2D = new Vector2D;
		public var currentState:String;
		
		/*
		 * possition when the touch point End
		*/
		public var endLocal:Vector2D = new Vector2D;
		public var endStage:Vector2D = new Vector2D;
		public var endState:String;
		/*
		checkState and save the data when touch point Begin
		*/
		public function begin(evt:TouchEvent):void {
			if (ID){ trace(" Current Touch Point is still active!");return}
			ID = evt.touchPointID;
			beginLocal.input(evt.localX, evt.localY);
			beginStage.input(evt.stageX, evt.stageY);
			beginState = checkState(evt,cornerRange);
			update(evt); 
			currentState = TouchPoint.IN;
		}
		/*save the current data of the touch point*/
		public function update(evt:TouchEvent):void {
			if (evt.touchPointID != ID) { trace("Wrong touchPointID, function update( ) do nothing!"); return; }
			currentLocal.input(evt.localX, evt.localY);
			currentStage.input(evt.stageX, evt.stageY);
		}
		/*
		checkState and save the data when touch point End {PreviousID=ID;ID=0;}
		*/
		public function end(evt:TouchEvent):void {
			if (evt.touchPointID != ID) { trace("Wrong touchPointID, function end( ) do nothing!"); return; }
			endLocal.input(evt.localX, evt.localY);
			endStage.input(evt.stageX, evt.stageY);
			endState = checkState(evt, cornerRange);
			previousID = ID;
			ID = 0;
		}
		/*generate a clone of this object*/
		public function clone():TouchPoint {
			var newTouchPoint:TouchPoint = new TouchPoint;
			newTouchPoint.beginLocal.copy(beginLocal);
			newTouchPoint.beginStage.copy(beginStage);
			newTouchPoint.beginState = beginState;
			
			newTouchPoint.currentLocal.copy(currentLocal);
			newTouchPoint.currentStage.copy(currentStage);
			newTouchPoint.currentState = currentState;
			
			newTouchPoint.endLocal.copy(endLocal);
			newTouchPoint.endStage.copy(endStage);
			newTouchPoint.endState = endState;
			
			newTouchPoint.ID = ID;
			newTouchPoint.previousID = previousID;
			newTouchPoint.cornerRange = cornerRange;
			
			return newTouchPoint;
		}
		public function toString():String {
			return "ID:" + ID + "|Local:" + currentLocal + "|Stage:" + currentStage;
		}
		public var cornerRange:Number = 0.2;
		public static var Top:String = "Top";
		public static var TopLeft:String = "TopLeft";
		public static var TopRight:String = "TopRight";
		public static var Bot:String = "Bot";
		public static var BotLeft:String = "BotLeft";
		public static var BotRight:String = "BotRight";
		public static var Left:String = "Left";
		public static var Right:String = "Right";
		public static var Center:String = "Center";
		public static var Unknow:String = "Unknow";
		public static var IN:String = "IN";
		public static var OUT:String = "OUT";
		/*check a state that also mean IN*/
		public static function isIN(state:String):Boolean {
			switch(state) {
				case TouchPoint.IN:return true;
				case TouchPoint.Center:return true;
				case TouchPoint.Top:return true;
				case TouchPoint.TopLeft:return true;
				case TouchPoint.TopRight:return true;
				case TouchPoint.Bot:return true;
				case TouchPoint.BotLeft:return true;
				case TouchPoint.BotRight:return true;
				case TouchPoint.Left:return true;
				case TouchPoint.Right:return true;
			}
			return false;
		}
		/*check the State of the touch point by a touchEvent (eg: IN, OUT, Top, Left,...)*/
		public function checkState(evt:TouchEvent,CornerRange:Number=0.2):String {
			if (CornerRange > 0.5) { trace("CornerRange too big (reach >0.5) return Unknow!"); return TouchPoint.Unknow }
			var object:DisplayObject = evt.target as DisplayObject;
			//conner touch check
				var trueX:Number = evt.localX ;
				var trueY:Number = evt.localY ;
				var originalWidthHeight:Vector2D = transformEffects.getOriginalWidthHeight(object); 
				var width:Number = originalWidthHeight.x;
				var height:Number = originalWidthHeight.y;
				//Left touch
				if (trueX > 0 && trueX < CornerRange * width) var leftTouch:Boolean = true; else leftTouch = false;
				//Right touch
				if (trueX > (1 - CornerRange) * width && trueX < width) var rightTouch:Boolean = true; else rightTouch = false;
				//Top touch
				if (trueY > 0 && trueY < CornerRange * height) var topTouch:Boolean = true; else topTouch = false;
				//Bot touch
				if (trueY > (1 - CornerRange) * height && trueY < height) var botTouch:Boolean = true; else botTouch = false;
				if ((topTouch || botTouch || leftTouch || rightTouch)) {
					if (topTouch) {
						if (leftTouch) return  TouchPoint.TopLeft;
						else if (rightTouch) return  TouchPoint.TopRight;
						else return  TouchPoint.Top;
					}else 
					if (botTouch) {
						if (leftTouch) return  TouchPoint.BotLeft;
						else if (rightTouch) return  TouchPoint.BotRight;
						else return  TouchPoint.Bot;
					}else 
					if (leftTouch) return TouchPoint.Left;
					else 
					if (rightTouch) return TouchPoint.Right;
				}else return  TouchPoint.Center;
			return TouchPoint.Unknow;
		}
	}
}