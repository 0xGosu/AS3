package string
{
	import mathematic.*;
	public final class Pstring
	{
		public function Pstring()
		{
		}
		public static function splice(str:String,id:uint,count:uint,str2:String):String{
			return str.substring(0,id)+str2+str.substring(id+count);
		}
		/**
		 * Return class name of an Object 
		 * @param ob
		 * @return 
		 * 
		 */
		public static function className(ob:Object):String{
			var str:String=String(ob.constructor);
			return str.substring(str.indexOf(" ",0)+1,str.length-1);
		}
		/**
		 * Return an Array that store whold charcode of every single character in string str 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toCharCode(str:String):Array{
			var ar:Array=new Array();
			for(var i:int=0;i<str.length;i++)ar.push(str.charCodeAt(i));
			return ar;
		}
		/**
		 * Return an Array that store positions of every defined symbol in a String <p>
		 * @param str String
		 * @param sym Symbol
		 * @return Position Array
		 * 
		 */
		public static function positionArray(str:String,sym:String):Array{
			var ar:Array=new Array();;
			var id:int=-1;
			do{
				id=str.indexOf(sym,id+1);
				if(id>=0)ar.push(id);
			}while(id>=0);
			return ar;
		}
		// Nsystem string input
		public static function trueSplit(str:String,sym:String):Array{
			var openAr:Array=positionArray(str,Nsystem.Open);
			var closeAr:Array=positionArray(str,Nsystem.Close);
			var trueAr:Array=positionArray(str,sym);
			for(var i:int=0;i<trueAr.length;i++){
				for(var j:int=0;j<Math.min(openAr.length,closeAr.length);j++){
					if(trueAr[i]>openAr[j]&&trueAr[i]<closeAr[j]){trueAr.splice(i,1);i--;}
				}
			}
			return trueAr;
		}
		/**
		 * You should use toNsystem instead of this method 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toReal(str:String):Real{
			str=str.replace("(","");
			str=str.replace(")","");
			
			return new Real(Number(str));
		}
		/**
		 * You should use toNsystem instead of this method 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toRational(str:String):Rational{
			if(str.charAt(0)=='(' && str.charAt(str.length-1)==')')
				str=str.substring(1,str.length-1);
			
			var ar:Array=trueSplit(str,Nsystem.RatiSym);
			var q:Rational=new Rational();
			var id:int=ar.pop();
			q.a=toNsystem(str.substring(0,id));
			q.b=toNsystem(str.substring(id+1));
			return q;
		}
		/**
		 * You should use toNsystem instead of this method 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toUV(str:String):UV{
			str=str.replace("(","");
			str=str.replace(")","");
			return new UV(str);
		}
		/**
		 * You should use toNsystem instead of this method 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toImaginary(str:String):Imaginary{
			str=str.replace("(","");
			str=str.replace(")","");
			if(str=="i")return new Imaginary(1);
			var ii:int=str.indexOf("i");
			return new Imaginary(toNsystem(str.substring(0,ii)));
		}
		/**
		 * You should use toNsystem instead of this method 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toExponent(str:String):Exponent{
			if(str.charAt(0)=='(' && str.charAt(str.length-1)==')')
				str=str.substring(1,str.length-1);
			
			var ar:Array=trueSplit(str,Nsystem.ExpoSym);
			var id:int=ar.pop();
			var expo:Exponent=new Exponent();
			expo.x=toNsystem(str.substring(0,id));
			expo.e=toNsystem(str.substring(id+1));
			return expo;
		}
		/**
		 * You should use toNsystem instead of this method 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toProduct(str:String):Product{
			if(str.charAt(0)=='(' && str.charAt(str.length-1)==')')
				str=str.substring(1,str.length-1);
			
			var ar:Array=trueSplit(str,Nsystem.ProSym);
			ar.unshift(-1);
			ar.push(str.length);
			var p:Product=new Product();
			for(var i:int=0;i<ar.length-1;i++){ 
					p[i]=toNsystem(str.substring( ar[i]+1,ar[i+1] ) );	
			}
			return p;
		}
		
		/**
		 * You should use toNsystem instead of this method 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toSum(str:String):Sum{
			if(str.charAt(0)=='(' && str.charAt(str.length-1)==')')
				str=str.substring(1,str.length-1);
			
			var ar:Array=trueSplit(str,Nsystem.SumSym);
			var ar2:Array=trueSplit(str,Nsystem.SumNega);
			for(var i:int=0;i<ar2.length;i++)ar.push(ar2[i]);
			ar.sort(Array.NUMERIC);
			ar.unshift(-1);
			ar.push(str.length);
			var s:Sum=new Sum();
			for(i=0;i<ar.length-1;i++){ 
				if(ar2.indexOf(ar[i])<0){
					s[i]=toNsystem(str.substring( ar[i]+1,ar[i+1] ) );
				}else{
					s[i]=toNsystem(str.substring( ar[i]+1,ar[i+1] ) ).nega();
				}
			}
			return s;
		}
		
		
		/**
		 * Input an expression (Nsystem) from String 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toNsystem(str:String):*{
			if(str==""||str==null)return new Real(0);
			var myP:RegExp = new RegExp(" ","g");
			str=str.replace(myP,"");
			myP= new RegExp("\n","g");
			str=str.replace(myP,"");
			
			myP= new RegExp(Nsystem.Open3,"g");str=str.replace(myP,Nsystem.Open);
			myP= new RegExp(Nsystem.Close3,"g");str=str.replace(myP,Nsystem.Close);
			
			if(str.charAt(0)=='(' && str.charAt(str.length-1)==')')
				str=str.substring(1,str.length-1);
			
			var ar:Array=toCharCode(str);
			var k:int=0;
			for(var i:int=0;i<ar.length;i++){
				if(ar[i]>=48&&ar[i]<=57){
					if((ar[i+1]>=65&&ar[i+1]<=90)||(ar[i+1]>=97&&ar[i+1]<=122)||ar[i+1]==40){
						k++;
						str=splice(str,i+k,0,"*");
					}
				}
			}
			
			if(str==""||str==null)return new Real(0);
			
			ar=trueSplit(str,Nsystem.SumSym);
			var ar2:Array=trueSplit(str,Nsystem.SumNega);
			if(ar.length||ar2.length)return toSum(str);
			
			ar=trueSplit(str,Nsystem.ProSym);
			if(ar.length)return toProduct(str);
			
			ar=trueSplit(str,Nsystem.RatiSym);
			if(ar.length)return toRational(str);
			
			ar=trueSplit(str,Nsystem.ExpoSym);
			if(ar.length)return toExponent(str);
			
			ar= toCharCode(str);
			for(i=0;i<ar.length;i++){
				if(ar[i]==105)return toImaginary(str);
				if((ar[i]>=65&&ar[i]<=90)||(ar[i]>=97&&ar[i]<=122))return toUV(str);
			}
			return toReal(str);
		}

		/**
		 * Input a Nmatrix from String 
		 * @param str
		 * @return 
		 * 
		 */
		public static function toNmatrix(str:String):Nmatrix{
			if(str==""||str==null||str=="null")return new Nmatrix();
			myP = new RegExp(Nsystem.NmixSym2,"g");
			str=str.replace(myP,Nsystem.NmixSym);
			myP = new RegExp(Nsystem.NmixSym3,"g");
			str=str.replace(myP,Nsystem.NmixSym);
			
			var ar:Array = str.split("\n");
			var nm:Nmatrix=new Nmatrix();
			for(var i:int=0;i<ar.length;i++){
				if(String(ar)==""||String(ar)=="null")continue;
				var rar:Array = ar[i].split(Nsystem.NmixSym);
				if(rar.length==1){
					var myP:RegExp = new RegExp(" ","g");
					rar[0]=rar[0].replace(myP,"");
					if(String(rar[0])==""||String(rar[0])=="null")continue;
				}
				
				
				for(var j:int=0;j<rar.length;j++)rar[j]=toNsystem(String(rar[j]));
				rar.unshift(null);
				nm.push(rar);
			}
			nm.m=nm.length-1;
			nm.n=nm[nm.m].length-1;
			return nm;
		}
		
		
	}
}