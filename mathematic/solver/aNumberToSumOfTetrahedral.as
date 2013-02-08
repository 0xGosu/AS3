package mathematic.solver
{
	/**
	 * ...
	 * @author HD.TVA
	 */
	public class aNumberToSumOfTetrahedral 
	{
		
		public function aNumberToSumOfTetrahedral() 
		{
			var max:Number = 1000000;
			p = new Array();
			best = new Array();
			for (var i:int = 0; i <= 1800; i++) {
				p[i] = (i + 1) * (i + 2) * (i + 3) / 6;
				if (p[i] > max) break;
				best[p[i]] = 1;
			}
			for (i = 2; i <= max; i++) {
				if(!best[i])best[i] = findBest(i);
				if (showProcess) trace(i+" :: "+best[i]);
			}
		}
		public var p:Array;
		public var best:Array;
		public var showProcess:Boolean = true;
		public function findBest(n:Number):Number {
			var temp:Array = new Array();
			for (var i:int = 0; i < findBigger(n); i++) 
				temp[i] = best[n - p[i]];
			return 1+minArr( temp);
		}
		public function findBigger(n:Number):Number {
			for (var i:int = 0; i < p.length; i++) {
				if (p[i] > n) return i;
			}
			return i;
		}
		public function minArr(arr:Array):Number {
			var minNum:Number = arr[0];
			for (var i:int = 1; i < arr.length; i++)
				if (arr[i] < minNum) minNum = arr[i];
			return minNum;
		}
	}

}