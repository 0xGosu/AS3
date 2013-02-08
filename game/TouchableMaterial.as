package game 
{
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.display.InteractiveObject;
	import flash.utils.Timer;
	import game.effects.transformEffects;
	import game.events.MultiEventsEvent;
	import game.events.MultiEventsGenerator;
	import game.events.TouchableMaterialEvent;
	import game.touch.TouchPoint;
	import mathematic.math;
	import mathematic.Vector2D;

	
	/**
	 * Make an Interactive Object become touchable
	 * @author HD.TVA
	 */
	public class TouchableMaterial 
	{
		
		public function TouchableMaterial(object:InteractiveObject) 
		{
			sprite = object;
			var vector:Vector2D = transformEffects.getOriginalWidthHeight(sprite);
			width = vector.x;
			height = vector.y;
			p = new IntergratedVector2D(sprite);
			
			sprite.addEventListener(TouchEvent.TOUCH_BEGIN, TouchBeginHandle);
			sprite.addEventListener(TouchEvent.TOUCH_END, TouchEndHandle);
					
			sprite.addEventListener(TouchEvent.TOUCH_ROLL_OUT, TouchOutHandle);
			sprite.addEventListener(TouchEvent.TOUCH_ROLL_OVER, TouchOverHandle);
			
			//sprite.addEventListener(TouchEvent.TOUCH_MOVE, ShowTouchPoint);
			//sprite.addEventListener(TouchEvent.TOUCH_END, EndShow);
			
			//listening to simultaneous , combo , single event
			var eventGenerator:MultiEventsGenerator = new MultiEventsGenerator(sprite);
			eventGenerator.addListeningEvent(TouchableMaterial.firstTouchBegin);
			eventGenerator.addListeningEvent(TouchableMaterial.secondTouchBegin);
			eventGenerator.addListeningEvent(TouchableMaterial.firstTouchEnd);
			eventGenerator.addListeningEvent(TouchableMaterial.secondTouchEnd);
			eventGenerator.addListeningEvent(TouchableMaterial.firstTouchMove);
			sprite.addEventListener(MultiEventsGenerator.ComboEventFinishEvent, handleComboEvent);
			sprite.addEventListener(MultiEventsGenerator.SimultaneousEventEvent, handleComboEvent);
			sprite.addEventListener(MultiEventsGenerator.SingleEventEvent, handleComboEvent);
		}
		public function handleComboEvent(evt:MultiEventsEvent):void {
			//trace(evt.type + " = " + evt.events.length);
			if (evt.type == MultiEventsGenerator.SimultaneousEventEvent) {
				if (evt.events.length == 2) {
					if (evt.events[0].type == TouchableMaterial.firstTouchBegin && evt.events[1].type == TouchableMaterial.firstTouchEnd) dispatchEvent(singleTap,evt.events[0]);
				}
				if (evt.events.length == 4) {
					if (evt.events[0].type == TouchableMaterial.firstTouchBegin && evt.events[1].type == TouchableMaterial.secondTouchBegin&&((evt.events[2].type == TouchableMaterial.firstTouchEnd&&evt.events[3].type == TouchableMaterial.secondTouchEnd)||(evt.events[2].type == TouchableMaterial.secondTouchEnd&&evt.events[3].type == TouchableMaterial.firstTouchEnd)))dispatchEvent(singleTwinTap,evt.events[0]);
				}
			}
		}
		
		
		private var sprite:InteractiveObject;
		private var width:Number ;
		private var height:Number ;
		/*vector intergrated with sprite's possition*/
		private var p:IntergratedVector2D;
		/*The touchPoint that touch the object first.
		 * While this touch is still availble, any touch Begin will save in seconTouch
		*/
		private var firstTouch:TouchPoint = new TouchPoint;
		/*The touchPoint that touch the object second.
		 * While this touch and firstTouch are still availble, any touch Begin will not be saved 
		 * But firstTouch is not availble (end while second still) any touch will orrcur firstTouchBeginLate event and data will be saved in firstTouch.
		*/
		private var secondTouch:TouchPoint = new TouchPoint;
		
		//touch
		/*define cornerRange to check cornerTouch (percentive)*/
		public var cornerRange:Number = 0.2;
		/*the minnimum distance to generate a TouchMove event*/
		private var minTouchMoveRange:Number = 3;
		/*the minnimum distance to generate a TouchMove event when have only 1 touchPoint*/
		public var oneTouchMinMove:Number = 3;
		/*the minnimum distance to generate a TouchMove event when have both touchpoint*/
		public var twoTouchMinMove:Number = 5;
		/*will Update after event ? */
		public var updateAfterEvent:Boolean = false;
		/*0 means no drag
		 * 1 means drag with only firstTouch
		 * 2 means drag require both2 touch (still folow first Touch)*/
		public var dragMode:Number = 1;
		/*if true, object can be drag event touchPoint is OUT*/
		public var stageDrag:Boolean = true;
		/*Scale and rotate enable value
		 * 0 means no scale either rotate
		 * 1 means scale only
		 * 2 means both
		 * 3 means rotate only*/
		public var freeScaleAndRotateMode:Number = 2;
		public var stageScaleAndRotate:Boolean = true;
		public var Xscale:Number = 1;
		/* either one of these 2 value below this value will stop scale*/
		public var minWidthHeight:Number = 80;
		/*maximum value for width and height of object
		 * either one of these 2 value above this value will stop scale*/
		public var maxWidthHeight:Number = 1000;
		
		/*scale and Rotate when secondTouch move (firstTouch is centerpoint)*/
		private function freeScaleAndRotateBysecondTouch(secondTouchDiff:Vector2D):void {
			var curDiff:Vector2D = secondTouch.currentStage.minus(firstTouch.currentStage);
			var lastDiff:Vector2D = curDiff.minus(secondTouchDiff);
			if (freeScaleAndRotateMode == 2 || freeScaleAndRotateMode == 3) transformEffects.rotate(sprite, curDiff.angle-lastDiff.angle, firstTouch.currentLocal);
			var lengthScale:Number = curDiff.length / lastDiff.length;
							//handle scale
			if (lengthScale > 1 && (sprite.width*Xscale * lengthScale > maxWidthHeight || sprite.height*Xscale * lengthScale > maxWidthHeight)) return;
			if (lengthScale < 1 && (sprite.width*Xscale * lengthScale < minWidthHeight || sprite.height*Xscale * lengthScale < minWidthHeight)) return;
			if (freeScaleAndRotateMode == 2 || freeScaleAndRotateMode == 1) transformEffects.scale(sprite,lengthScale ,0, firstTouch.currentLocal);
		}
		/*scale and Rotate when firstTouch move (firstTouch is centerpoint)*/
		private function freeScaleAndRotateByfirstTouch(firstTouchDiff:Vector2D):void {
			var curDiff:Vector2D = firstTouch.currentStage.minus(secondTouch.currentStage);
			var lastDiff:Vector2D = curDiff.minus(firstTouchDiff);
			if (freeScaleAndRotateMode == 2 || freeScaleAndRotateMode == 3) transformEffects.rotate(sprite, curDiff.angle-lastDiff.angle, firstTouch.currentLocal);
			var lengthScale:Number = curDiff.length / lastDiff.length;
							//handle scale
			if (lengthScale > 1 && (sprite.width*Xscale * lengthScale > maxWidthHeight || sprite.height*Xscale * lengthScale > maxWidthHeight)) return;
			if (lengthScale < 1 && (sprite.width*Xscale * lengthScale < minWidthHeight || sprite.height*Xscale * lengthScale < minWidthHeight)) return;
			if (freeScaleAndRotateMode == 2 || freeScaleAndRotateMode == 1) transformEffects.scale(sprite,lengthScale ,0, firstTouch.currentLocal);
		}
		
		private function TouchBeginHandle(evt:TouchEvent):void {
			//trace(evt.touchPointID);
			
			if (!firstTouch.ID) {
				//recognize first touch point
				firstTouch.begin(evt);
				//trace("FirstPointBegin "+firstTouch.beginState);
				//add event listener if no touch available
				if (!secondTouch.ID) {
					dispatchEvent(TouchableMaterial.TouchBegin,evt);
					minTouchMoveRange = oneTouchMinMove;
					firstTouch.previousID = 0;
					secondTouch.previousID = 0;
					
					sprite.addEventListener(TouchEvent.TOUCH_MOVE, TouchMoveHandle);
					sprite.stage.removeEventListener(TouchEvent.TOUCH_MOVE, TouchMoveStageHandle);
					sprite.stage.removeEventListener(TouchEvent.TOUCH_END, TouchEndStageHandle);
					
				}else {//firstTouch begin when secondTouch still available
					dispatchEvent(TouchableMaterial.firstTouchBeginLate,evt);
				}
				dispatchEvent(TouchableMaterial.firstTouchBegin,evt);
			}else {
				if (!secondTouch.ID) {
					//recoginze touch point 2
					secondTouch.begin(evt);
					minTouchMoveRange = twoTouchMinMove;
					//trace("SecondPointBegin "+secondTouch.beginState);
					dispatchEvent(TouchableMaterial.secondTouchBegin,evt);
				}else {
					dispatchEvent(TouchableMaterial.anotherTouchBegin,evt);
				}
			}
			
			
			if (updateAfterEvent) evt.updateAfterEvent();
		}
		
		
		private function TouchMoveHandle(evt:TouchEvent):void {
			//current stage location of TouchPoint
			var currentTouch:Vector2D = new Vector2D(evt.stageX, evt.stageY);
				
			if (evt.touchPointID == firstTouch.ID) {				
				//check for true touchMove
				var firstTouchDiff:Vector2D = currentTouch.minus(firstTouch.currentStage);
				if (firstTouchDiff.length < minTouchMoveRange || firstTouch.currentState==TouchPoint.OUT) {
					return;
				}
				//update first touch location
				firstTouch.update(evt);
				dispatchEvent(TouchableMaterial.firstTouchMove, evt);
				//extended features
				if (freeScaleAndRotateMode && secondTouch.ID) {
					freeScaleAndRotateByfirstTouch(firstTouchDiff);
				}
				//firstTOuchdrag
				if (dragMode == 1 || (dragMode == 2 && secondTouch.ID )) {
					p.splus(firstTouchDiff);
				}
				
			}else
			if (evt.touchPointID == secondTouch.ID) {
				//check for true touchMove
				var secondTouchDiff:Vector2D = currentTouch.minus(secondTouch.currentStage);
				if (secondTouchDiff.length < minTouchMoveRange || firstTouch.currentState==TouchPoint.OUT) {
					return;
				}
				//update touchPoint2
				secondTouch.update(evt);
				dispatchEvent(TouchableMaterial.secondTouchMove, evt);	
				//extended features
				if (freeScaleAndRotateMode) {
					freeScaleAndRotateBysecondTouch(secondTouchDiff);
				}
				
			}else {
				dispatchEvent(TouchableMaterial.anotherTouchMove,evt);
			}
			if (updateAfterEvent) evt.updateAfterEvent();
		}
		private function TouchEndHandle(evt:TouchEvent):void {
			if (evt.touchPointID == firstTouch.ID) { 
				firstTouch.end(evt);
				dispatchEvent(TouchableMaterial.firstTouchEnd,evt);
				if (!secondTouch.ID) {
					dispatchEvent(TouchableMaterial.TouchEnd,evt);
				}
			}else
			if (evt.touchPointID == secondTouch.ID) {
				secondTouch.end(evt);
				dispatchEvent(TouchableMaterial.secondTouchEnd,evt);
				if (!firstTouch.ID) {
					dispatchEvent(TouchableMaterial.TouchEnd,evt);
				}
			}else
			{	
				dispatchEvent(TouchableMaterial.anotherTouchEnd,evt);
			}
			// remove all event listener if both touch are !available
			if (!firstTouch.ID && !secondTouch.ID) {
				sprite.removeEventListener(TouchEvent.TOUCH_MOVE, TouchMoveHandle);
					
				sprite.stage.removeEventListener(TouchEvent.TOUCH_MOVE, TouchMoveStageHandle);
				sprite.stage.removeEventListener(TouchEvent.TOUCH_END, TouchEndStageHandle);
			}
			if (updateAfterEvent) evt.updateAfterEvent();
		}
		/*Touch Point moved out*/
		private function TouchOutHandle(evt:TouchEvent):void {
			dispatchEvent(TouchableMaterial.TouchOut,evt);
			// correct mistake situation
			
			//add event listener if both touch Point are IN or !available
			if ((!firstTouch.ID||firstTouch.currentState == TouchPoint.IN) && (!secondTouch.ID||secondTouch.currentState == TouchPoint.IN)&&(firstTouch.ID||secondTouch.ID)) {
				sprite.stage.addEventListener(TouchEvent.TOUCH_MOVE, TouchMoveStageHandle);
				sprite.stage.addEventListener(TouchEvent.TOUCH_END, TouchEndStageHandle);
			}
			if (evt.touchPointID == firstTouch.ID) { 
				if (firstTouch.currentState == TouchPoint.OUT) { return; }
				firstTouch.currentState = TouchPoint.OUT;
				dispatchEvent(TouchableMaterial.firstTouchOut,evt); 
			}else
			if (evt.touchPointID == secondTouch.ID) {
				if (secondTouch.currentState == TouchPoint.OUT) { return; }
				secondTouch.currentState = TouchPoint.OUT;
				dispatchEvent(TouchableMaterial.secondTouchOut,evt);
			}
			else
			{	
				//if this event orcurr right after an TouchEnd (firstTouchEnd||secondTouchEnd||anotherTouchEnd) event then return
				dispatchEvent(TouchableMaterial.anotherTouchOut,evt);
			}
			if (updateAfterEvent) evt.updateAfterEvent();
		}
		/*Touch Point moved in*/
		private function TouchOverHandle(evt:TouchEvent):void {
			dispatchEvent(TouchableMaterial.TouchIn,evt);
			if (evt.touchPointID == firstTouch.ID) { 
				if (firstTouch.currentState == TouchPoint.IN) { return; }
				firstTouch.currentState = TouchPoint.IN;
				dispatchEvent(TouchableMaterial.firstTouchIn,evt); 
			}else
			if (evt.touchPointID == secondTouch.ID) {
				if (secondTouch.currentState == TouchPoint.IN) { return; }
				secondTouch.currentState = TouchPoint.IN;
				dispatchEvent(TouchableMaterial.secondTouchIn,evt);
			}else
			{
				dispatchEvent(TouchableMaterial.anotherTouchIn,evt);
			}
			//remove event listener if both touch Point are IN or !available
			if ((!firstTouch.ID||firstTouch.currentState == TouchPoint.IN) && (!secondTouch.ID||secondTouch.currentState == TouchPoint.IN)) {
				sprite.stage.removeEventListener(TouchEvent.TOUCH_MOVE, TouchMoveStageHandle);
				sprite.stage.removeEventListener(TouchEvent.TOUCH_END, TouchEndStageHandle);
			}
			if (updateAfterEvent) evt.updateAfterEvent();
		}
		
		
		
		
		private function TouchMoveStageHandle(evt:TouchEvent):void { trace("aaa");
			//current stage location of TouchPoint
			var currentTouch:Vector2D = new Vector2D(evt.stageX, evt.stageY);
				
			if (evt.touchPointID == firstTouch.ID) {				
				//check for true touchMove
				var firstTouchDiff:Vector2D = currentTouch.minus(firstTouch.currentStage);
				if (firstTouchDiff.length < minTouchMoveRange || firstTouch.currentState==TouchPoint.IN) {
					return;
				}
				//update first touch location
				firstTouch.update(evt);
				dispatchEvent(TouchableMaterial.firstTouchMoveStage,evt);
				//extended features
				//firstTOuchdrag
				if (stageDrag&&(dragMode == 1 || (dragMode == 2 && secondTouch.ID ))) {
					p.splus(firstTouchDiff);
				}
				//stage Scale and Rotate
				if (stageScaleAndRotate && freeScaleAndRotateMode && secondTouch.ID) {
					freeScaleAndRotateByfirstTouch(firstTouchDiff);
				}
			}else
			if (evt.touchPointID == secondTouch.ID) { 
				//check for true touchMove
				var secondTouchDiff:Vector2D = currentTouch.minus(secondTouch.currentStage);
				if (secondTouchDiff.length < minTouchMoveRange || secondTouch.currentState==TouchPoint.IN) {
					return;
				}
				//update touchPoint2
				secondTouch.update(evt);
				dispatchEvent(TouchableMaterial.secondTouchMoveStage,evt);	
				//extended features
				//stage Scale and Rotate
				if (stageScaleAndRotate && freeScaleAndRotateMode) {
					freeScaleAndRotateBysecondTouch(secondTouchDiff);
				}
				
			}
			if (updateAfterEvent) evt.updateAfterEvent();
		}
		private function TouchEndStageHandle(evt:TouchEvent):void {
			if (evt.touchPointID == firstTouch.ID) { 	
				firstTouch.end(evt);
				firstTouch.endState = TouchPoint.OUT;
				firstTouch.endLocal.input(Infinity, Infinity);
				dispatchEvent(TouchableMaterial.firstTouchEndStage,evt);
				if (!secondTouch.ID) {
					dispatchEvent(TouchableMaterial.TouchEndStage,evt);
				}
			}
			if (evt.touchPointID == secondTouch.ID) { 
				secondTouch.end(evt);
				secondTouch.endState = TouchPoint.OUT;
				secondTouch.endLocal.input(Infinity, Infinity);
				dispatchEvent(TouchableMaterial.secondTouchEndStage,evt);
				if (!firstTouch.ID) {
					dispatchEvent(TouchableMaterial.TouchEndStage,evt);
				}
			}
			// remove all event listener if both touch are !available
			if (!firstTouch.ID && !secondTouch.ID) {
				sprite.removeEventListener(TouchEvent.TOUCH_MOVE, TouchMoveHandle);
					
				sprite.stage.removeEventListener(TouchEvent.TOUCH_MOVE, TouchMoveStageHandle);
				sprite.stage.removeEventListener(TouchEvent.TOUCH_END, TouchEndStageHandle);
			}
			if (updateAfterEvent) evt.updateAfterEvent();
		}
		
		private function ShowTouchPoint(evt:TouchEvent):void {
			if (evt.touchPointID == firstTouch.ID) { firstTouch.update(evt); trace("FirstPoint " + firstTouch);}
			if (evt.touchPointID == secondTouch.ID) { secondTouch.update(evt); trace("SecondPoint " + secondTouch); }
		}
		private function EndShow(evt:TouchEvent):void {
			if (evt.touchPointID == firstTouch.ID) { firstTouch.end(evt); trace("FirstPointEnd " + firstTouch.endState);}
			if (evt.touchPointID == secondTouch.ID) { secondTouch.end(evt); trace("SecondPointEnd " + secondTouch.endState); }
		}
		/*dispatch TouchableMaterial Event*/
		private function dispatchEvent(event:String,evt:TouchEvent):void {
			var touchEvt:TouchableMaterialEvent ;
			touchEvt = new TouchableMaterialEvent(event, firstTouch, secondTouch, evt);
			sprite.dispatchEvent(touchEvt);
			//trace(touchEvt.type+"|ID="+touchEvt.touchPointID);
		}
		
		////////////////////////////////TouchableMaterial Events/////////////////////////
		
		/*occur when object recognized firstTouch while no touch available*/
		public static var TouchBegin:String = "TouchBegin";
		/*occur when object recognized firstTouch */
		public static var firstTouchBegin:String = "firstTouchBegin";
		/*occur when object recognizes firstTouch while secondTouch is still available*/
		public static var firstTouchBeginLate:String = "firstTouchBeginLate";
		/*occur when object recognized secondTouch */
		public static var secondTouchBegin:String = "secondTouchBegin";
		/*occur when object senced a Touch while firstTouch and secondTouch are still available*/
		public static var anotherTouchBegin:String = "anotherTouchBegin";
		
		/*occur when object's firstTouch moves over object*/
		public static var firstTouchMove:String = "firstTouchMove";
		/*occur when object's secondTouch moves over object*/
		public static var secondTouchMove:String = "secondTouchMove";
		/*occur when anotherTouch moves over object*/
		public static var anotherTouchMove:String = "anotherTouchMove";
		
		/*occur when bothTouch of object are ended and last Touch is ended over object */
		public static var TouchEnd:String = "TouchEnd";
		/*occur when object's firstTouch is ended over object*/
		public static var firstTouchEnd:String = "firstTouchEnd";
		/*occur when object's secondTouch is ended over object*/
		public static var secondTouchEnd:String = "secondTouchEnd";
		/*occur when anotherTouch is ended over object*/
		public static var anotherTouchEnd:String = "anotherTouchEnd";
		
		/*occur when firstTouch moves outside object*/
		public static var firstTouchMoveStage:String = "firstTouchMoveStage";
		/*occur when secondTouch moves outside object*/
		public static var secondTouchMoveStage:String = "secondTouchMoveStage";
		
		/*occur when bothTouch of object are ended and last Touch is ended outside object */
		public static var TouchEndStage:String = "TouchEndStage";
		/*occur when object's firstTouch is ended outside object*/
		public static var firstTouchEndStage:String = "firstTouchEndStage";
		/*occur when object's secondTouch is ended outside object*/
		public static var secondTouchEndStage:String = "secondTouchEndStage";
		
		/*occur when a Touch moved out of object (= ROLL_OUT event)*/
		public static var TouchOut:String = "TouchOut";
		/*occur when firstTouch moved out of object*/
		public static var firstTouchOut:String = "firstTouchOut";
		/*occur when secondTouch moved out of object*/
		public static var secondTouchOut:String = "secondTouchOut";
		/*occur when anotherTouch moved out of object*/
		public static var anotherTouchOut:String = "anotherTouchOut";
		
		/*occur when a Touch moved in object (= ROLL_OVER event)*/
		public static var TouchIn:String = "TouchIn";
		/*occur when firstTouch moved in object*/
		public static var firstTouchIn:String = "firstTouchIn";
		/*occur when secondTouch moved in object*/
		public static var secondTouchIn:String = "secondTouchIn";
		/*occur when anotherTouch moved in object*/
		public static var anotherTouchIn:String = "anotherTouchIn";
		
		////combo events
		public static const singleTap:String = "singleTap";
		public static const singleTwinTap:String = "singleTwinTap";
	}

}