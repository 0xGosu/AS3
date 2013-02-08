package mathematic
{
	/**
	 * Class Sum <p>
	 * Express a Sum of all elements that have non-closure operator Add! 
	 * @author TVA-Created: 10/29/2010
	 * 
	 */
	import string.Pstring;
	public dynamic class Sum extends Array
	{
		/**
		 * Create a Sum by params <p>
		 * Note: Use for non closure Operating
		 * @param params
		 * 
		 */
		public function Sum(...params)
		{
			super();
			for(var i:int=0;i<params.length;i++){
				if(params[i] is Sum){
					for(var j:int=0;j<params[i].length;j++)this.push(params[i][j]);
					continue;
				}
				if(params[i] is Number)params[i]= new Real(params[i]);
				this.push(params[i]);
			}
			
		}
		/**
		 * String User Interface 
		 * @return 
		 * 
		 */
		public function toString():String{
			var str:String="";
			for(var i:int=0;i<this.length;i++){
				if(this[i] is Real|| this[i] is Rational|| this[i] is UV || this[i] is Imaginary){
					if(this[i].smaller(0)){
						str+=Nsystem.SumNega+String(this[i].nega());	
					}else{
					if(i>0)str+=Nsystem.SumSym;
					str+=String(this[i]);
					}
					continue;
				}
				if(this[i] is Product){
					for(var j:int=0;j<this[i].length;j++)
						if(this[i][j] is Real || this[i][j] is Rational )
							if(this[i][j].smaller(0)){str+=" "+this[i]+" "; break;}			
					
					if(j<this[i].length)continue;
		
				}
				if(i>0)str+=" "+Nsystem.SumSym;
				str+=this[i]+" ";
			}
			return str;
		}
		/**
		 * Value of Sum  
		 * @return 
		 * 
		 */
		public function toNumber():Number{
			var n:Number=0;
			for(var i:int=0;i<this.length;i++){
				n+=this[i].toNumber();
			}
			return n;
		}
		////// Short method
		public function equal(s:*):Boolean{
			if(s is Number || s is Real || s is Rational|| s is Product || s is Exponent || s is UV || s is Imaginary)
				return Sum.equal(this,new Sum(s));
			if(s is Sum)return Sum.equal(this,s);
			Nsystem.log.addlog("Unable to check the relationship of Sum with "+Pstring.className(s));
			return false;
		}
		public function smaller(s:*):Boolean{
			return false;
		}
		/**
		 * Plus with another Expression 
		 * @param s
		 * @return 
		 * @see Sum.add
		 */
		public function plus(s:*):*{
			if(s is Number || s is Real || s is Rational|| s is Product || s is Exponent || s is UV || s is Imaginary)
				return Sum.add(this,new Sum(s));
			if(s is Sum)return Sum.add(this,s);
			return s.plus(this);
		}
		/**
		 * Multi 
		 * @param s
		 * @return 
		 * @see Sum.multi
		 */
		public function multi(s:*):*{
			if(s is Number || s is Real || s is Rational|| s is Product || s is Exponent || s is UV || s is Imaginary)
				return Sum.multi(this,new Sum(s));
			if(s is Sum)return Sum.multi(this,s);
			return s.multi(this);
		}
		/**
		 * Negative
		 * @return 
		 * @see Sum.negative 
		 */
		public function nega():Sum{
			return Sum.negative(this);
		}
		/**
		 * Inverse (non-closure) 
		 * @return 
		 * @see Sum.inverse
		 */
		public function inv():*{
			return Sum.inverse(this);
		}
		// sub operator
		/**
		 * Minus (plus with negative)
		 * @param s
		 * @return 
		 * @see plus
		 */
		public function minus(s:*):*{
			if(s is Number)s=new Real(s);
			return this.plus(s.nega());
		}
		/**
		 * Careful when use this operator
		 * @param s
		 * @return 
		 * @see Sum.inverse
		 */
		public function div(s:*):*{
			if(s is Number)s=new Real(s);
			return this.multi(s.inv());
		}
		// Others method
		////////// static //////
		// Relation
		/**
		 * Relation Equal 
		 * @param s1
		 * @param s2
		 * @return 
		 * 
		 */
		public static function equal(s1:Sum,s2:Sum):Boolean{
			var sp1:Sum=new Sum(s1);
			var sp2:Sum=new Sum(s2);
			sp1.sort();sp2.sort();
			var n:*=new Real(0);
			for(var j:int=0;j<sp1.length;j++){
				if(sp1[j] is Real||sp1[j] is Rational){n=n.plus(sp1[j]);sp1.splice(j,1);j--;}
			}
			var n2:*=new Real(0);
			for(j=0;j<sp2.length;j++){
				if(sp2[j] is Real||sp2[j] is Rational){n2=n2.plus(sp2[j]);sp2.splice(j,1);j--;}
			}
			if(!(n.equal(n2)))return false;
			if(sp1.length!=sp2.length)return false;
			else{
				for(var i:int=0;i<sp1.length;i++){
					if(!(sp1[i].equal(sp2[i])))return false;
				}
				return true;
			}
		}
		// Operators 
		/**
		 * Operator addition  
		 * @param s1
		 * @param s2
		 * @return 
		 * 
		 */
		public static function add(s1:Sum,s2:Sum):Sum{
			var s:Sum=new Sum(s2);
			for(var i:int = 0;i<s1.length;i++){
				for(var j:int=0;j<s.length;j++){
					var me:*=s1[i].plus(s[j]);
					if(!(me is Sum)){s[j]=me;break;}
					}
				if(j==s.length)s.push(s1[i]);
			}
			return s;
		}
		/**
		 * Operator Multiplication 
		 * @param s1
		 * @param s2
		 * @return 
		 * 
		 */
		public static function multi(s1:Sum,s2:Sum):Sum{
			var s:Sum=new Sum();
			for(var i:int = 0;i<s1.length;i++){
				var si:Sum=new Sum(s2);
				for(var j:int=0;j<si.length;j++) si[j]=s1[i].multi(si[j]);
				s=Sum.add(s,si);
			}
			return s;
		}
		//// Inverse Elements
		/**
		 * Negative element 
		 * @param s1
		 * @return 
		 * 
		 */
		public static function negative(s1:Sum):Sum{
			var s:Sum=new Sum(s1);
			for(var i:int = 0;i<s.length;i++){
				s[i]=s[i].nega();
			}
			return s;
		}
		/**
		 * Inverse element (non-Closure)<p>
		 * Most time return a Rational;<p>
		 * Only the case that Sum has only one element, this return a sum that has only one inverse element 
		 * @param s1
		 * @return 
		 * 
		 */
		public static function inverse(s1:Sum):*{
			if(s1.length==1)return new Sum(s1.inv());
			//Nsystem.log.addlog("non-closure Operator Sum.inverse return a Rational");
			//return new Rational(1,s1);
			return new Exponent(s1,-1);
		}
	}
}