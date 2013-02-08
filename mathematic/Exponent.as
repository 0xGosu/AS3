package mathematic
{
	/**
	 * Class Exponent <p>
	 * Express x^e 
	 * @author TVA-Created 10/30/2010
	 * 
	 */
	public class Exponent
	{
		public function Exponent(px:*=0,pe:*=1)
		{
			if(px is Number)px=new Real(px);
			if(pe is Number)pe=new Real(pe);
			x=px;
			e=pe;
		}
		// data structor
		public var e:*;
		public var x:*;
		// to method
		/**
		 * String User Interface<p>
		 * Ex: 3^2 | x^3 | 2^(2/3) 
		 * @return 
		 * @see Nsystem.ExpoSym
		 */
		public function toString():String{
			var px:String="";
			var pe:String="";
			
			if(!(x.smaller(0))&&(x is Real||x is UV))px=String(x);
			else px="("+String(x)+")";
			
			if(e is Real||e is UV)pe=String(e);
			else pe="("+String(e)+")";
			
			return px+Nsystem.ExpoSym+pe;
		}
		public function toNumber():Number{
			return Math.pow(x.toNumber(),e.toNumber());
		}
		// short method
		public function similiar(e:*):Boolean{
			if(e is Number || e is Real ||e is UV ||e is Rational || e is Imaginary )return Exponent.similiar(this,new Exponent(e));
			if(e is Exponent)return Exponent.similiar(this,e);
			return false;
		}
		public function equal(e:*):Boolean{
			if(e is Number || e is Real ||e is UV ||e is Rational || e is Imaginary )return Exponent.equal(this,new Exponent(e));
			if(e is Exponent)return Exponent.equal(this,e);
			return e.equal(this);
		}
		public function plus(e:*):*{
			if(e is Number || e is Real ||e is UV ||e is Rational || e is Imaginary )return Exponent.add(this,new Exponent(e));
			if(e is Exponent)return Exponent.add(this,e);
			return e.plus(this);
		}
		public function multi(e:*):*{
			if(e is Number || e is Real ||e is UV ||e is Rational || e is Imaginary )return Exponent.multi(this,new Exponent(e));
			if(e is Exponent)return Exponent.multi(this,e);
			return e.multi(this);
		}
		public function nega():*{
			return Exponent.negative(this);
		}
		public function inv():Exponent{
			return Exponent.inverse(this);
		}
		public function minus(e:*):*{
			if(e is Number)e=new Real(e);
			return this.plus(e.nega());
		}
		public function div(e:*):*{
			if(e is Number)e=new Real(e);
			return this.multi(e.inv());
		}
		/////// static 
		// Relation
		public static function similiar(e1:Exponent,e2:Exponent):Boolean{
			return (e1.x.equal(e2.x));
		}
		public static function equal(e1:Exponent,e2:Exponent):Boolean{
			return (similiar(e1,e2)&&(e1.e.equal(e2.e)));
		}
		// Opeators
		public static function add(e1:Exponent,e2:Exponent):*{
			if(equal(e1,e2)){
				return new Product(2,e1);
			}else{
				//Nsystem.log.addlog("non-Closure Operator Exponent.add! return a Sum");
				return new Sum(e1,e2);
			}
			
		}
		public static function multi(e1:Exponent,e2:Exponent):*{
			if(similiar(e1,e2)){
				return new Exponent(e1.x,e1.e.plus(e2.e));
			}
			//Nsystem.log.addlog("non-Closure Operator Exponent.multi! return a Product");
			return new Product(e1,e2);
		}
		// Inverse elements
		public static function negative(e1:Exponent):*{
			//Nsystem.log.addlog("non-Closure Operator Exponent.negative! return a Product");
			return new Product(-1,e1);
		}
		public static function inverse(e1:Exponent):Exponent{
			return new Exponent(e1.x,e1.e.nega());
		}
	}
}