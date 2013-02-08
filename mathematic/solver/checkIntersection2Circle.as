package mathematic.solver
{
	import mathematic.Vector2D;
	/**
	 * Check Intersect 2 circle
	 * @author TVA
	 * 
	 */
	public class checkIntersection2Circle
	{
		public function checkIntersection2Circle(p1:Vector2D,r1:Number,p2:Vector2D,r2:Number,trueIntersect:Boolean=false )
		{
			dp=p2.minus(p1);
			sumR=r1+r2;
			// Check Intersection
			if (trueIntersect) {
				if (dp.length < sumR) result = true;
				else result = false;
			}else{
				if (dp.length <= sumR) result = true;
				else result = false;
			}
		}
		/*Vector distance of 2 circle (p2-p1)*/
		public var dp:Vector2D;
		/*sum of 2 circle radius*/
		public var sumR:Number;
		/*result of check*/
		public var result:Boolean = false;
	}
}