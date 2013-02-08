package mathematic
{
	import logger.ErrorLog;
	
	import string.Pstring;

	/**
	 * Nsystem 
	 * @author TVA-Created 11/1/2010
	 * 
	 */
	public class Nsystem
	{
		public function Nsystem(pex:*=0)
		{
			if(pex is Number)pex= new Real(pex);
			if(pex is String)pex= new UV(pex);
			if(pex is Nsystem)pex= pex.ex;
			if(pex is Real||pex is Rational||pex is Exponent||pex is UV||pex is Sum||pex is Product)
			ex=pex;
			else {ex=new Real(0);Nsystem.log.addlog("Unknow type input to Nsystem!");}
		}
		public var ex:*;
		public function toString():String{
			return ex.toString();
		}
		public function valueOf():Object{
			return ex;
		}
		public function toNumber():*{
			ex.toNumber();
		}
		// short method
		public function equal(n:*):Boolean{
			return ex.equal(n);
		}
		public function plus(n:*):*{
			return new Nsystem(ex.plus(n));
		}
		public function multi(n:*):*{
			return new Nsystem(ex.multi(n));
		}
		public function nega():*{
			return new Nsystem(ex.nega());
		}
		public function inv():*{
			return new Nsystem(ex.inv());
		}
		public function minus(n:*):*{
			return new Nsystem(ex.minus(n));
		}
		public function div(n:*):*{
			return new Nsystem(ex.div(n));
		}
		///////////Static 
		public static var log:ErrorLog=new ErrorLog(false);
		public static function format(obj:*):*{
			//var ob:*;
			if(obj is Real){return new Real(obj.n);}
			if(obj is Rational){
				var ob:Rational=new Rational(obj.a,obj.b);
				ob.a=format(ob.a);ob.b=format(ob.b);
				if((ob.a is Rational && ob.b is Rational)||(ob.a is Rational && ob.b is Real)||(ob.a is Real && ob.b is Rational)){
					ob=ob.a.div(ob.b);
				}
				if(ob.a is Real && ob.b is Real && ob.a.toNumber() is int && ob.b.toNumber() is int){
					if(ob.b.smaller(0)){ob.a=ob.a.nega();ob.b=ob.b.nega();}
					var gcd:int=math.gcd(int(ob.a.toNumber()),int(ob.b.toNumber()));
					ob.a.n/=gcd;ob.b.n/=gcd;
				}
				if(Nsystem.deRational && ob.b.equal(1))return ob.a;
				return ob;
			}
			if(obj is Exponent){
				var expo:Exponent=new Exponent(obj.x,obj.e);
				expo.x=format(expo.x);expo.e=format(expo.e);
				if(expo.x is Exponent){
					expo.e=expo.x.e.multi(expo.e);
					expo.x=expo.x.x;
					expo.e=format(expo.e);
				}
				if(Nsystem.ZeroExponent && expo.e.equal(0))return new Real(1);
				if(Nsystem.deExponent && expo.e.equal(1))return expo.x;
				if(Nsystem.deExponent && expo.e is Real && expo.e.n is uint){
					if(expo.x is Real || expo.x is Rational || expo.x is Imaginary || (Nsystem.deExponentSum && expo.x is Sum)){
						var x:*=new Real(1);
						for(i=0;i<expo.e.n;i++)x=x.multi(expo.x);
						return Nsystem.format(x);
					}
				}
				return expo;
			}
			
			if(obj is UV){
				var uv:UV=new UV(obj.name,obj.value);
				if(!(uv.value===UV.uni)){
					uv.value=format(uv.value);
				}
				return uv;
			}
			if(obj is Imaginary){
				if(check(obj.im,"Imaginary")){
					return format(obj.im.multi(new Imaginary(1)));
				}
				return new Imaginary(Nsystem.format(obj.im));
			}
			
			if(obj is Product){
				var fp:Product=new Product(obj);
				for(var i:int=0;i<fp.length;i++){
					fp[i]=format(fp[i]);
					if(fp[i].equal(new Real(0)) && Nsystem.ZeroProduct)return new Real(0);
					if(fp[i].equal(new Real(1)) && fp.length>1){fp.splice(i,1);i--;continue;}
					if(fp[i] is Product){
						for(j=0;j<fp[i].length;j++)fp.push(fp[i][j]);
						fp.splice(i,1);i--;continue;
					}
				}
				
				fp=fp.multi(new Product(1));
				
				for(i=0;i<fp.length;i++){
					fp[i]=format(fp[i]);
					if(fp[i].equal(new Real(0)) && Nsystem.ZeroProduct)return new Real(0);
					if(fp[i].equal(new Real(1)) && fp.length>1){fp.splice(i,1);i--}
				}
				fp.sort();
				if(Nsystem.deProduct && fp.length==1)return fp[0];
				return fp;
			}
			
			if(obj is Sum){
				var sp:Sum=new Sum(obj);
				for(i=0;i<sp.length;i++){
					sp[i]=format(sp[i]);
					if(sp[i].equal(new Real(0)) && sp.length>1){sp.splice(i,1);i--}
					if(sp[i] is Sum){
						for(j=0;j<sp[i].length;j++)sp.push(sp[i][j]);
						sp.splice(i,1);i--;continue;
					}
					
				}
				
				sp=sp.plus(new Sum(0));
				
				for(i=0;i<sp.length;i++){
					sp[i]=format(sp[i]);
					if(sp[i].equal(new Real(0)) && sp.length>1){sp.splice(i,1);i--}
				}
				sp.sort();
				if(Nsystem.deSum && sp.length==1)return sp[0];
				return sp;
			}
			if(obj is Nmatrix){
				var nm:Nmatrix=new Nmatrix(obj.m,obj.n);
				for(i=1;i<=obj.m;i++)
					for(var j:int=1;j<=obj.n;j++)nm[i][j]=format(obj[i][j]);
				return nm;
			}
			if(obj is Number) return new Real(obj);
			if(obj is String) return Pstring.toNsystem(obj);
			if(obj is null)return new Real(0);
			return obj;
		}
		
		public static function check(ob:*,cname:String="UV"):Boolean{
			switch(Pstring.className(ob)){
				case "Real": if(cname=="Real")return true; else
					return false;
				case "Rational": if(cname=="Rational")return true; else
					return(check(ob.a,cname)||check(ob.b,cname));
				case "UV": if(cname=="UV")return true; else
					return false;
				case "Imaginary": if(cname=="Imaginary")return true; else
					return false;
				case "Exponent": if(cname=="Exponent")return true; else
					return(check(ob.x,cname)||check(ob.e,cname));
				case "Product": if(cname=="Product")return true; 
					for(var i:int=0;i<ob.length;i++) if(check(ob[i],cname))return true;
					return false;
				case "Sum": if(cname=="Sum")return true; 
					for(i=0;i<ob.length;i++) if(check(ob[i],cname))return true;
					return false;
				case "Nmatrix": if(cname=="Nmatrix")return true;
					for(i=1;i<=ob.m;i++) 
						for(var j:int=1;j<=ob.n;j++)if(check(ob[i][j],cname))return true;
					return false;
			}
			return false;
		}
		public static function valueUV(ob:*,cname:String,val:*):void{
			switch(Pstring.className(ob)){
				case "Real": break;
				case "Rational":
					valueUV(ob.a,cname,val);valueUV(ob.b,cname,val);
					break;
				case "UV": if(cname==ob.name)ob.value=val;
							else if(ob.value!=UV.uni)valueUV(ob.value,cname,val);
					break;
				case "Exponent": 
					valueUV(ob.x,cname,val);valueUV(ob.e,cname,val);
					break;
				case "Product":  
					for(var i:int=0;i<ob.length;i++) valueUV(ob[i],cname,val);
					break;
				case "Sum":  
					for(i=0;i<ob.length;i++) valueUV(ob[i],cname,val);
					break;
				case "Nmatrix": 
					for(i=1;i<=ob.m;i++) 
						for(var j:int=1;j<=ob.n;j++) valueUV(ob[i][j],cname,val);
					break;
			}
			
		}
		// Optional var
		public static var deRational:Boolean=true;
		public static var deExponent:Boolean=true;
		public static var deProduct:Boolean=true;
		public static var deSum:Boolean=true;
		public static var deExponentSum:Boolean=true;
		public static var ZeroExponent:Boolean=true;
		public static var ZeroProduct:Boolean=true;
		
		// toString() Variables
		public static var Open:String="(";
		public static var Close:String=")";
		//public static var Open2:String="[";
		//public static var Close2:String="]";
		public static var Open3:String="{";
		public static var Close3:String="}";
		
		public static var RatiSym:String="/";
		public static var ExpoSym:String="^";
		public static var ProSym:String="*";
		public static var SumSym:String="+";
		public static var SumNega:String="-";
		public static var NmixSym:String="|";
		public static var NmixSym2:String=";";
		public static var NmixSym3:String=",";
		
	}
}