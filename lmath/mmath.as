package lmath  {
	
	public final class mmath {

		public static function mplus(m1:matrix,m2:matrix):matrix{
			if(m1.m==m2.m&&m1.n==m2.n){
				var m3:matrix = new matrix(m1.m,m1.n);
				for(var i=1;i<=m3.m;i++)
				for(var j=1;j<=m3.n;j++)m3[i][j]=m1[i][j]+m2[i][j];
				return m3;
			}else{ trace("2 matrices are not same size!");return new matrix()}
		}

	}
	
}
