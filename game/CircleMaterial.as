package game
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import game.events.Colision;
	import game.interfaces.PhysicProperties;
	import mathematic.solver.checkIntersection2Circle;
	
	import graph.Paint;
	
	import mathematic.Vector2D;
	import mathematic.math;
	import mathematic.solver.checkColid2Circle;
	import mathematic.solver.solveHardColid2D;

	/**
	 * A circle form container object for display object to simulate physic'properties.
	 * This class only contain 1 display object type Sprite in the property sprite
	 * Note that all the physic'properties are built in. So you can directly add to your project without writing any more code suchas addevent...
	 * To setup a system of these CircleMaterial that can interact(colision) eachother make a Array of all CircleMaterial object and assign it to propety list of every of them.
	 * Use Example: 
	 * var ball:CircleMaterial new CircleMaterial(circleradius,circlemass,ballImage,container);
	 * with ballImage is a sprite that display a ball, and container is where it will be added. (without sprite, CircleMaterial will generate a visual basic circle sprite itself.)
	 * You can define CircleMaterial object by yourself via properties and method.
	 * @author HD.TVA
	 */
	
	public class CircleMaterial implements PhysicProperties
	{
		public function CircleMaterial(size:Number = 10, mass:Number = 10, object:DisplayObject = null, container:DisplayObjectContainer = null, interactList:Array = null, CenterPoint:Vector2D=null, basicColidHandle:Boolean = true)
		{
			radius = Math.abs(size);
			originalRadius = r;
			m=mass;
			if (object == null) { sprite = new Sprite(); createBasicVisual(); }
			else sprite = object;
			
			if (CenterPoint == null) originalCenterPoint.input(sprite.width/2,sprite.height/2);
			else originalCenterPoint.copy(CenterPoint);
			centerPoint.copy(originalCenterPoint);
			_p = new IntergratedVector2D(sprite, centerPoint);
			if (container != null) { container.addChild(sprite); activate(); }
			if ( interactList == null) list = new Array();
			else { list = interactList; list.push(this); }
			if (basicColidHandle) {
				sprite.addEventListener(CircleMaterial.eventColid, basicColisionHandle);
				sprite.addEventListener(CircleMaterial.eventFastColid, basicColisionHandle);
			}
		}
		/*you should use this function instead of addChild()*/
		public function attachTo(container:DisplayObjectContainer):void {
			container.addChild(sprite); 
			activate();
		}
		
		/*make the circle become active*/
		public function activate():void {
			dt = 1 / sprite.stage.frameRate;
			available = true;
			sprite.addEventListener(Event.ENTER_FRAME, step);
		}
		/*opposite with activate()*/
		public function deactivate():void {
			available = false;
			sprite.removeEventListener(Event.ENTER_FRAME, step);
		}
		/*Available for interaction*/
		public var available:Boolean=true;
		/*List of interact objects*/
		public var list:Array;
		
		// moving object propeties
		private var originalCenterPoint:Vector2D = new Vector2D;
		/*center point*/
		private var _centerPoint:Vector2D = new Vector2D;
		public function get centerPoint():Vector2D { return _centerPoint; }
		/////////////////////////////////////////////// object properties /////////////////////////////////////////////
		/*object*/
		public var sprite:DisplayObject;
		//shortcut for Sprite
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void {
			sprite.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void {
			sprite.removeEventListener(type, listener, useCapture);
		}
		public function get rotation():Number {
			return sprite.rotation;
		}
		public function set rotation(val:Number):void {
			sprite.rotation = val;
		}
		public function get visible():Boolean {
			return sprite.visible;
		}
		public function set visible(val:Boolean):void {
			sprite.visible = val;
		}
		public function get name():String {
			return sprite.name;
		}
		public function set name(val:String):void {
			sprite.name = val;
		}
		
		///////////////////////////////// physic object propeties //////////////////////////////////
		/*mass*/
		public function get m():Number {return _m;}
		public function set m(val:Number):void {_m = Math.abs(val);}
		private var _m:Number;
		
		/*Vector p intergrated with sprite's possition + shift centerPoint
		 * Note that you can not point it to another vector*/
		public function get p():Vector2D {return _p;}
		public function set p(val:Vector2D):void {_p.copy(val);}
		private var _p:IntergratedVector2D;
		
		/*vetor velocity*/
		public function get v():Vector2D {return _v;}
		public function set v(val:Vector2D):void {_v = val;}
		private var _v:Vector2D = new Vector2D(0, 0);
		
		/*sprite rotation in radian*/
		public function get angle():Number  {return sprite.rotation/180*Math.PI;}
		public function set angle(val:Number ):void {sprite.rotation = val/Math.PI*180;}
		
		/*Angular velocity*/
		public function get spin():Number  {return _spin;}
		public function set spin(val:Number ):void {_spin = val;}
		private var _spin:Number=0;
		
		/*delta t per step (time's scale) */
		public function get dt():Number  {return _dt;}
		public function set dt(val:Number ):void {_dt = val;}
		private var _dt:Number=1;
		
		/*Friction*/
		public function get fric():Number  {return _fric;}
		public function set fric(val:Number ):void {_fric = val;}
		private var _fric:Number=0 ;	
		
		/////////// spects physic properties ///////////////////
		private var originalRadius:Number=0;
		/*Radius*/
		public function get r():Number {return radius;}
		public function set r(val:Number ):void { originalRadius = val / sprite.scaleX; }
		private var radius:Number=0;
		

		


		/* Step to next state in the time'current 
		 * By do action itself and interact with object in the list */
		public function step(evt:Event):void{
			action(); 
			for each (var obj:CircleMaterial in list) { 
				inter(obj);
			}
			colidObjects = new Array();
			
		}
		/*Action of Circle 
		You should override this function to create a new activity for inherited class but besure that the custom function should have no param
		Note: There is a basic method for Circle'Action that u may wannna use*/
		protected function action():void {
			basicAction();
		}
		/*Interaction of Circle 
		You should override this function to create a new activity for inherited class but besure that the custom function should have only one param type CircleMaterial or its inheritor (this Material is internal type interact)
		Note: There are few basic method for Circle'Interaction that u may wannna use and remember to check the object is not itself? and available?*/
		protected function inter(ob:CircleMaterial):void {
			if(ob!==this&&ob.available&&ob.sprite.parent===sprite.parent){
				//Check vice versa colid
				if (colidObjects.indexOf(ob) >= 0) return;
				colidObjects.push(ob);
				ob.colidObjects.push(this);
				
				basicInteraction(ob);
			}
		}
		
		/**
		 * Basic Action of Circle Material Object <p>
		 * Change possition by its velocity depend on the delta of time dt
		 */
		public function basicAction():void {
			p.splus(v.multi(dt));
			radius = originalRadius * sprite.scaleX;
			centerPoint.input(centerPoint.x * sprite.scaleX, centerPoint.y * sprite.scaleY);
			centerPoint.sturn(angle);
		}
		/*List of Circle Material Objects that has colided in current step*/
		internal var colidObjects:Array=new Array;
		/**
		 * Basic Interaction <p>
		 * Check colid and solve 
		 * @param ob Object to be interact
		 * 
		 */
		public function basicInteraction(ob:CircleMaterial):void{
				//check fast?
				if (this.v.square + ob.v.square > CircleMaterial.howisFast) var fastColid:Boolean = true; else fastColid = false; 
				// Check Intersection
				var checkIns:checkIntersection2Circle = new checkIntersection2Circle(this.p, this.r, ob.p, ob.r,true);
				if(checkIns.result){
					if (fastColid) sprite.dispatchEvent(new Colision(this,ob, CircleMaterial.eventFastColid));
					else 
					sprite.dispatchEvent(new Colision(this,ob, CircleMaterial.eventColid));
				}
				else if (fastColid) { // Check for true colid if this circle is moving too fast
					var check:checkColid2Circle=new checkColid2Circle(this.p,this.v,this.r,ob.p,ob.v,ob.r,-this.dt*0.95);//not check 5% of the last delta time to avoid bug
					if (check.root == 1) {sprite.dispatchEvent(new Colision(this,ob, CircleMaterial.eventFastColid));}
				}
				
			
		}
		/**
		 * Basic colid action.<p>
		 * Solve colision
		 */
		public function basicColidAction(ob:CircleMaterial):solveHardColid2D{
			var solve:solveHardColid2D=new solveHardColid2D(this.p,this.m,this.v,ob.p,ob.m,ob.v);
			v.splus(solve.pva);
			ob.v.splus(solve.pvb);
			return solve;
		}

		/* Correct object posstion first and then do basic colid action*/
		public function basicColidAction2(ob:CircleMaterial,fast:Boolean=false):solveHardColid2D{
				// check for the correct Colid posstion
					var check:checkColid2Circle=new checkColid2Circle(this.p,this.v,this.r,ob.p,ob.v,ob.r,-this.dt);
					// change possition 
					if(check.root==1){
						
						this.p=this.p.plus(this.v.multi(check.t));
						ob.p=ob.p.plus(ob.v.multi(check.t));
					}else {
						//intersect posstions (shift both the object to the right point that is at the middle of 2 center) 
						var dp:Vector2D=ob.p.minus(this.p);
						var sumR:Number = this.r + ob.r;
						var db:Vector2D=Vector2D.createFromAgl((sumR-dp.length)/2,dp.angle);
						ob.p=ob.p.plus(db);
						this.p=this.p.plus(db.turn(Math.PI));
					}
				// solve colid	
				return basicColidAction(ob);	
		}
				
		/**
		 * Create a basic Visual <p>
		 * A circle linethickness = 1
		 */
		public function createBasicVisual(lineCl:Number = 0, fill:Boolean = false, fillCl:Number = 0xffffff):void {
			if (!r) return;
			var sp:Sprite = sprite as Sprite;
			sp.graphics.clear();
			Paint.circle(sp.graphics,0+r,0+r,r-0.5,1,lineCl,fill,fillCl);
		}
		
		/*Square of the speed that u may concern about objects pass through eachother should be about 10^6->10^8 <=> speed about (3200->32000)*/
		public static var howisFast:Number = 1000000;
		/*Event colision*/
		public static var eventColid:String = "CircleMaterial";
		public static var eventFastColid:String = "CircleMaterial <fast>";
		
		/*Handle collision using basicColidAction2*/
		private function basicColisionHandle(evt:Colision):void {
			if(evt.subject===this && evt.object is CircleMaterial){
			if (evt.type == CircleMaterial.eventFastColid) fast = true;  else fast = false;
				basicColidAction2(CircleMaterial(evt.object), fast);
				var fast:Boolean;
			}
			//trace(evt.subject);
		}

		/*SUI */
		public function toString():String{
			return name+": "+m+"g "+r+"px P="+p+">>"+centerPoint+" V="+v;
		}
		
	}
}