package mathematic
{
	import flash.geom.Point;
	/**
	 * Vector in 2 dimension surface
	 * @author HD.TVA
	 */
	public class Vector2D
	{
		public function Vector2D(inp1:Number=0,inp2:Number=0){
			x=inp1;
			y=inp2;
		}
		private const pi:Number=Math.PI;
		private var _x:Number;
		private var _y:Number;
		public function get x():Number {
			return _x;
		}
		public function set x(val:Number):void {
			_x = val;
		}
		public function get y():Number {
			return _y;
		}
		public function set y(val:Number):void {
			_y = val;
		}
		/**
		 * Scalar Multi
		 * @param k
		 * 
		 */
		public function multi(k:Number):Vector2D{return new Vector2D(x*k,y*k);}
		public function div(k:Number):Vector2D{return new Vector2D(x/k,y/k);}
		public function scalar(kx:Number, ky:Number ):Vector2D { return new Vector2D(x * kx, y * ky);}
		/**
		 * Addition 
		 * @param v
		 * @return 
		 * 
		 */
		public function plus(v:Vector2D):Vector2D{return new Vector2D(x+v.x,y+v.y); }
		/**
		 * Subtraction 
		 * @param v
		 * @return 
		 * 
		 */
		public function minus(v:Vector2D):Vector2D{return new Vector2D(x-v.x,y-v.y); }
		
		/**
		 * Turn vector an alpha angle
		 * @param alpha (in Radian)
		 * @return 
		 * 
		 */
		public function turn(alpha:Number):Vector2D{
			var cos:Number=Math.cos(alpha);
			var sin:Number=Math.sin(alpha);
			return new Vector2D(x*cos-y*sin,y*cos+x*sin);
		}
		/**
		 * Create a clone for vector
		 * 
		 */
		public function clone():Vector2D{return new Vector2D(x, y);}
		/**
		 * Self Multi
		 * @param k
		 * 
		 */
		public function smulti(k:Number):void{x *= k; y *= k;}
		public function sdiv(k:Number):void{x /= k; y /= k;}
		public function selfScalar(kx:Number , ky:Number ):void { x *= kx; y *= ky;}
		/**
		 * Self Addition 
		 * @param v
		 * @return 
		 * 
		 */
		public function splus(v:Vector2D):void{x += v.x; y += v.y;}
		/**
		 * Self Subtraction 
		 * @param v
		 * @return 
		 * 
		 */
		public function sminus(v:Vector2D):void{x -= v.x; y -= v.y; }
		/**
		 * Self turn
		 * @param alpha (in Radian)
		 * @return 
		 * 
		 */
		public function sturn(alpha:Number):void{
			var cos:Number=Math.cos(alpha);
			var sin:Number=Math.sin(alpha);
			input(x*cos-y*sin,y*cos+x*sin);
		}
		/**
		 * Clear vector to vector zero
		 * 
		 */
		public function clear():void {	x=0;y=0;}
		/**
		 * Copy value from src.x and src.y 
		 * 
		 */
		public function copy(src:Object ):void {
			if(src.hasOwnProperty("x")&&src.hasOwnProperty("y")){
				x = src.x; y = src.y;
			}
		}
		/**
		 * Input value for vector  
		 * 
		 */
		public function input(px:Number ,py:Number  ):void {x = px; y = py;}
	
		/**
		 * Normal Multi 
		 * @param v
		 * @return 
		 * 
		 */
		public function dot(v:Vector2D):Number {return x * v.x + y * v.y;}
		/**
		 * Special Multi 
		 * @param v
		 * @return 
		 * 
		 */
		public function cross(v:Vector2D):Number {return x * v.y - y * v.x;}
		/**
		 *  Return the direction of vector by an angle (radian)<p>
		 * Note: function Math.atan return -pi/2<(angle)<pi/2
		 * If you change this propety, .x , .y will e changed but .length will remain the same as previous
		 * @return angle in Radian (-pi<angle<=pi)
		 * @see Math.atan
		 * 
		 */
		public function get angle():Number{
			var agl:Number=-2*pi;
			if(!x){
				if(y>0)agl=pi/2;
				if(y<0)agl=-pi/2;
				if(y==0)agl=0;
			}else{
				agl=Math.atan(y/x);
				if(x<0){
					if(y>=0)agl+=pi;else agl-=pi;
				}
			}
			return agl;
		}
		public function set angle(val:Number):void  {
			input(length, 0);
			turn(val);
		}
		/**
		 * Length of vector
		 * If you change this property, .x , .y will be changed but .angle will remain the same as previous
		 * @return 
		 * 
		 */
		public function get length():Number{return Math.sqrt(square);}
		public function set length(val:Number):void  {
			var curAngle:Number = angle;
			input(val, 0);
			turn(curAngle);
		}
		
		
		/**
		 * Square of vector Length 
		 * @return 
		 * 
		 */
		public function get square():Number{ return x*x+y*y;}	
		/**
		 * Vector's shadow 
		 * @param angle
		 * @return 
		 * @see Vector.lengDir
		 */
		public function lengDir(byAngle:Number):Number{
			if(length)return length*Math.cos(angle-byAngle);
			else return 0;
		}
		
		/**
		 * SUI: (x;y)=|length|:<angle'> <p>
		 * note: angle in Degree and all values are rounded by function math.xround  
		 * @return 
		 * @see math.xround
		 */
		public function toString():String {
			var str:String= "("+math.xround(x)+";"+math.xround(y)+")"; 
			if(Vector2D.showAngle)str+="=|"+math.xround(length)+"|:<"+math.xround(math.deg(angle))+"'>";
			return str;
		}
		/**
		 * Vector to Point(flash) <p>
		 * note: use this to sync with flash function that work with flash.geom.Point
		 * @return 
		 * @see Point
		 */
		public function toPoint():Point {
			return new Point(x, y);
		}
		//------------- static functions -----------------
		public static var showAngle:Boolean=false;

		public static function create(a:Object,b:Object):Vector2D{
			if(a.hasOwnProperty("x")&&a.hasOwnProperty("y")&&b.hasOwnProperty("x")&&b.hasOwnProperty("y")){
				return new Vector2D(b.x-a.x,b.y-a.y);
			}else
			if(a.hasOwnProperty("px")&&a.hasOwnProperty("py")&&b.hasOwnProperty("px")&&b.hasOwnProperty("py")){
				return new Vector2D(b.px-a.px,b.py-a.py);
			}else
			if(a.hasOwnProperty("p")&&b.hasOwnProperty("p")){
				return b.p.minus(a.p);
			}
			return new Vector2D();
		}
		/**
		 * Create vector from length and angle<p>
		 * Note: length may <0 
		 * @param l 
		 * @param angle
		 * @return 
		 * 
		 */
		public static function createFromAgl(l:Number,angle:Number):Vector2D{
			return new Vector2D(l,0).turn(angle);
		}
		/**
		 * Calculate the shadow of Vector by a direction 
		 * @param v
		 * @param angle
		 * @return 
		 * 
		 */
		public static function lengDir(v:Vector2D,angle:Number):Number{
			if(v.length)return v.length*Math.cos(v.angle-angle);
			else return 0;
		}
		
	}
}