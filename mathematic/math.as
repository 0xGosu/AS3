package mathematic
{
	public final class math 
	{
		public function math()
		{
			
		}
		public static function gcd(a:int,b:int):int{
			a=Math.abs(a);b=Math.abs(b);
			if(a<b)return gcd(b,a);
			if(!b)return a;
			return gcd(b,a%b)
		}
		public static function sqrt(a:*):Exponent{
			return new Exponent(a, new Rational(1,2));
		}
		public const g:Number=9.81;
		public static function deg(alpha:Number):Number{
			return (alpha*180/Math.PI);
		}
		public static function rad(alpha:Number):Number{
			return (alpha * Math.PI / 180);
		}
		public static function getsex(x:Number):Number{
			if(!x)return 0;else{if(x<0)return -1;else return 1;}
		}
		public static function square(x:Number):Number{
			return x*x;
		}
		public static function distance(m:*,n:*):Number{
			return Math.sqrt(square(m.px-n.px)+square(m.py-n.py));
		}
		
		public static function xround(x:Number,scale:Number=100):Number{
			return Math.round(x*scale)/scale;
		}
		/**
		 * Generate a random int number from 0 to n 
		 * @param n
		 * @return 
		 * 
		 */
		public static function random(n:uint):uint{
			var rand:Number=Math.round(Math.random()*n);
			return rand;
		}
		/**
		 * Int division 
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */
		public static function divine(x:Number,y:Number):int{
			return (x-x%y)/y;
		}
	}
}