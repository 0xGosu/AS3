package game 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import graph.Paint;
	import mathematic.Vector2D;
	import game.IntergratedVector2D;
	
	import game.interfaces.PhysicProperties;
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class RectangleMaterial implements PhysicProperties
	{
		
		public function RectangleMaterial(width:Number=300,height:Number=300,x:Number=0,y:Number=0,sp:Sprite=null,container:DisplayObjectContainer=null,interactList:Array=null) 
		{
			w = width; h = height;
			
			if (sp == null) { sprite = new Sprite(); createBasicVisual(); }
			else sprite = sp;
			_p = new IntergratedVector2D(sprite);
			
			if (container != null) { container.addChild(sprite); activate(); }
			if ( interactList == null) list = new Array();
			else { list = interactList; }
			
			p.input(x, y);
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
		
		
		/*GUI*/
		public var sprite:Sprite;
		/*List of object under control*/
		public var list:Array;
		
		/*
		Controll objects in the list*/
		public function step(evt:Event):void{
			action(); 
			//for each (var obj:* in list) inter(obj);
		}
		
		/*Action of ...
		You should override this function to create a new activity for inherited class but besure that the custom function should have no param
		Note: There is a basic method for Action that u may wannna use*/
		protected function action():void {
			basicAction();
		}
		/*Interaction of ... 
		You should override this function to create a new interactivity for inherited class but besure that the custom function should have only 1 param
		Note: There are few basic method for Interaction that u may wannna use and remember to check the object is not itself? and available?*/
		protected function inter(ob:*):void {
			if(ob!==this&&ob.available){//you may wanna change this condition or remove it!
			
				//code here
			
			}
		}
		public function basicAction():void {
			p.splus(v.multi(dt));
		}
		public function basicInteraction():void {
			
		}
		
		
		
		/*mass*/
		public function get m():Number {
			return _m;
		}
		public function set m(val:Number):void {
			_m = Math.abs(val);
		}
		private var _m:Number;
		
		/*Vector p intergrated with sprite's possition
		 * Note that you can not point it to another vector*/
		public function get p():Vector2D {
			return _p;
		}
		public function set p(val:Vector2D):void {
			_p.copy(val);
		}
		private var _p:IntergratedVector2D;
		
		/*vetor velocity*/
		public function get v():Vector2D {
			return _v;
		}
		public function set v(val:Vector2D):void {
			_v = val;
		}
		private var _v:Vector2D = new Vector2D(0, 0);
		
		/*sprite rotation in radian*/
		public function get angle():Number  {
			return sprite.rotation/180*Math.PI;
		}
		public function set angle(val:Number ):void {
			sprite.rotation = val/Math.PI*180;
		}
		/*Angular velocity*/
		public function get spin():Number  {
			return _spin;
		}
		public function set spin(val:Number ):void {
			_spin = val;
		}
		private var _spin:Number=0;
		
		/*delta t per step (time's scale) */
		public function get dt():Number  {
			return _dt;
		}
		public function set dt(val:Number ):void {
			_dt = val;
		}
		private var _dt:Number=1;
		
		/*Friction*/
		public function get fric():Number  {
			return _fric;
		}
		public function set fric(val:Number ):void {
			_fric = val;
		}
		private var _fric:Number=0 ;	
		
		//Own properties
		public var w:Number ;
		public var h:Number ;
		
		// Visual
		
		public function createBasicVisual():void {
			sprite.graphics.clear();
			//code here
			Paint.rect(sprite.graphics, 0, 0, w, h, 1,0,true,0);
		}
	
	}

}