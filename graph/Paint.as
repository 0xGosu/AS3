package graph
{
	import flash.display.Graphics;
	/**
	 * Short painting class
	 * @author HD.TVA
	 */
	public final class Paint
	{
		public function Paint()
		{
		}
		/*Draw line to the Graph gr folow those points in the array*/
		public static function drawLine(gr:Graphics,arp:Array,lineTh:Number=1,lineCl:uint=0):void{
			gr.lineStyle(lineTh,lineCl);
			gr.moveTo(arp[0].x,arp[0].y);
			for(var i:int=1;i<arp.length;i++)gr.lineTo(arp[i].x,arp[i].y);
			
		}
		/**
		 * Draw and pain a circle to the Graph gr
		 */
		public static function circle(gr:Graphics,px:Number=0,py:Number=0,radius:Number=20,lineTh:Number=1,lineCl:uint=0,fill:Boolean=false,fillCl:uint=0):void{
			gr.lineStyle(lineTh,lineCl);
			if(fill)gr.beginFill(fillCl);
			gr.drawCircle(px,py,radius);
			if(fill)gr.endFill();
		}
		/**
		 * Draw and paint a round rectangle to the Graph gr
		 * 
		 */
		public static function roundRect(gr:Graphics,px:Number=0,py:Number=0,width:uint=20,height:uint=20,lineTh:Number=1,lineCl:uint=0,fill:Boolean=false,fillCl:uint=0):void{
			gr.lineStyle(lineTh,lineCl);
			if(fill)gr.beginFill(fillCl);
			gr.drawRoundRect(px,py,width,height,width/8,height/8);
			if(fill)gr.endFill();
		}
		/*Draw and paint a normal rectangle*/
		public static function rect(gr:Graphics,px:Number=0,py:Number=0,width:uint=20,height:uint=20,lineTh:Number=1,lineCl:uint=0,fill:Boolean=false,fillCl:uint=0):void{
			gr.lineStyle(lineTh,lineCl);
			if(fill)gr.beginFill(fillCl);
			gr.drawRect(px,py,width,height);
			if(fill)gr.endFill();
		}
	}
}