package mathematic.solver
{
	import mathematic.Vector2D;

	/**
	 * Colid Checker <p>
	 * Check colission of 2 object with possition, velocity and radius in a period of time<p>
	 * Result is given in .t (the time when they colid, >0 mean after now, <0 mean before now, 0 mean now) <p>
	 * 0<= t < dt (if dt>0) <p> and dt<t<=0 (if dt<0) 
	 * @author TVA
	 * 
	 */
	public class checkColid2Circle
	{
		public function checkColid2Circle(p1:Vector2D,v1:Vector2D,r1:Number,p2:Vector2D,v2:Vector2D,r2:Number,dt:Number)
		{
			dp=p2.minus(p1);
			dv=v2.minus(v1);
			sr=r1+r2;
			// solve equation lv2  w a= dv^2; b=2.dp.dv; c=dp^2 - s^2;
			var solve:solveQuadraticEquation= new solveQuadraticEquation(dv.square,2*(dp.dot(dv)),dp.square-sr*sr);
			//gain t from solve and check if it suitable for delta t in system 
			if(solve.root==Infinity)root=Infinity;
			else{
				if(dt>0){
					if(solve.root==2){
						if(solve.x2>0&&solve.x2<dt){t=solve.x2;root=1}
						if(solve.x1>0&&solve.x1<dt){t=solve.x1;root=1}
					}
					if(solve.root==1&&solve.x1>0&&solve.x1<dt){t=solve.x1;root=1}
				}
				if(dt<0){
					if(solve.root==2){
						if(solve.x2<=0&&solve.x2>dt){t=solve.x2;root=1}
						if(solve.x1<=0&&solve.x1>dt){t=solve.x1;root=1}
					}
					if(solve.root==1&&solve.x1<=0&&solve.x1>dt){t=solve.x1;root=1}
				}
			}
		}
		public function toString():String{
			if(root==Infinity)return "They are always coliding!";
			if(root==1)return "They have colided at the time="+t;
			return "They haven't colided!";
		}
		/*vector distance of 2 object (p2-p1)*/
		public var dp:Vector2D;
		/*vector different betwwen velocity of 2 object (v2-v1)*/
		public var dv:Vector2D;
		/*sum of 2 circle radius*/
		public var sr:Number;
		/*Number of time colid (result 0/1 or infinity)*/
		public var root:Number = 0;
		/*the time different with the colision event happen and reality*/
		public var t:Number;
	}
}