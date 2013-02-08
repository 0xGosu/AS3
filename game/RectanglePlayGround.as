package game 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import game.events.Colision;
	import graph.Paint;
	import mathematic.Vector2D;
	import game.interfaces.PhysicProperties;
	
	/**
	 * A platform for Material with bound back effect at bolder. 
	 * @author HD.TVA
	 */
	public class RectanglePlayGround
	{
		
		public function RectanglePlayGround(width:Number=300,height:Number=300,x:Number=0,y:Number=0,sp:Sprite=null,container:DisplayObjectContainer=null,interactList:Array=null) 
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
		
		/*Time line property
		Controll objects in the list*/
		public function step(evt:Event):void{
			for each (var obj:* in list) inter(obj);
		}
		/*Interaction of ... 
		You should override this function to create a new interactivity for inherited class but besure that the custom function should have only 1 param
		Note: There are few basic method for Interaction that u may wannna use and remember to check the object is not itself? and available?*/
		protected function inter(obj:*):void {
			basicInteraction(obj);
		}
		
		public function createBasicVisual():void {
			sprite.graphics.clear();
			Paint.rect(sprite.graphics, 0, 0, w, h, 2,0,true,20000);
		}

		// own properties and methods
		/*rect'width*/
		public var w:Number;
		/*rect'height*/
		public var h:Number;
		/*public var p:Vector2D intergrated with sprite's possition
		 * Note that you can not point it to another vector*/
		private var _p:IntergratedVector2D;
		public function get p():Vector2D {
			return _p;
		}
		public function set p(val:Vector2D):void {
			_p.copy(val);
		}
		
		public function basicInteraction(obj:*):void {
			var ob:PhysicProperties= obj as PhysicProperties;
			if (ob.p.x < 0) 			{ ob.p = new Vector2D(0, ob.p.y); ob.v.input(Math.abs(ob.v.x), ob.v.y);  }
			if (ob.p.x > this.w) 	{ ob.p = new Vector2D(this.w,ob.p.y); ob.v.input(-Math.abs(ob.v.x), ob.v.y); }
			if (ob.p.y < 0) 			{ ob.p = new Vector2D(ob.p.x, 0); ob.v.input(ob.v.x,Math.abs(ob.v.y)); }
			if (ob.p.y > this.h) 	{ ob.p = new Vector2D(ob.p.x,this.h); ob.v.input(ob.v.x,-Math.abs(ob.v.y)); }
		}
		
	}

}