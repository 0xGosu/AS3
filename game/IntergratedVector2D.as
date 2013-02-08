package game 
{
	import mathematic.Vector2D;
	
	/**
	 * Vector2D intergrated with an object that has x,y properties 
	 * @author HD.TVA
	 */
	public class IntergratedVector2D extends Vector2D 
	{
		/*Create a intergrated vector with the propeties .x ,.y of object (values will be shifted by vector shiftPoint)*/
		public function IntergratedVector2D(IntergrateObject:Object,shiftPoint:Vector2D=null) 
		{
			if (IntergrateObject.hasOwnProperty("x") && IntergrateObject.hasOwnProperty("y")) {
				object = IntergrateObject;
				if (shiftPoint == null) shiftP = new Vector2D;
				else shiftP = shiftPoint;
				super(object.x,object.y)
			}else {
				throw ("Unaceppted object")
			}	
		}
		/*object*/
		private var object:Object;
		/*shift point vector from true possition of object
		 * default= (0;0) */
		public var shiftP:Vector2D;
		/*change object*/
		public function changeIntergratedObject(IntergrateObject:Object,shiftPoint:Vector2D=null):void {
			if (IntergrateObject.hasOwnProperty("x") && IntergrateObject.hasOwnProperty("y")) {
				object = IntergrateObject;
				if (shiftPoint == null) shiftP = new Vector2D;
				else shiftP = shiftPoint;
			}else {
				throw ("Unaceppted object")
			}	
		}
		override public function get x():Number {
			return object.x+shiftP.x;
		}
		override public function set x(val:Number):void {
			object.x = val-shiftP.x;
		}
		override public function get y():Number {
			return object.y+shiftP.y;
		}
		override public function set y(val:Number):void {
			object.y = val-shiftP.y;
		}
		
	}

}