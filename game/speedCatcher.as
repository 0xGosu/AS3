package game 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mathematic.Vector2D;
	/**
	 * Catch speed of an display object
	 * @author HD.TVA
	 */
	public class speedCatcher 
	{
		
		public function speedCatcher(object:DisplayObject)
		{
			obj = object;
			activate();
		}
		/*delta time per frame (step)*/
		public var dt:Number
		/*object */
		public var obj:DisplayObject
		/*current speed*/
		public var curSpeed:Vector2D = new Vector2D(0, 0);
		/*previous possition*/
		private var preP:Vector2D
		/*length*/
		private var length:Number = 0;
		private var time:Number = 0;
		/*how far the object get from start possition (not distance)*/
		public function get totalLength():Number {
			return length;
		}
		/*how much time has passed from start*/
		public function get totalTime():Number {
			return time;
		}
		/*vector average speed by current angle*/
		public function get averageSpeed():Vector2D {
			return Vector2D.createFromAgl(length / time, curSpeed.angle);
		}
		/*array store velocity in last frames*/
		private var arrV:Array = new Array();
		/*average speed of last frames*/
		public function get lastSpeed():Vector2D {
			var tLength:Number = 0;
			var tV:Vector2D = new Vector2D();
			for each (var Vat:Vector2D in arrV) 
			{
				tLength += Vat.length;
				tV.splus(Vat);
			}
			return Vector2D.createFromAgl(tLength/arrV.length, tV.angle);
		}
		/*how many frames count for lastSpeed()*/
		public var lastCount:Number = 10;
		/*Check speed by compare its possition every frame*/
		private function checkSpeed(evt:Event):void {
			var curP:Vector2D = new Vector2D(obj.x, obj.y);
			var dP:Vector2D = curP.minus(preP);
			curSpeed.copy(dP.div(dt));
			arrV.unshift(curSpeed.clone());
			if (arrV.length > lastCount) arrV.pop();
			length += dP.length;
			time += dt;
			preP.copy(curP);
		}
		/*make this thing become active*/
		public function activate():void {
			dt = 1 / obj.stage.frameRate;
			obj.addEventListener(Event.ENTER_FRAME, checkSpeed);
			preP= new Vector2D(obj.x, obj.y);
		}
		/*opposite with activate()*/
		public function deactivate():void {
			obj.removeEventListener(Event.ENTER_FRAME, checkSpeed);
		}
	}

}