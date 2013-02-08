package game 
{
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class MousePlusableMaterial 
	{
		
		public function MousePlusableMaterial() 
		{
			
		}
				
		private function MouseDownHandle(evt:MouseEvent):void {
			if (evt.ctrlKey) {
			// rotation by ctrl + mouse move
			var localMouse:Vector2D = new Vector2D(evt.localX, evt.localY);
			localMouse.sminus(originalCenterPoint);
			
			lastAngle = localMouse.angle;
			
			sprite.stage.addEventListener(MouseEvent.MOUSE_UP, MouseUpHandleWhileRotate);
			sprite.addEventListener(MouseEvent.MOUSE_MOVE , MouseMoveHandleWhileRotate);
			
			}else{
			sprite.startDrag();
			speedC = new speedCatcher(sprite); 
			
			sprite.dispatchEvent(new CatchEvent(FlexMaterial.eventMouseCatch));
			
			sprite.stage.addEventListener(MouseEvent.MOUSE_UP, MouseUpHandleWhileDrag);
			sprite.stage.addEventListener(MouseEvent.MOUSE_MOVE , MouseMoveHandleWhileDrag);
			}
		}
		private function MouseUpHandleWhileDrag(evt:MouseEvent):void  {
			sprite.stopDrag(); 
			
			var V:Vector2D = speedC.curSpeed.multi(xspeed);
			if (V.length > speedHandicap) V = Vector2D.createFromAgl(speedHandicap, V.angle);
			speedC.deactivate();
				
			sprite.dispatchEvent(new ThrowEvent(FlexMaterial.eventMouseThrow, V));
			
			sprite.stage.removeEventListener(MouseEvent.MOUSE_UP, MouseUpHandleWhileDrag);
			sprite.stage.removeEventListener(MouseEvent.MOUSE_MOVE, MouseMoveHandleWhileDrag);
		}
		private function MouseMoveHandleWhileDrag(evt:MouseEvent):void {
			firstTouchPoint = 0;
			secondTouchPoint = 0;
			//trace(speedC.speed);
			//trace(sprite.mouseX + " " + sprite.mouseY);
			if (sprite.mouseX*sprite.scaleX < -outDrag || sprite.mouseX*sprite.scaleX > sprite.width + outDrag || sprite.mouseY*sprite.scaleY < -outDrag || sprite.mouseY*sprite.scaleY > sprite.height + outDrag) {
				
				sprite.stopDrag();
				speedC.deactivate();
				
				sprite.dispatchEvent(new DropEvent(FlexMaterial.eventMouseDrop));
				
				sprite.stage.removeEventListener(MouseEvent.MOUSE_UP, MouseUpHandleWhileDrag);
				sprite.stage.removeEventListener(MouseEvent.MOUSE_MOVE, MouseMoveHandleWhileDrag);
			}

		}
		private function MouseUpHandleWhileRotate(evt:MouseEvent):void {
			sprite.stage.removeEventListener(MouseEvent.MOUSE_UP, MouseUpHandleWhileRotate);
			sprite.removeEventListener(MouseEvent.MOUSE_MOVE , MouseMoveHandleWhileRotate);
		}
		private var lastAngle:Number;
		
		private function MouseMoveHandleWhileRotate(evt:MouseEvent):void {
			var localMouse:Vector2D = new Vector2D(evt.localX, evt.localY);
			localMouse.sminus(originalCenterPoint);
			rotateTo(sprite.rotation+math.deg(localMouse.angle-lastAngle));
			//lastAngle = localMouse.angle;
		}
				/*optimize how fast of wheel rotate*/
		public var wheelRotation:Number = 5;
		//Scale handle
		private function MouseWheelHandle(evt:MouseEvent):void  {
			if (evt.ctrlKey) {
				currentScale += xscale*evt.delta*currentScale;
				if (evt.delta > 0 && (sprite.width > maxWidthHeight || sprite.height > maxWidthHeight)) return;
				if (evt.delta < 0 && (sprite.width < minWidthHeight || sprite.height < minWidthHeight)) return;
				
				
				scaleTo(currentScale);
				
				
			}
			if (evt.shiftKey) {
				
				rotateTo(sprite.rotation+evt.delta*wheelRotation);
			}
		}
	}

}