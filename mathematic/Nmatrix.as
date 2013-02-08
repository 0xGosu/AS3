package mathematic
{
	

	/**
	 * Class Nmatrix <p>
	 * Express a matrix with flexible element (Nsystem - Expression Number) 
	 * @author TVA-Created: 11/2/2010
	 * 
	 */
	public dynamic class Nmatrix extends Array
	{
		public function Nmatrix(pm:uint=0,pn:uint=0,obj:*=0)
		{
			super();
			this.unshift(null);
			m=pm;n=pn;
			if(obj is Number)obj=new Real(obj);
			for(var i:int=1;i<=m;i++){
				this.push(new Array());
				this[i].unshift(null);
				for(var j:int=1;j<=n;j++)this[i].push(obj);
			}
		}
		public var m:uint;
		public var n:uint;
		public function toString():String{
			if(!m&&!n)return null;
			var str:String = new String("");
			for(var i:Number=1;i<=m;i++)
			{
				for(var j:Number=1;j<=n;j++)	if(j<n)str+=String(this[i][j]+" "+Nsystem.NmixSym+" ");else str+=String(this[i][j]);
				if(i<m)str+="\n";
			}
			return str;
		}
		// Short method
		public function plus(m:Nmatrix):Nmatrix{
			return Nmatrix.add(this,m);
		}
		public function multi(m:Nmatrix):Nmatrix{
			return Nmatrix.multi(this,m);
		}
		public function nega():Nmatrix{
			return Nmatrix.negative(this);
		}
		public function inv():Nmatrix{
			return Nmatrix.inverse(this);
		}
		public function minus(m:Nmatrix):Nmatrix{
			return plus(m.nega());
		}
		// Others method
		//		swap row px by py
		public function rswap(px:uint,py:uint):void{
			if(px<1||px>m||py<1||py>m){Nsystem.log.addlog("Swap row error!Input out of Matrix size!");return;}
			var tr:Array=new Array();
			tr=this[px];
			this[px]=this[py];
			this[py]=tr;
		}
		//		multi row px by number k
		public function rsmulti(px:uint,k:*):void{
			if(px<1||px>m){Nsystem.log.addlog("Multi row error! Input out of Matrix size!");return;}
			for(var j:Number=1;j<=n;j++) this[px][j]=this[px][j].multi(k);
		}
		//		plus rox px by k time py
		public function rplusk(px:uint,py:uint,k:*):void{
			if(px<1||px>m||py<1||py>m){Nsystem.log.addlog("Plus row error! Input out of Matrix size!");return;}
			for(var j:Number=1;j<=n;j++) this[px][j]=this[px][j].plus(this[py][j].multi(k));
		}
		////////////////////Static 
		//Operators
		/**
		 * Addition <p>
		 * 2 matrix must be same size! (same m n)
		 * @param m1
		 * @param m2
		 * @return 
		 * 
		 */
		public static function add(m1:Nmatrix,m2:Nmatrix):Nmatrix{
			if(m1.m==m2.m&&m1.n==m2.n){
				var m3:Nmatrix = new Nmatrix(m1.m,m1.n);
				for(var i:Number=1;i<=m3.m;i++)
					for(var j:Number=1;j<=m3.n;j++)m3[i][j]=m1[i][j].plus(m2[i][j]);
				return m3;
			}else{ Nsystem.log.addlog("2 matrices are not same size! Return null matrix");return new Nmatrix()}
		}
		/**
		 * Multiplication <p>
		 * First matrix must have the number of rows equal the number of columes of the Second matrix<p>
		 * Ex: 2x4 multi 4x5 | 3x2 multi 2x2
		 * @param m1
		 * @param m2
		 * @return 
		 * 
		 */
		public static function multi(m1:Nmatrix,m2:Nmatrix):Nmatrix{
			if(m1.n==m2.m){
				var m3:Nmatrix = new Nmatrix(m1.m,m2.n);
				for(var i:Number=1;i<=m3.m;i++)
					for(var j:Number=1;j<=m3.n;j++){
						var comb:*=new Real(0);
						for(var k:Number=1;k<=m1.n;k++)comb=comb.plus(m1[i][k].multi(m2[k][j]));
						m3[i][j]=comb;
					}
				return m3;
			}else{ Nsystem.log.addlog("2 matrices cant multi in this way! Return null matrix");return new Nmatrix()}
		}
		//Inverse element
		public static function negative(m1:Nmatrix):Nmatrix{
			var m3:Nmatrix=new Nmatrix(m1.m,m1.n);
			for(var i:int=1;i<=m3.m;i++)
				for(var j:int=1;j<=m3.n;j++)m3[i][j]=m1[i][j].nega();
			return m3;
		}
		//		return MatrixQ inverse of MatrixQ m1
		public static function inverse(m1:Nmatrix):Nmatrix{
			var de:*=Nsystem.format(det(m1));
			if(de.equal(0)){Nsystem.log.addlog("Unable to get inverse MatrixQ from original MatrixQ (det = 0)");return new Nmatrix();}
			var c:Nmatrix=new Nmatrix(m1.m,m1.n);
			for(var i:Number=1;i<=m1.m;i++) 
				for(var j:Number=1;j<=m1.n;j++) if((i+j)%2)c[i][j]=Nsystem.format(det(mini(m1,i,j)).nega());else c[i][j]=Nsystem.format(det(mini(m1,i,j)));
			//return Nmatrix.trans(c);
			return Nmatrix.smulti( Nmatrix.trans(c), de.inv() );
		}
		
		//Others Operator
		//		return MatrixQ result of MatrixQ m1 product scaler k
		public static function smulti(m1:Nmatrix,k:*):Nmatrix{
			var m3:Nmatrix = new Nmatrix(m1.m,m1.n);
			for(var i:Number=1;i<=m3.m;i++)
				for(var j:Number=1;j<=m3.n;j++)m3[i][j]=m1[i][j].multi(k);
			return m3;
		}
		//Others element generator
		//		return MatrixQ transpose of MatrixQ m1
		public static function trans(m1:Nmatrix):Nmatrix{
			var m3: Nmatrix = new Nmatrix(m1.n,m1.m);
			for(var i:Number=1;i<=m3.m;i++)
				for(var j:Number=1;j<=m3.n;j++)m3[i][j]=m1[j][i];
			return m3;
		}
		//Others method
		//		return MatrixQ obtain from MatrixQ m1 by remove row ii colum ij
		public static function mini(m1:Nmatrix,ii:int,ij:int):Nmatrix{
			var xi:int = 0;
			var xj:int = 0;
			if(ii>0&&ii<=m1.m)xi=1;
			if(ij>0&&ij<=m1.n)xj=1;
			var m3:Nmatrix = new Nmatrix(m1.m-xi,m1.n-xj);
			for(var i:Number=1;i<=m3.m;i++){if(i>=ii)xi=1;else xi=0;
				for(var j:Number=1;j<=m3.n;j++){if(j>=ij)xj=1;else xj=0;
					m3[i][j] = m1[i+xi][j+xj];
				}
			}
			return m3;
		}
		
		//		return determinant of MatrixQ m1
		public static function det(m1:Nmatrix):*{
			if(m1.m!=m1.n){Nsystem.log.addlog("Det only for square MatrixQ! return 0");return new Real(0);}
			else if(m1.m==1) return m1[1][1];
			var res:*=new Real(0);
			for(var i:Number=1;i<=m1.n;i++){
				if(i%2)res=res.plus( m1[1][i].multi(det( mini(m1,1,i)) ) );
				else res=res.minus( m1[1][i].multi(det( mini(m1,1,i))) );
			}
			return res;
		}
		//		return a mini square MatrixQ degree p at qm,qn by remove others row and colum
		public static function smini(m1:Nmatrix,p:int,qm:uint,qn:uint):Nmatrix{
			if(p+qm>m1.m+1||p+qn>m1.n+1){Nsystem.log.addlog("Unable to get mini square MatrixQ from original MatrixQ");return new Nmatrix();}
			var m3:Nmatrix=new Nmatrix(p,p);
			for(var i:int=qm;i<p+qm;i++)
				for(var j:int=qn;j<p+qn;j++)m3[i-qm+1][j-qn+1]=m1[i][j];
			return m3;
		}
		//		return rank of MatrixQ m1
		public static function rank(m1:Nmatrix):*{
			var min:int=0;
			
			var ar:Array=new Array();
			var arid:Array=new Array();
			var de:*;
			var br:Boolean=false;
			//if(m1.m>m1.n)min=m1.n; else min=m1.m;
			for(var i:int=Math.min(m1.m,m1.n);i>=1;i--){
				for(var j:int=1;j<=m1.m-i+1;j++){
					for(var k:int=1;k<=m1.n-i+1;k++){
						de=Nsystem.format(det(smini(m1,i,j,k)));
						if(de.equal(0)==false){
							if(Nsystem.check(de,"UV")){ar.push(de);arid.push(i);}
							else {br=true;break;}
						}
					}
					if(br)break;	
				}
				if(br)break;
			}
			if(ar.length){
				var str:String="";
				for(j=0;j<ar.length;j++){
					str+="Rank "+arid[j]+" if "+ar[j]+"#0\n";
				}
				str+="Rank "+i+" (min)";
				return str;
			}
			return i;
		}
		/*
		//		return a MatrixQ by replace colume p of MatrixQ m1 by the colume q of MatrixQ m2
		public static function creplace(m1:Nmatrix,p:int,m2:Nmatrix,q:int=1):Nmatrix{
			if(m1.m!=m2.m){Nsystem.log.addlog("Unable to replace colume between two MatrixQ A,B (different Number of rows)");return new Nmatrix();}
			var m3:Nmatrix=new Nmatrix(m1.m,m1.n);
			for(var i:int=1;i<=m1.m;i++)
				for(var j:int=1;j<=m1.n;j++)m3[i][j]=m1[i][j];
			for(i=1;i<=m1.m;i++) 
				m3[i][p]=m2[i][q];
			return m3;
		}
		//		return a MatrixQ as a result of equation Ax=B
		public static function solve(m1:Nmatrix,m2:Nmatrix):Nmatrix{
			if(m2.m!=m1.m||m2.n!=1){Nsystem.log.addlog("Wrong matrix"); return new Nmatrix()};
			var detA:*=Nsystem.format(det(m1));
			if(detA.equal(0)){Nsystem.log.addlog("No result for this equation");return new Nmatrix();}
			var result:Nmatrix=new Nmatrix(1,m1.n,0);
			for(var i:int=1;i<=m1.n;i++){ 
				result[1][i]=( Nsystem.format(det( creplace(m1,i,m2,1) )).div(detA) );
			}
			return result;
		}*/
		//		return a Nmatrix by put Nmatrix m2 at the right of m1
		public static function combine(m1:Nmatrix,m2:Nmatrix):Nmatrix{
			if(m1.m!=m2.m){Nsystem.log.addlog("Unable to combine two Nmatrix A,B (different Number of rows)");return new Nmatrix();}
			var m3:Nmatrix=new Nmatrix(m1.m,m1.n+m2.n);
			for(var i:Number=1;i<=m2.m;i++)
				for(var j:Number=1;j<=m1.n+m2.n;j++){
					if(j<=m1.n)m3[i][j]=m1[i][j];else m3[i][j]=m2[i][j-m1.n];
				}
			return m3;
		}
	}
}