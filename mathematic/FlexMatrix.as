package mathematic
{	
	//import mathematic.Rational;
	public dynamic class FlexMatrix extends FiniteSet
	{
		public function FlexMatrix(xm:int=0, xn:int=0)
		{
			
			super(xm, new FiniteSet(xn, Rational.o));
			//for(var i:int=1;i<=xm;i++)push(new FiniteSet(xn, Rational.o));
			type=Rational;
		}
		public function get m():int{
			return this.truelength;
		}
		public function get n():int{
			return this[m].truelength;
		}
		public static function toString(f:FlexMatrix):String{
			var str:String = new String("");
			for(var i:Number=1;i<=f.m;i++)
			{
				for(var j:Number=1;j<=f.n;j++)	if(j<f.n)str+=(f[i][j].sui+" ");else str+=(f[i][j].sui);
				if(i<f.m)str+="\n";
			}
			return str;
		}
		private static function inputrow(str:String,type:Class):Array{
			var k:Number=0;
			var id:Number=0;
			var j:Number=0;
			var ar:Array= new Array();
			ar.unshift(null);
			do {
				id=str.indexOf(" ",k);
				if(id==-1)id=str.length;
				var estr:String=str.substring(k,id);
				if(estr)ar.push(type.fromString(estr));
				k=id+1;
			}while(id<str.length);
			return ar;
		}
		////main function
		public static function fromString(str:String):FlexMatrix{
			var k:Number=0;
			var id:Number=0;
			var i:Number=0;
			var mt:FlexMatrix=new FlexMatrix();
			do {
				id=str.indexOf("\n",k);
				if(id==-1)id=str.length;
				var ar:Array= inputrow(str.substring(k,id),mt.etype);
				if(ar.length)mt.push(ar);
				k=id+1;
			}while(id<str.length);
			return mt;
		}
	}
}