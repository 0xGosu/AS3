package physic{
	public class point{
		public var x:Number=0;
		public var y:Number=0;
		public function point(vlx:Number=0,vly:Number=0){
			x=vlx;
			y=vly;
		}
		public function get show():String{
			return("("+x+";"+y+")");
		}
	}
}
