package physic{
	public final class math {
		public const g:Number=9.81;
		public static function deg(alpha:Number):Number{
			return (alpha*180/Math.PI)%360;
		}
		public static function rad(alpha:Number):Number{
			return (alpha*Math.PI/180)%2*Math.PI;
		}
		public static function getsex(x:Number):Number{
			if(!x)return 0;else{if(x<0)return -1;else return 1;}
		}
		public static function square(x:Number):Number{
			return x*x;
		}
		public static function distance(m:Object,n:Object):Number{
			return Math.sqrt(square(m.x-n.x)+square(m.y-n.y));
		}
		public static function xround(x:Number,scale:Number=100):Number{
			return Math.round(x*scale)/scale;
		}
	}
}
