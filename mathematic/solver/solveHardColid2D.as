package mathematic.solver
{
	import mathematic.Vector2D;

	public class solveHardColid2D
	{
		public function solveHardColid2D(p1:Vector2D,m1:Number,v1:Vector2D,p2:Vector2D,m2:Number,v2:Vector2D)
		{
			var dp:Vector2D=p2.minus(p1);
			
			////////////////
			var alpha:Number=dp.angle;
			// a
			var vxa:Number=v1.lengDir(alpha);
			// b
			var vxb:Number=v2.lengDir(alpha);
			//check correct impact
			
			if((vxa*vxb<0)||(vxa>vxb)){	
				// simulation impact
				solve=new solveHardCenterColid(m1,vxa,m2,vxb);
				// potien velocity
				pva=(Vector2D.createFromAgl(solve.vx1-vxa,alpha));
				pvb=(Vector2D.createFromAgl(solve.vx2-vxb,alpha));
			}			
		}
		public var solve:solveHardCenterColid;
		public var pva:Vector2D=new Vector2D();
		public var pvb:Vector2D=new Vector2D();
		public function toString():String{
			return "PVa="+pva+" PVb="+pvb;
		}
	}
}