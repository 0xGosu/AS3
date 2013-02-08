package game.object
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import graph.Paint;
	
	import mathematic.math;

	/**
	 * Broad  
	 * @author TVA
	 * 
	 */
	public dynamic class board extends Array
	{
		public function board(w:uint=8,h:uint=8,csize:Number=20,pcontainer:DisplayObjectContainer=null,sp:Sprite=null)
		{
			super();
			container=pcontainer;
			width=w;height=h;
			cellSize=csize;
			if(sp)sprite=sp;else
			{sprite=new Sprite();createBasicVisual(csize/10)}
			container.addChild(sprite);
			
			for(var i:int=0;i<h;i++){
				var ar:Array=new Array();
				this.push(ar);
			}
		}
		// Main info
		public var width:uint;
		public var height:uint;
		//
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
		// Visual Info
		public var container:DisplayObjectContainer;
		public var sprite:Sprite;
		public var cellSize:Number=20;
		
		public function clearBoard():void{
			for(var i:int=0;i<height;i++)
				for(var j:int=0;j<width;j++){
					if(!this[i][j])continue;
					if(this[i][j].hasOwnProperty('selfRemove'))this[i][j].selfRemove();
				}
		}
		public function createBoardNull():void{
			clearBoard();
			for(var i:int=0;i<height;i++)
			for(var j:int=0;j<width;j++){
				var nc:cell=new cell('null',sprite);
				nc.createBasicVisual(cellSize,1,1000);
				nc.px=cellSize*j;
				nc.py=cellSize*i;
				this[i][j]=nc;
			}
			refreshBoard();
		}
		public function refreshBoard():void{
			for(var i:int=0;i<height;i++)
				for(var j:int=0;j<width;j++){
					if(!this[i][j])continue;
					if(this[i][j].hasOwnProperty("available")&&this[i][j].available){
					if(this[i][j].hasOwnProperty('px'))this[i][j].px=cellSize*j;
					if(this[i][j].hasOwnProperty('py'))this[i][j].py=cellSize*i;
					}
				}
		}
		public function createBasicVisual(line:Number=4,lineCl:uint=0,fill:Boolean=true,fillCl:uint=0xffffff):void{
			sprite.graphics.clear();
			Paint.rect(sprite.graphics,0,0,width*cellSize,height*cellSize,line,lineCl,fill,fillCl);
		}
		
	}
}