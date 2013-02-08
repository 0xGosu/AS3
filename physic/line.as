package physic{
	import flash.display.*;
	public class line extends Sprite{
		public var a:Number;
		public var b:Number;
		public var c:Number;
		// dk bp(a)+bp(b)#0
		public function line(VLa:Number=1,VLb:Number=1,VLc:Number=0){
			if(!VLa&&!VLb)trace("euro of line: a=b=0 ");
			a=VLa;
			b=VLb;
			c=VLc;
		}
		public function create(M:Object,U:vector):void{
			if(!U.length)trace("euro of line: a=b=0 ");
			a=-U.py;
			b=U.px;
			c=-a*M.x-b*M.y;
		} 
		public function distance(M:Object):Number{
			return Math.abs(a*M.x+b*M.y+c)/Math.sqrt(math.square(a)+math.square(b));
		}
		public function shadow(M:Object):point{
			var H:point=new point(0,0);
			if(!b){
				H.x=-c/a;
				H.y=M.y-(c/a+M.x)*b/a;
			}else{
				H.x=(b*b*M.x-a*c-a*b*M.y)/(a*a+b*b);
				H.y=-(c+a*H.x)/b;
			}
			return H;
		}
		public function cut(L:line):point{
			var D:Number=(a*L.b-L.a*b);
			var Dx:Number=(-c*L.b+L.c*b);
			var Dy:Number=(-a*L.c+L.a*c);
			return(new point(Dx/D,Dy/D));
		}
		public function get angle():Number{
			return Math.abs(new vector(b,-a).angle);
		}
		public function get show():String{
			return("line: "+math.xround(a)+"x+"+math.xround(b)+"y+"+math.xround(c)+"=0 :<"+math.xround(math.deg(angle))+"'>");
		}
		public function check(L:line):Number{
			var D:Number=(a*L.b-L.a*b);
			var Dx:Number=(-c*L.b+L.c*b);
			var Dy:Number=(-a*L.c+L.a*c);
			if(D)return 1;
			else{
				if(Dx||Dy)return 0;
				else return 2;
			}
		}
	}
}