package physic{
	import flash.display.*;
	import flash.utils.*;
	public class vector extends Sprite{
		private const pi:Number=Math.PI;
		public var px:Number;
		public var py:Number;
		public var time:Timer;
		public function vector(inp1:Number=0,inp2:Number=0){
			px=inp1;
			py=inp2;
			update();
		}
		public function multi(k:Number):void{
			px=k*px;
			py=k*py;
		}
		public function dot(v:vector):Number {
			return px * v.px + py * v.py;
		}
		public function cross(v:vector):Number {
			return px * v.py - py * v.px;
		}
		public function plus(v:vector):void{
			px+=v.px; 
			py+=v.py; 
		}
		public function minus(v:vector):void{
			px-=v.px; 
			py-=v.py; 
		}
		public function turn(alpha:Number):void {
			var cos:Number=Math.cos(alpha);
			var sin:Number=Math.sin(alpha);
			var pxn:Number=px*cos-py*sin;
			var pyn:Number=py*cos+px*sin;
			px=pxn;
			py=pyn;
		}
		public function create(a:Object,b:Object):void{
			px=a.x-b.x;
			py=a.y-b.y;
		}
		//* function atan() return -pi/2<(angle)<pi/2
		//* function angle() return -pi<angle<=pi
		public function get angle():Number{
			var agl:Number=-2*pi;
			if(!px){
				if(py>0)agl=pi/2;
				if(py<0)agl=-pi/2;
			}else{
			agl=Math.atan(py/px);
			if(px<0){
				if(py>=0)agl+=pi;else agl-=pi;
				}
			}
			return agl;
		}
		public function get length():Number{
			return Math.sqrt(square);
		}
		public function get square():Number{ return px*px+py*py;}
		public function clear():void{
		 	px=0;py=0;
		}
		public function get show():String {
			return ("("+math.xround(px)+";"+math.xround(py)+")=|"+math.xround(length)+"|:<"+math.xround(math.deg(angle))+"'>");
		}
		//------------ graphic functions -----------------
		public function update():void{
			graphics.clear();
			graphics.lineStyle(2,0x0000FF);
			graphics.lineTo(px,py);
			graphics.lineStyle(2,0xFF0000);
			graphics.drawCircle(px,py,3);
		}
		//------------- static functions -----------------
		public static function multi(v:vector,k:Number):vector{
			return new vector(k*v.px,k*v.py);
		}
		public static function dot(v:vector,v2:vector):Number {
			return v2.px * v.px + v2.py * v.py;
		}
		public static function cross(v:vector,v2:vector):Number {
			return v.px * v2.py - v.py * v2.px;
		}
		public static function plus(v:vector,v2:vector):vector {
			return new vector(v.px + v2.px, v.py + v2.py); 
		}
		public static function minus(v:vector,v2:vector):vector {
			return new vector(v.px - v2.px, v.py - v2.py); 
		}
		public static function turn(v:vector,alpha:Number):vector {
			var cos:Number=Math.cos(alpha);
			var sin:Number=Math.sin(alpha);
			return new vector(v.px*cos-v.py*sin,v.py*cos+v.px*sin);
		}
		public static function create(a:Object,b:Object):vector {
			return new vector(a.x-b.x,a.y-b.y);
		}
	}
}