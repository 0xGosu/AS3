package mathematic
{

	public class Complex
	{
		public function Complex(real:*=0,comp:*=0)
		{
			r=real;
			c=comp;
			if(r is Number)r= new Real(r);
			if(c is Number)c= new Real(c);
		}
		public var r:*;
		public var c:*;
		public function toString():String{
			var real:String=r;
			var comp:String=c;
			if (!(r is Real))real="("+r+")"; 
			if (!(c is Real))comp="("+c+")"; 
			return real+"+"+comp+"i";
		}
		public function angle():Number{
			return Math.atan(c.toNumber()/r.toNumber());
		}
		public function length():*{
			return new Exponent(r.multi(r).plus( c.multi(c) ), new Rational(1,2) );
		}
		public function toPolar():String{
			return length()+"<<"+angle()/Math.PI+"PI";
		}
		public function fromPolar(length:Number,angle:Number):void{
			r=new Real(length*Math.cos(angle));
			c=new Real(length*Math.sin(angle));
		}
		//operators
		public function plus(z:*):Complex{
			if(z is Number)z= new Real(z);
			if(z is Real)z = new Complex(z,0);
			return Complex.add(this,z);
		}
		public function multi(z:*):Complex{
			if(z is Number)z= new Real(z);
			if(z is Real) return new Complex(r.multi(z),c.multi(z));
			return Complex.multi(this,z);
		}
		// sub operators
		public function minus(z:*):Complex{
			if(z is Number)z= new Real(z);
			return this.plus(z.nega());
		}
		// elements
		public function conj():Complex{
			return new Complex(r,c.nega());
		}
		public function nega():Complex{
			return new Complex(r.nega(),c.nega());
		}
		//Static
		public static function add(z1:Complex,z2:Complex):Complex{
			return new Complex(z1.r.plus(z2.r),z1.c.plus(z2.c));
		}
		public static function multi(z1:Complex,z2:Complex):Complex{
			return new Complex(z1.r.multi(z2.r).minus(z1.c.multi(z2.c)),z1.r.multi(z2.c).plus( z1.c.multi(z2.r) ) );
		}
		
	}
}