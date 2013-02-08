package translator
{	
	import translator.Rule;
	/**
	 * Basic translator words by words 
	 * MANUAL: </p>
	 * Step1: Input source code to variable <code>source</code> </p>
	 * Step2: Use method <code>translate()</code> to get translation from source code </p>
	 * Note: You can add more rule to property rules to get better tranlation
	 * @author V.Anh Tran 
	 * @see Rule
	 */
	public class Translator
	{
		public function Translator(psource:String)
		{
			
			clear();
			if(psource==""||psource=="null")adderr("No source code!");
			else source=psource;
		}
		/**
		 *Source 
		 */
		public var source:String="";
		
		/*Errors log */
		 
		
		public var errors:String="";
		protected var steperr:Number=0; 
		/**
		 * errors log function
		 * @param str error statement
		 * 
		 */
		protected function adderr(str:String):void{
			errors+="Error "+(++steperr)+" | "+str+"\n";
		}
		/**
		 *Clear the source code, errors log of the translator 
		 * 
		 */
		public function clear():void{
			source="";
			errors="";
			steperr=0;
		}
		//global translate
		/**
		 * Replace from firstindex to lastindex by the sentence 
		 * @param str original
		 * @param str2 replace sentence
		 * @param id firstindex 
		 * @param lid lastindex 
		 * @return replation
		 * @see String.indexOf()
		 */
		protected function replace(str:String,str2:String,id:Number,lid:Number):String{
			return str.substring(0,id)+str2+str.substring(lid+1); 
		}
		/**
		 * Rules use for translate 
		 */
		public var rule:Array= new Array();
		/**
		 * Add a new rule to rules
		 * @param str1 Original
		 * @param str2 Translation
		 * 
		 */
		public function addrule(str1:String, str2:String = ''):void {
			this.
			var r:Rule= new Rule(str1,str2);
			if(r.trans!="null"&&r.trans!="")rule.push(r);
			else adderr("Addrule failed because of no original!");
		}
		/**
		 * 
		 * @param str input string
		 * @return translated string
		 * 
		 */
		protected function globalTranslate(str:String):String{	
			for(var i:Number=0;i<rule.length;i++){
				var myPattern:RegExp = new RegExp(rule[i].ori,"g");
				str=str.replace(myPattern, rule[i].trans);
			}
			return str;
		}

		/**
		 * Translate source by folow rules
		 * @return translation
		 * 
		 */
		public function translate():String{
			var translation:String=globalTranslate(source);
			return translation;
		}	
	}
}