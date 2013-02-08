package mathematic.solver
{
	public class solveHardCenterColid
	{
		public function solveHardCenterColid(m1:Number,v1:Number,m2:Number,v2:Number)
		{
			var ttl:Number=m1+m2;
			var dfr:Number=m1-m2;
			if(m1)vx1=(v1*dfr+2*m2*v2)/ttl;
			else vx1=2*v2-v1;
			if(m2)vx2=(-v2*dfr+2*m1*v1)/ttl;
			else vx2=2*v1-v2;
		}
		public var vx1:Number;
		public var vx2:Number;
		public function toString():String{
			return "Result v1="+vx1+" v2="+vx2;
		}
	}
}