package lmath{
	import flash.geom.Matrix;

	public class matrix {
//		create a new matrix with xm rows; xn columes; and the data by a string impmt (see method inputmt)
		public function matrix(xm:Number=1,xn:Number=1,inpmt:String="") {
			if(xm<1||xn<1) trace("Size of matrix cant be smaller than 1x1");
			m=xm;n=xn;
			mt=new Array();
			if(!inpmt)for(var i:Number=1;i<=m;i++)
			{
				mt[i]=new Array();
				for(var j:Number=1;j<=m;j++)mt[i][j]=0;	
			}
			else inputmt(inpmt);
		}
//		number of rows
		public var m:Number;
//		number of columes
		public var n:Number;
//		this is the data set of the matrix
		public var mt:Array= new Array();
//      return a string by folow this order: element+" "+element2+" "+....+last element of a row
		public function tracemt():String{
			var str:String = new String("");
			for(var i:Number=1;i<=m;i++)
			{
			for(var j:Number=1;j<=n;j++)	if(j<n)str+=(mt[i][j]+" ");else str+=(mt[i][j]);
			if(i<m)str+="\n";
			}
			return str;
		}
//		input to matrix by a string that folow this order: element+" "+element2+" "+....+last element of a row
		// child function
		private function inputrow(str:String):Array{
			var k:Number=0;
			var id:Number=0;
			var j:Number=0;
			var ar:Array= new Array();
			do {
				id=str.indexOf(" ",k);
				if(id==-1)id=str.length;
				var estr:String=str.substring(k,id);
				if(estr)ar[++j]=Number(estr);
				k=id+1;
			}while(id<str.length);
			return ar;
		}
		////main function
		public function inputmt(str:String):void{
			var k:Number=0;
			var id:Number=0;
			var i:Number=0;
			do {
				id=str.indexOf("\n",k);
				if(id==-1)id=str.length;
				var ar:Array= inputrow(str.substring(k,id));
				if(ar.length)mt[++i]=ar;
				k=id+1;
			}while(id<str.length);
			m=i;n=mt[m].length-1;
		}
//		swap row px by py
		public function rswap(px:Number,py:Number):void{
			if(px<1||px>m||py<1||py>m)trace("Input out of matrix size!");
			var tr:Array;
			tr=mt[px];
			mt[px]=mt[py];
			mt[py]=tr;
		}
//		multi row px by number k
		public function rsmulti(px:Number,k:Number):void{
			if(px<1||px>m)trace("Input out of matrix size!");
			for(var j:Number=1;j<=n;j++) mt[px][j]*=k;
		}
//		plus rox px by k time py
		public function rplusk(px:Number,py:Number,k:Number):void{
			if(px<1||px>m||py<1||py>m)trace("Input out of matrix size!");
			for(var j:Number=1;j<=n;j++) mt[px][j]+=mt[py][j]*k;
		}
		/****************Static function******************/
//		return matrix transpose of matrix m1
		public static function trans(m1:matrix):matrix{
			var m3: matrix = new matrix(m1.n,m1.m);
			for(var i:Number=1;i<=m3.m;i++)
			for(var j:Number=1;j<=m3.n;j++)m3.mt[i][j]=m1.mt[j][i];
			return m3;
		}
//		return matrix result of matrix m1 + matrix m2
		public static function plus(m1:matrix,m2:matrix):matrix{
			if(m1.m==m2.m&&m1.n==m2.n){
				var m3:matrix = new matrix(m1.m,m1.n);
				for(var i:Number=1;i<=m3.m;i++)
				for(var j:Number=1;j<=m3.n;j++)m3.mt[i][j]=m1.mt[i][j]+m2.mt[i][j];
				return m3;
			}else{ trace("2 matrices are not same size!");return new matrix()}
		}
//		return matrix result of matrix m1 product scaler k
		public static function smulti(m1:matrix,k:Number):matrix{
			var m3:matrix = new matrix(m1.m,m1.n);
				for(var i:Number=1;i<=m3.m;i++)
				for(var j:Number=1;j<=m3.n;j++)m3.mt[i][j]=m1.mt[i][j]*k;
				return m3;
		}
//		return matrix result of matrix m1 - matrix m2
		public static function minus(m1:matrix,m2:matrix):matrix{
			return plus(m1,smulti(m2,-1));
		}
//		return matrix result of matrix m1 * matrix m2
		public static function multi(m1:matrix,m2:matrix):matrix{
			if(m1.n==m2.m){
				var m3:matrix = new matrix(m1.m,m2.n);
				for(var i:Number=1;i<=m3.m;i++)
				for(var j:Number=1;j<=m3.n;j++){
					var comb:Number=0;
					for(var k:Number=1;k<=m1.n;k++)comb+=m1.mt[i][k]*m2.mt[k][j];
					m3.mt[i][j]=comb;
				}
				return m3;
			}else{ trace("2 matrices cant multi in this way!");return new matrix(1,1,"0")}
		}
//		return matrix obtain from matrix m1 by remove row ii colum ij
		public static function mini(m1:matrix,ii:Number,ij:Number):matrix{
			var xi:Number = 0;
			var xj:Number = 0;
			if(ii>0&&ii<=m1.m)xi=1;
			if(ij>0&&ij<=m1.n)xj=1;
			var m3:matrix = new matrix(m1.m-xi,m1.n-xj);
			for(var i:Number=1;i<=m3.m;i++){if(i>=ii)xi=1;else xi=0;
				for(var j:Number=1;j<=m3.n;j++){if(j>=ij)xj=1;else xj=0;
					m3.mt[i][j] = m1.mt[i+xi][j+xj];
				}
			}
			return m3;
		}
		
//		return determinant of matrix m1
		public static function det(m1:matrix):Number{
			if(m1.m!=m1.n){trace("Det only for square matrix");return 0;}
			else if(m1.m==1) return m1.mt[1][1];
			var res:Number=0;
			for(var i:Number=1;i<=m1.n;i++){
				if(i%2)res+=m1.mt[1][i]*det( mini(m1,1,i) );
				else res-=m1.mt[1][i]*det( mini(m1,1,i) );
			}
			return res;
		}
//		return a mini square matrix degree p by remove rows and columes at the right and bottom
		public static function smini(m1:matrix,p:Number):matrix{
			if(p>m1.m||p>m1.n){trace("Unable to get mini square matrix from original matrix");return new matrix(1,1,"0");}
			var m3:matrix=m1;
			m3.m=m3.n=p;
			return m3;
		}
//		return rank of matrix m1
		public static function rank(m1:matrix):Number{
			var min:Number,de:Number;
			if(m1.m>m1.n)min=m1.n; else min=m1.m;
			for(var i:Number=min;i>=1;i--){
				de=det(smini(m1,i));
				if(de)break;
			}
			return i;
		}
//		return matrix inverse of matrix m1
		public static function inverse(m1:matrix):matrix{
			var de:Number=det(m1);
			if(!de){trace("Unable to get inverse matrix from original matrix (det = 0)");return new matrix(1,1,"0");}
			var c:matrix=new matrix(m1.m,m1.n);
			for(var i:Number=1;i<=m1.m;i++) 
				for(var j:Number=1;j<=m1.n;j++) c.mt[i][j]=det(mini(m1,i,j));
			return matrix.smulti( matrix.trans(c), 1/de );
		}
//		return a matrix by put matrix m2 at the right of m1
		public static function add(m1:matrix,m2:matrix):matrix{
			if(m1.m!=m2.m){trace("Unable to add two matrix A,B (different Number of rows)");return new matrix(1,1);}
			var m3:matrix=new matrix(m1.m,m1.n+m2.n);
			for(var i:Number=1;i<=m2.m;i++)
				for(var j:Number=1;j<=m1.n+m2.n;j++){
					if(j<=m1.n)m3.mt[i][j]=m1.mt[i][j];else m3.mt[i][j]=m2.mt[i][j-m1.n];
				}
			return m3;
		}
//		return a matrix by replace colume p of matrix m1 by the colume q of matrix m2
		public static function creplace(m1:matrix,p:Number,m2:matrix,q:Number=1):matrix{
			if(m1.m!=m2.m){trace("Unable to replace colume between two matrix A,B (different Number of rows)");return new matrix(1,1,"0");}
			var m3:matrix=new matrix(m1.m,m1.n,m1.tracemt());
			for(var i:Number=1;i<=m1.m;i++) 
				m3.mt[i][p]=m2.mt[i][q];
			return m3;
		}
//		return a matrix as a result of equation Ax=B
		public static function solve(m1:matrix,m2:matrix):matrix{
			var detA:Number=det(m1);
			if(!detA){trace("No result for this equation");return new matrix(1,1,"0");}
			var result:matrix=new matrix(1,m1.n);
			for(var i:Number=1;i<=m1.n;i++){ 
				result.mt[1][i]=( det( matrix.creplace(m1,i,m2,1) )/detA );
			}
			return result;
		}
	}
	
}
