package game.object
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import graph.Paint;

	public class cell
	{
		public function cell(pid:String,pcontainer:DisplayObjectContainer,sp:Sprite=null,psize:Number=20,color:uint=0)
		{
			id=pid;
			size=psize;
			container=pcontainer;
			if(sp)sprite=sp;
			else {sprite=new Sprite;createBasicVisual(size,2,0,true,color);}
			container.addChild(sprite);
		}
		public var id:String;
		public function toString():String{
			return "Cell "+id+" at ("+px+","+py+")";
		}
		// possition x
		public function get px():Number{
			return sprite.x;
		}
		public function set px(vl:Number):void{
			sprite.x=vl;
		}
		// possition y
		public function get py():Number{
			return sprite.y;
		}
		public function set py(vl:Number):void{
			sprite.y=vl;
		}
		public var size:Number;
		//visual
		public var container:DisplayObjectContainer;
		public var sprite:Sprite;
		public function createBasicVisual(wh:Number=20,line:Number=1,lineCl:uint=0,fill:Boolean=false,fillCl:uint=0):void{
			sprite.graphics.clear();
			Paint.roundRect(sprite.graphics,0,0,wh,wh,line,lineCl,fill,fillCl);
		}
		public var available:Boolean=true;
		public function selfRemove():void{
			if(available)container.removeChild(sprite);
			available=false;
		}
	}
}