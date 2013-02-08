package game.random
{
	public final class Suffle
	{
		public function Suffle()
		{
		}
		/**
		 * Suffle the first m row, n colume of a Square Array 
		 */
		public static function squareArray(ar:Array,m:uint,n:uint,times:uint=10):void{
			for(var t:int=0;t<times;t++){
				
				for(var i:int=0;i<m;i++){
					for(var j:int=0;j<n;j++){
						var rand:Number=Math.round(Math.random()*m*n);
						if(rand==m*n)rand--;
						var colum:uint=rand%m;
						var row:uint=(rand-rand%m)/m;
						if(row==i&&colum==j)continue;
						var trans:Object=ar[row][colum];
						ar[row][colum]=ar[i][j];
						ar[i][j]=trans;
					}
				}
				
				/*
				var rand2:Number=Math.round(Math.random()*m*n);
				if(rand2==m*n)rand2--;
				
				var colum2:uint=rand2%m;
				var row2:uint=(rand2-rand2%m)/m;
				ar[row][colum]=ar[row2][colum2];
				ar[row2][colum2]=trans;
				*/
			}
		}
	}
}