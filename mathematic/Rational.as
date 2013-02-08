package mathematic
{
	/**
	 * Simple Rational base on 2 int a and b. Denote a/b <p>
	 * Default: a=0; b=1; <p>
	 * Ex: 1/2 ; 2/3 ; 
	 * @author TVA-Created 10/23/2010-Last Modified 11/1/2010
	 * 
	 */
	import string.Pstring;
	public final class Rational
	{
		/**
		 * Quotient
		 */
		public var a:*;
		/**
		 * Denominator (non zero) <p>
		 * Try to push this = 0 will generate Infinity
		 * @see Rational.log
		 */
		public var b:*;
	
		public function Rational( pa:*=0, pb:*=1):void 
		{ 	

			if(pa is Number)pa=new Real(pa);
			if(pb is Number)pb=new Real(pb);
			this.a = pa;
			this.b = pb;
		}

		
		/**
		 * Transform a Rational to String <p>
		 * Ex: 2/3 ; (2/3)/(1/2)<p>
		 * You can change / by any symbol you want through Rational.dSymbol
		 * If you want to automaticaly change a Int Rational such as 4/1 to Int 
		 * while transforming please change the value of Rational.autoInt to true before transform
		 * @param q
		 * @return a+dSymbol+b 
		 * @see Nsystem.RatiSym
		 * 
		 */
		public function toString():String{
			var sa:String="";
			var sb:String="";
			if(a is Real) sa=String(a);else sa="("+a+")";
			if(b is Real) sb=String(b);else sb="("+b+")";
			
			return String(sa+Nsystem.RatiSym+sb);
		}
		/**
		 * Transform a Rational to Number 
		 * @param q
		 * @return 
		 * 
		 */
		public function toNumber():Number{
			return a.toNumber()/b.toNumber();
		}
		// Short static method
		/**
		 * Equal 
		 * @param q
		 * @return 
		 * 
		 */
		public function equal(q:*):Boolean{
			if(q is Number || q is Real)return Rational.equal(this,new Rational(q));
			if(q is Rational)return Rational.equal(this,q);
			//Nsystem.log.addlog("Unable to check the relationship of Rational with "+Pstring.className(q));
			return q.equal(this);
		}
		public function smaller(q:*):Boolean{
			if(q is Number || q is Real)return Rational.smaller(this,new Rational(q));
			if(q is Rational)return Rational.smaller(this,q);
			//Nsystem.log.addlog("Unable to check the relationship of Rational with "+Pstring.className(q));
			return q.smaller(this);
		}
		/**
		 *Plus 
		 * @param q
		 * @return 
		 * 
		 */
		public function plus(q:*):*{
			if(q is Number || q is Real )return Rational.add(this,new Rational(q));
			if(q is Rational)return Rational.add(this,q);
			return q.plus(this);
		}
		/**
		 * Multi
		 * @param q
		 * @return 
		 * 
		 */
		public function multi(q:*):*{
			if(q is Number || q is Real )return Rational.multi(this,new Rational(q));
			if(q is Rational)return Rational.multi(this,q);
			return q.multi(this);
		}
		/**
		 * Negative element 
		 * @return 
		 * @see Rational.negative
		 */
		public function nega():Rational{
			return Rational.negative(this);
		}
		/**
		 * Inverse element 
		 * @return 
		 * @see Rational.inverse
		 */
		public function inv():Rational{
			return Rational.inverse(this);
		}
		/**
		 * Suboperator Subtraction. Denote by - 
		 * @param q1
		 * @param q2
		 * @return q1-q2
		 * 
		 */
		public function minus(q:*):*{
			if(q is Number)q=new Real(q);
			return plus(q.nega());
		}
		/**
		 * Suboperator Division . Denote by /
		 * @param q1
		 * @param q2
		 * @return q1/q2
		 * 
		 */
		public function div(q:*):*{
			if(q is Number)q=new Real(q);
			return multi(q.inv());
		}
		///////////////////// Static ////////////////////////////
		//Relation
		public static function equal(q1:Rational,q2:Rational):Boolean{
			if( q1.a.multi(q2.b).equal( q2.a.multi(q1.b) ) )return true;
			else{
				// Unable to change to a number but still referent to a same value via a same UnknowVar	
			}
			return false;
		}
		public static function smaller(q1:Rational,q2:Rational):Boolean{
			if( q1.a.multi(q2.b).smaller( q2.a.multi(q1.b) ) )return true;
			else{
				// Unable to change to a number but still referent to a same value via a same UnknowVar	
			}
			return false;
		}
		//Operators
		/**
		 * Operator addition. Denote by +
		 * @param q1
		 * @param q2
		 * @return q1+q2
		 * 
		 */
		public static function add(q1:Rational,q2:Rational):Rational{
			return new Rational(q1.a.multi(q2.b).plus( q1.b.multi(q2.a) ), q1.b.multi(q2.b));
		}
		/**
		 * Operator multiplication. Denote by * 
		 * @param q1
		 * @param q2
		 * @return q1*q2
		 * 
		 */
		public static function multi(q1:Rational,q2:Rational):Rational{
			return new Rational(q1.a.multi(q2.a) , q1.b.multi(q2.b));
		}
		//Inverse elements
		/**
		 * Negative Rational 
		 * @param q
		 * @return q negative 
		 * 
		 */
		public static function negative(q:Rational,t:Number=1):Rational{
		return new Rational(q.a.nega() , q.b);	
		}
		/**
		 * Inverse q <p>
		 * Error store in Rational.log 
		 * @param q
		 * @return q inverse
		 * @see Rational.log
		 */
		public static function inverse(q:Rational):Rational
		{
			return new Rational(q.b , q.a);
		}
		

	}
}