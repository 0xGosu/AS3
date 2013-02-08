package mathematic
{
	/**
	 * Set of objects are in same class , Set is Array 1 based (first index is 1) <p>
	 * For extends this class, you should change property type to the Class u want elements be.<p>
	 * Ex: public dynamic class newSet extends finiteSet{<p> public function newSet{<p>super();<p>type=SomeClass;<p>}<p>}<p>
	 * Note: Default type is Number(that include int and uint)<p>
	 * A finiteSet allway include a element null (empty) at [0] 
	 * @author TVA-Created 10/23/2010
	 */
	public dynamic class FiniteSet extends Array
	{
		/**
		 * 
		 * @param m
		 * @param obdef It should not be an other FiniteSet or Array. <p> To create multi dimension FiniteSet you should create a empty FiniteSet and use for loop to push a new FiniteSet in to its elements
		 * 
		 */
		public function FiniteSet(m:int=0,obdef:*=0)
		{
			super();
			this.unshift(null);
			for(var i:int=1;i<=m;i++){
				if(obdef is FiniteSet){
					var ob:FiniteSet= new FiniteSet();
					ob=FiniteSet(obdef);
					this.push(ob);
				}
				else this.push(obdef);
			}
		}
		/**
		 *Class type 
		 */
		protected var type:Class = Number;
		/**
		 *  
		 * Elements Class 
		 * 
		 */
		public function get etype():Class{
			return type;
		}
		/**
		 * Return true length (= length-1) 
		 * @return 
		 * 
		 */
		public function get truelength():int{
			return this.length-1;
		}
		/**
		 * Check an object is a element of Set or not  
		 * You sould you this function as a preparation for operate on 2 Diffrent Set to make sure elements of them are in same class
		 * @param obj Object
		 * @return true if obj and Set's elements are in same class else false
		 * 
		 */
		public function check(obj:*):Boolean{
			return (obj is type);
		}
		/**
		 * Find the first element satisfy a condition
		 * @param f condition(obj:Object):Boolean 
		 * @return index of the first element satisfy condition
		 * @see P2
		 */
		public function first(f:Function,s:Array):*{
			for(var i:int=1;i<this.length;i++){
				var ns:Array=new Array();
				for(var j:int=0;j<=s.length;j++)ns.push(s[i]);
				//ns=Array(s);
				ns.push(i);
				if(this[i] is FiniteSet){
					first(f,ns);
				}
				else if(f(this[i])) {
					if(s.length)return ns;
					else return i;
				}
			}
			return 0;
		}
		public function findFirst(f:*,s:Array):*{
			for(var i:int=1;i<this.length;i++){
				var ns:Array=s;
				ns.push(i);
				if(this[i] is FiniteSet){
					findFirst(f,ns);
				}
				else if(f==this[i]) {
					if(s.length)return ns;
					else return i;
				}
			}
			return 0;
		}
		/**
		 * Find the last element satisfy a condition
		 * @param f condition(obj:Object):Boolean 
		 * @return index of the last element satisfy condition
		 * @see P2
		 */
		public function last2(f:Function):P2{
			for(var i:int=this.truelength;i>0;i--){
				if(this[i] is FiniteSet){
					for(var j:int=this.truelength;j>0;j--) if(f(this[i][j]))return new P2(i,j);
				}
				else if(f(this[i])) return new P2(i,0);
			}
			return new P2(0,0);
		}
		/**
		 * Executes a function on all elements
		 * @param f condition(obj:Object):void 
		 * 
		 */
		public function execute(f:Function):void{
			for(var i:int=1;i<this.length;i++){
				if(this[i] is FiniteSet)this[i].execute(f);
				else f(this[i]);
			}
		}
		public function massive(obj:*):void{
			for(var i:int=1;i<this.length;i++){
				if(this[i] is FiniteSet)massive(obj);
				else this[i]=obj;
			}
		}
		public function copy(fs:FiniteSet):void{
			
		}
		
	}
}