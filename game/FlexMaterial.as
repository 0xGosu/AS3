package game 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import game.events.CatchEvent;
	import game.events.DropEvent;
	import game.events.ResizeEvent;
	import game.events.ThrowEvent;
	import game.interfaces.PhysicProperties;
	import mathematic.math;
	import mathematic.Vector2D;
	import flash.events.TouchEvent;
	/**
	 * Flex Material container that allow the object to be draged, scaled, rotated by mouse and touch
	 * @author HD.TVA
	 */
	public class FlexMaterial 
	{
		/*Generate Flexmaterial object for sprite sp 
		 * Vector centerpoint is use for scaleTo*/
		public function FlexMaterial(sp:InteractiveObject, CenterPoint:Vector2D = null,PhysicMaterial:PhysicProperties = null ) 
		{
			if (sp === null) throw("Flex Material dont accept null Sprite as its object!");
			else {
				sprite = sp;
				p = new IntergratedVector2D(sprite);
				//
				
				sp.scaleX = 1; sp.scaleY = 1; sp.rotation = 0;
				//
				if (CenterPoint == null) originalCenterPoint.input(sp.width / 2, sp.height / 2);
				else originalCenterPoint=CenterPoint.clone();
				if(PhysicMaterial != null){
					PhysicEffect = true;
					physicMaterial = PhysicMaterial;
				}
				//save original value
				originalHeight = sprite.height;
				originalWidth = sprite.width;
				
				// addEventCatcher
				sprite.addEventListener(MouseEvent.MOUSE_DOWN, MouseDownHandle);
				sprite.addEventListener(MouseEvent.MOUSE_WHEEL, MouseWheelHandle);
				sprite.addEventListener(TouchEvent.TOUCH_BEGIN, TouchBeginHandle);
			}
		}
		/*Object work with
		 * Do not change this value*/
		public var physicEffect:Boolean = false;
		private var physicMaterial:PhysicProperties;
		private var sprite:InteractiveObject ;
		private var originalWidth:Number ;
		private var originalHeight:Number ;
		/*vector intergrated with sprite's possition*/
		private var p:IntergratedVector2D;
		/*Current Point for function scale() and rotate*/
		private var currentPoint:Vector2D = new Vector2D;
		public function toTrue(localX:Number,localY:Number ):void {
			var truePoint:Vector2D = new Vector2D (localX * sprite.scaleX, localY * sprite.scaleY);
			truePoint.sturn(math.rad(sprite.rotation));
			return truePoint;
		}
		/*Original Center Point
		Do not change this value*/
		private var originalCenterPoint:Vector2D=new Vector2D;
		private var _centerPoint:Vector2D = new Vector2D;
		public function get centerPoint():Vector2D {
			_centerPoint.input(originalCenterPoint.x * sprite.scaleX, originalCenterPoint.y * sprite.scaleY);
			_centerPoint.sturn(math.rad(sprite.rotation));
			return _centerPoint;
		}
		// Event handling
		//Drag and throw
		/*Maximum throw speed*/
		public var speedHandicap:Number = 800;
		/*speed catcher*/
		private var speedC:speedCatcher;
		/*increas or decreas this value to optimize the force of hand or mouse*/
		public var xspeed:Number = 1;
		/*if mouse or touch point is out of object more than this value, drag effect will stop*/
		public var outDrag:Number = 20;
		/*Handle Mouse*/
		
		//Scale
		/*Current scale use for mouse scale*/
		public var currentScale:Number = 1;
		/*increas or decreas this value to optimize how fast of mouse scale*/
		public var xscale:Number = 0.1;
		/*minimum value for width and height of object
		 * either one of these 2 value below this value will stop scale*/
		public var minWidthHeight:Number = 40;
		/*maximum value for width and height of object
		 * either one of these 2 value above this value will stop scale*/
		public var maxWidthHeight:Number = 600;
		/*increas or decreas this value to optimize how fast of touch scale*/
		public var Xscale:Number = 1;
		/*Avoid all touch scale that has range < this value px */

		
	}

}