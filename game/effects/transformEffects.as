package game.effects 
{
	import flash.display.DisplayObject;
	import game.IntergratedVector2D;
	import mathematic.math;
	import mathematic.Vector2D;
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class transformEffects 
	{
		
		public function transformEffects() 
		{
			
		}
		public static function scale(object:DisplayObject,x:Number = 1, y:Number = 0,LocalPoint:Vector2D =null):void  {
			if (x) {
				if (!y) y = x;
				if (LocalPoint == null) { 
					object.scaleX *= x; object.scaleY *= y;
					return;
				}else {
					var localPoint:Vector2D = LocalPoint.clone();
					localPoint.selfScalar(object.scaleX, object.scaleY);
					localPoint.sturn(math.rad(object.rotation));
				}
				
				
				var p:IntergratedVector2D = new IntergratedVector2D(object);
				
				// change scale
				object.scaleX *= x; object.scaleY*=y;
				
				
				
				// calculate new point
				var newPoint:Vector2D = localPoint.scalar(x, y);
				// shift object to the possition 
				p.sminus(newPoint.minus(localPoint));
				
			}
		}
		public static function scaleTo(object:DisplayObject, x:Number = 1, y:Number = 0, localPoint:Vector2D = null):void  {
			scale(object, x / object.scaleX, y / object.scaleY,localPoint);
		}
		public static function rotate(object:DisplayObject,alpha:Number,LocalPoint:Vector2D =null):void {
			if (LocalPoint == null) { 
				object.rotation += math.deg(alpha);	
				return;
			}else {
					var localPoint:Vector2D = LocalPoint.clone();
					localPoint.selfScalar(object.scaleX, object.scaleY);
					localPoint.sturn(math.rad(object.rotation));
			}
			
			var p:IntergratedVector2D = new IntergratedVector2D(object);
			
			//change value
			
			object.rotation += math.deg(alpha);
			// calculate new point
			var newPoint:Vector2D = localPoint.turn(alpha);
			//shift object to the possiontion
			p.sminus(newPoint.minus(localPoint));	
		}
		public static function rotateTo(object:DisplayObject, alpha:Number, localPoint:Vector2D = null):void {
			rotate(object, alpha - math.rad(object.rotation), localPoint);
		}
/*		return a vector that store original width in .x and height in .y*/ 
		public static function getOriginalWidthHeight(object:DisplayObject):Vector2D {
			if (object.name == null) return new Vector2D(object.width, object.height);
			var curRotation:Number = object.rotation;
			var curScaleX:Number = object.scaleX;
			var curScaleY:Number = object.scaleY;
			object.rotation = 0;
			object.scaleX = 1;
			object.scaleY = 1;
			var V:Vector2D = new Vector2D(object.width, object.height);
			object.rotation = curRotation;
			object.scaleX = curScaleX;
			object.scaleY = curScaleY;
			return V;
		}
	}

}