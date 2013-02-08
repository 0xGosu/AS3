package mathematic
{
	/**
	 * Class UV <p>
	 * Express an Unknow Variable 
	 * @author TVA-Created 10/31/2010-Last Modified 11/1/2010
	 * 
	 */
	public class UV
	{
		public function UV(pname:String="x",pval:*="Unidentified")
		{
			name=pname;
			value=pval;
			if(!name)name="x";
			if(value is Number)value=new Real(value);
		}
		public var name:String;
		public var value:*;
		
		public function toString():String{
			if(value===UV.uni)return name;
			else return String(value);
		}
		public function valueOf():Object{
			if(value===UV.uni)return this;
			else return value;
		}
		public function toNumber():Number{
			if(value===UV.uni)return NaN;
			else return value.toNumber();
		}
		// Short methods
		public function equal(uv:*):Boolean{
			if(value===UV.uni){
				if(uv is UV)return UV.equal(this,uv);
				else return false;
			}else{
				return value.equal(uv);
			}
		}
		public function smaller(uv:*):Boolean{
			if(value===UV.uni){
				return false;
			}else{
				return value.smaller(uv);
			}
		}
		public function plus(uv:*):*{
			if(value===UV.uni){
				if(uv is Number||uv is Real|| uv is Rational|| uv is Exponent){
					//Nsystem.log.addlog("non-Closure Operator uv.plus! return a Sum");
					return new Sum(this,uv);
				}
				if(uv is UV)return UV.add(this,uv);
				return uv.plus(this);
			}else{
				return value.plus(uv);
			}
		}
		public function multi(uv:*):*{
			if(value===UV.uni){
				if(uv is Number||uv is Real|| uv is Rational){
					//Nsystem.log.addlog("non-Closure Operator uv.multi! return a Product");
					return new Product(this,uv);
				}
				if(uv is UV)return UV.multi(this,uv);
				return uv.multi(this);
			}else{
				return value.multi(uv);
			}
		}
		public function nega():*{
			if(value===UV.uni){
				return UV.negative(this);
			}else{
				return value.nega();
			}
		}
		public function inv():*{
			if(value===UV.uni){
				return UV.inverse(this);
			}else{
				return value.inv();
			}
		}
		//Sub operator
		public function minus(uv:*):*{
			if(uv is Number)uv=new Real(uv);
			return this.plus(uv.nega());
		}
		public function div(uv:*):*{
			if(uv is Number)uv=new Real(uv);
			return this.multi(uv.inv());
		}
		/////////Static
		public static const uni:String="Unidentified";
		public static var repNamebyValue:Boolean=false;
		//Relations
		public static function equal(uv1:UV,uv2:UV):Boolean{
			return (uv1.name==uv2.name);
		}
		//Operators
		public static function add(uv1:UV,uv2:UV):*{
			if(UV.equal(uv1,uv2)){
				return new Product(2,uv1);
			}else{
				//Nsystem.log.addlog("non-Closure Operator UV.add! return a Sum");
				return new Sum(uv1,uv2);
			}
		}
		public static function multi(uv1:UV,uv2:UV):*{
			if(UV.equal(uv1,uv2)){
				return new Exponent(uv1,2);
			}else{
				//Nsystem.log.addlog("non-Closure Operator UV.multi! return a Product");
				return new Product(uv1,uv2);
			}
		}
		// Inverse elements
		public static function negative(uv:UV):*{
			return new Product(-1,uv);
		}
		public static function inverse(uv:UV):*{
			return new Exponent(uv,-1);
		}
	}
}