package mathematic
{
	/**
	 * Class Product <p>
	 * Express a Product of all elements that have non-closure operator Multi! 
	 * @author TVA-Created: 10/30/2010-Last modified: 11/1/2010
	 * 
	 */
	import string.Pstring;
	public dynamic class Product extends Array
	{
		/**
		 * Create a product of elements in params<p>
		 * Note: if the element is a Product, destruct it and push all its element to the new Product. 
		 * @param params Elements
		 * 
		 */
		public function Product(...params)
		{
			super();
			for(var i:int=0;i<params.length;i++){
				if(params[i] is Product){
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
		 * @see Nsystem.ProSym
		 */
		public function toString():String{
			var str:String="";
			if(this.length==1)return String(this[0]);
			var ch:Boolean=true;
			for(var i:int=0;i<this.length;i++){
				if(( this[i] is UV || (this[i] is Exponent && this[i].x is UV)  )&& this[i-1] is Real){str+=String(this[i]);continue;}
				//(this[i] is Exponent && this[i].x is UV) 
				
				if(ch&&(this[i] is Real||this[i] is Rational)){
					if(this[i].equal(-1)){str="-"+str;ch=false;continue;}
					if(this[i].smaller(0)){str="-"+str;if(i>0)str+=Nsystem.ProSym;	str+=String(this[i].nega());ch=false;continue;}
				}
				if(this[i] is Real||this[i] is Rational||this[i] is UV||this[i] is Imaginary||this[i] is Exponent){if(i>0)str+=Nsystem.ProSym;	str+=String(this[i]);continue;}
				
				if(i>0)str+=Nsystem.ProSym;	str+="("+this[i]+")";
			}
			return str;
		}
		/**
		 * Value of Product 
		 * @return 
		 * 
		 */
		public function toNumber():Number{
			var n:Number=1;
			for(var i:int=0;i<length;i++) n*=this[i].toNumber();
			return n;
		}
		// Short methods
		/**
		 * Similiar 
		 * @param p
		 * @return 
		 * @see Product.similiar
		 */
		public function similiar(p:*):Boolean{
			if(p is Number || p is Real || p is Rational|| p is Exponent || p is UV  || p is Imaginary)
				return Product.similiar(this,new Product(p));
			if(p is Product)return Product.similiar(this,p);
			return p.similiar(this);
		}
		/**
		 * Equal 
		 * @param p
		 * @return 
		 * @see Product.equal
		 */
		public function equal(p:*):Boolean{
			if(p is Number || p is Real || p is Rational|| p is Exponent || p is UV || p is Imaginary)
				return Product.equal(this,new Product(p));
			if(p is Product)return Product.equal(this,p);
			return p.equal(this);
		}
		public function smaller(p:*):Boolean{
			return false;
		}
		/**
		 * Plus 
		 * @param p
		 * @return 
		 * @see Product.add
		 */
		public function plus(p:*):*{
			if(p is Number || p is Real || p is Rational|| p is Exponent || p is UV || p is Imaginary)
				return Product.add(this,new Product(p));
			if(p is Product)return Product.add(this,p);
			return p.plus(this);
		}
		/**
		 * Multi 
		 * @param p
		 * @return 
		 * @see Product.multi
		 */
		public function multi(p:*):*{
			if(p is Number || p is Real || p is Rational|| p is Exponent || p is UV || p is Imaginary)
				return Product.multi(this,new Product(p));
			if(p is Product)return Product.multi(this,p);
			return p.multi(this);
		}
		/**
		 * Negative 
		 * @return 
		 * @see Product.negative
		 */
		public function nega():Product{
			return Product.negative(this);
		}
		/**
		 * Inverse 
		 * @return 
		 * @see Product.inverse
		 */
		public function inv():Product{
			return Product.inverse(this);
		}
		//Sub operators
		/**
		 * Minus 
		 * @param p
		 * @return 
		 * @see plus
		 */
		public function minus(p:*):*{
			if(p is Number)p=new Real(p);
			return this.plus(p.nega());
		}
		/**
		 * Div 
		 * @param p
		 * @return 
		 * @see multi
		 */
		public function div(p:*):*{
			if(p is Number)p=new Real(p);
			return this.multi(p.inv());
		}
		////// Static ////
		//Relation
		/**
		 * Check 2 product are similiar or not<p>
		 * Note: 2 product are call similiar to eachother if<p>
		 * +The Unknown part are same! <p>
		 * Ex: 12*x^3*2*x^2  and 2*x^2*x^3
		 * @param p1
		 * @param p2
		 * @return 
		 * 
		 */
		public static function similiar(p1:Product,p2:Product):Boolean{
			var fp1:Product=new Product(p1);
			var fp2:Product=new Product(p2);
			fp1.sort();fp2.sort();
			for(var j:int=0;j<fp1.length;j++){
				if(fp1[j] is Real||fp1[j] is Rational){fp1.splice(j,1);j--;}
			}
			for(j=0;j<fp2.length;j++){
				if(fp2[j] is Real||fp2[j] is Rational){fp2.splice(j,1);j--;}
			}
			
			if(fp1.length!=fp2.length)return false;
			else{
				for(var i:int=0;i<fp1.length;i++){
					if(!(fp1[i].equal(fp2[i])))return false;
				}
				return true;
			}
		}
		/**
		 * Check 2 product are equal or not<p>
		 * Note: 2 product call equal when<p>
		 * +The identified parts are equal<p>
		 * +The Unknown parts are same<p> 
		 * @param p1
		 * @param p2
		 * @return 
		 * 
		 */
		public static function equal(p1:Product,p2:Product):Boolean{
			var fp1:Product=new Product(p1);
			var fp2:Product=new Product(p2);
			fp1.sort();fp2.sort();
			var n:*=new Real(1);
			for(var j:int=0;j<fp1.length;j++){
				if(fp1[j] is Real||fp1[j] is Rational){n=n.multi(fp1[j]);fp1.splice(j,1);j--;}
			}
			var n2:*=new Real(1);
			for(j=0;j<fp2.length;j++){
				if(fp2[j] is Real||fp2[j] is Rational){n2=n2.multi(fp2[j]);fp2.splice(j,1);j--;}
			}
			if(!(n.equal(n2)))return false;
			if(n.equal(0))return true;
			if(fp1.length!=fp2.length)return false;
			else{
				for(var i:int=0;i<fp1.length;i++){
					if(!(fp1[i].equal(fp2[i])))return false;
				}
				return true;
			}
		}
		// Operators
		/**
		 * Operator add<p>
		 * Combile 2 product to 1 if they are similiar (Distributive law). Otherwise return a Sum of 2 product
		 * @param p1
		 * @param p2
		 * @return 
		 * 
		 */
		public static function add(p1:Product,p2:Product):*{
			if(similiar(p1,p2)){
				var fp1:Product=new Product(p1);
				var fp2:Product=new Product(p2);
				fp1.sort();fp2.sort();
				var n:*=new Real(1);
				for(var j:int=0;j<fp1.length;j++){
					if(fp1[j] is Real||fp1[j] is Rational){n=n.multi(fp1[j]);fp1.splice(j,1);j--;}
				}
				var n2:*=new Real(1);
				for(j=0;j<fp2.length;j++){
					if(fp2[j] is Real||fp2[j] is Rational){n2=n2.multi(fp2[j]);fp2.splice(j,1);j--;}
				}
				fp1.unshift(n.plus(n2));
				return fp1;
			}else{
				//Nsystem.log.addlog("non-Closure Operator Product.add! return a Sum");
				return new Sum(p1,p2);
			}
		}
		/**
		 * Operator multiplication <p> 
		 * Note: While processing, this operator will check if the element of p1 can be multi with one of all elements of p2<p>
		 * if not push that element to the end of p2 
		 * @param p1
		 * @param p2
		 * @return 
		 * 
		 */
		public static function multi(p1:Product,p2:Product):Product{
			var p:Product=new Product(p2);
			for(var i:int = 0;i<p1.length;i++){
				for(var j:int=0;j<p.length;j++){
					var me:*=p1[i].multi(p[j]);
					if(!(me is Product)){p[j]=me;break;}
				}
				if(j==p.length)p.push(p1[i]);
			}
			return p;
		}
		/**
		 * Negative Product<p>
		 * Note: Negativing the first element of product
		 * @param p1
		 * @return 
		 * 
		 */
		public static function negative(p1:Product):Product{
			var p:Product=new Product(p1);
			p[0]=p[0].nega();
			return p;
		}
		/**
		 * Inverse Product<p>
		 * Note: Equality with Product of all inverse elements 
		 * @param p1
		 * @return 
		 * 
		 */
		public static function inverse(p1:Product):Product{
			var p:Product=new Product(p1);
			for(var i:int=0;i<p.length;i++){
				p[i]=p[i].inv();
			}
			return p;
		}
	}
}