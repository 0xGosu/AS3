package mathematic
{
	/**
	 * Class Imaginary use for complex number 
	 * @author TVA-Created 11/10/2010
	 * 
	 */
	public class Imaginary
	{
		public function Imaginary(pim:*=1)
		{
			if(pim is Number)pim = new Real(pim);
			im=pim;
		}
		public var im:*;
		public function toString():String{
			var str:String="";
			if(!(im.equal(1))){
			if(im is Real)str+=String(im);
			else str+=Nsystem.Open+String(im)+Nsystem.Close;
			}
			str+="i";
			return str;
		}
		//short method
		public function equal(i2:*):Boolean{
			if(i2 is Number)i2=new Real(i2);
			if(i2 is Imaginary)return Imaginary.equal(this,i2);
			if(i2.equal(0))return this.im.equal(0);
			return false;
		}
		public function smaller(i2:*):Boolean{
			if(i2 is Number)i2=new Real(i2);
			if(i2 is Imaginary)return Imaginary.smaller(this,i2);
			if(i2.equal(0))return this.im.smaller(0);
			return false;
		}
		public function plus(i2:*):*{
			if(i2 is Number) i2=new Real(i2);
			if(i2 is Imaginary) return Imaginary.add(this,i2);
			else return new Sum(i2,this);
		}
		public function multi(i2:*):*{
			if(i2 is Number) i2=new Real(i2);
			if(i2 is Imaginary) return Imaginary.multi(this,i2);
			else return new Imaginary(this.im.multi(i2));
		}
		public function nega():Imaginary{
			return Imaginary.negative(this);
		}
		public function inv():Imaginary{
			return Imaginary.inverse(this);
		}
		public function minus(i2:*):*{
			if(i2 is Number) i2=new Real(i2);
			return this.plus(i2.nega());
		}
		public function div(i2:*):*{
			if(i2 is Number) i2=new Real(i2);
			return this.multi(i2.inv());
		}
		//Static
		//Relation
		public static function equal(i1:Imaginary,i2:Imaginary):Boolean{
			return i1.im.equal(i2.im);
		}
		public static function smaller(i1:Imaginary,i2:Imaginary):Boolean{
			return i1.im.smaller(i2.im);
		}
		//Operators
		public static function add(i1:Imaginary,i2:Imaginary):Imaginary{
			return new Imaginary(i1.im.plus(i2.im));
		}
		public static function multi(i1:Imaginary,i2:Imaginary):*{
			return i1.im.multi(i2.im).nega();
		}
		//Inverses
		public static function negative(i1:Imaginary):Imaginary{
			return new Imaginary(i1.im.nega());
		}
		public static function inverse(i1:Imaginary):Imaginary{
			return new Imaginary(i1.im.inv().nega());
		}
	}
}