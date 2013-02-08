package translator.programing
{
	/**
	 * AS3 to C Translator Class </p>
	 * MANUAL: </p>
	 * Step1: Input source code to variable <code>source</code> </p>
	 * Step2: Use method <code>translate()</code> to get translation from source code </p>
	 * Note: As a basic Translator, You can add more rule to get better tranlation
	 * @author V.Anh Tran (Last modified: 10/21/2010)
	 * @see Translator
	 */
	import translator.Translator;
	

	public class AS3toC extends Translator
	{
		/**
		 * Create new translator
		 * @param psource source code
		 * 
		 */
		public function AS3toC(psource:String)
		{ 
			super(psource);
		}
		//structure translate 
		/**
		 * Translate variable decalration
		 * @param str input string that store declaration of variable
		 * @return translated string
		 */
		private function transvar(str:String):String{
			var id1:Number=0;
			var id2:Number=0;
			var id2b:Number=0;
			var id3:Number=0;
			var id3a:Number=0;
			var id3b:Number=0;
			var id3c:Number=0;
			var id4:Number=0;
			var back:String="";
			id1=str.indexOf("var ",0);
			id2=str.indexOf(":",0);
			id2b=str.indexOf(" ",id2);
			id3=str.indexOf("=",id2);
			id4=str.indexOf(";",id2);
			if(id1<0)id1=-4;
			if(id2<0)adderr("transvar missed : at\n"+str);
			if(id4<0)id4=str.length;
			if(id3<0) id3=id4;
			if((id2b>=0)&&(id2b<id3))id3=id2b;
			var type:String=str.substring(id2+1,id3);
			
			var varname:String=str.substring(id1+4,id2)
			var number:String="";	
			var equivalent:String=str.substring(id3,id4);	
			switch(type){
				case 'Array':
					if(id3!=id4){
						id3a=str.indexOf(".",id3);
						id3b=str.indexOf("(",id3a);
						id3c=str.indexOf(")",id3b);
						if(id3a<0)adderr("transvar missed array. at\n"+str);
						if(id3c<0)adderr("transvar array missed ) at\n"+str);
						if(id3b<0)adderr("transvar array missed ( at\n"+str);
						if((id3c>=0)&&(id3b>=0)) number="["+str.substring(id3b+1,id3c)+"]";
						if(id3c==id3b+1) number="[100]";
						type=str.substring(id3a+1,id3b);
					}else{
						type="int";
						number="[100]";
					}
					equivalent="";
					break;	
			}
			
			back+=type+" "+varname+number+equivalent;
			if(id4!=str.length)back+=";";
			return back;
		}
		/**
		 * 
		 * @param str string parameter of function
		 * @return translated string
		 * 
		 */
		private function transfunctioninput(str:String):String{
			var k:Number=0;
			var id:Number=0;
			var back:String="";
			do {
				id=str.indexOf(",",k);
				if(id==-1)id=str.length;
				var param:String= transvar(str.substring(k,id));
				back+=param;
				if(id!=str.length)back+=",";
				k=id+1;
			}while(id<str.length);
			return back;
		}
		/**
		 * Translate decalaration of function 
		 * @param str string stores declaration
		 * @return translated string
		 * 
		 */
		private function transfunction(str:String):String{
			var id1:Number=0;
			var id2:Number=0;
			var id3:Number=0;
			var id4:Number=0;
			var back:String="";
			id1=str.indexOf("function ",0);
			id2=str.indexOf("(",0);
			id3=str.indexOf(")",0);
			id4=str.indexOf("{",0);
			if(id1<0)adderr("transfunction missed function at\n"+str );
			if(id2<0)adderr("transfunction missed ( at\n"+str);
			if(id3<0)adderr("transfunction missed ) at\n"+str);
			back+=str.substring(id3+2,id4)+str.substring(id1+8,id2)+"("+transfunctioninput(str.substring(id2+1,id3))+"){";
			return back;
		}
		////main function
		
		/**
		 * Translate a row
		 * @param str input row
		 * @return translated row
		 * 
		 */
		private function transrow(str:String):String{
			var id:Number=0;
			var id2:Number=0;
			id=str.indexOf("function ",0);
			if(id>=0){
				id2=str.indexOf("{");
				str=replace(str,transfunction( str.substring(id,id2+1)),id,id2);
			}
			id=str.indexOf("var ",0);
			if(id>=0){
				id2=str.indexOf(";");
				str=replace(str,transvar( str.substring(id,id2+1)),id,id2);
			}
			return str;
		}
		
		/**
		 * Translater structure of source
		 * @param str source after global translater
		 * @return translation
		 * 
		 */
		private function structureTranslate(str:String):String{
			var k:Number=0;
			var id:Number=0;
			var i:Number=0;
			var back:String="";
			do {
				id=str.indexOf("\n",k);
				if(id==-1)id=str.length;
				back+=transrow( str.substring(k,id+1) ) ;
				k=id+1;
			}while(id<str.length);
			return back;
		}
		private function addownrule():void{
			addrule('public ');
			addrule('private ');
			addrule('static ');
			addrule("class ");
			addrule("'",'"');
			addrule("Number","float");
			addrule("Boolean","bool");
			addrule("//<C>","");
			addrule("<C>","*/");
			addrule("</C>","/*");
			addrule("//<AS3>","/*<AS3>");
			addrule("//</AS3>","<AS3>*/");
		}
		/**
		 * Translater source code from AS3 to C 
		 * @return translation
		 * 
		 */
		override public function translate():String{
			addownrule();
			var translation:String=globalTranslate(source);
			translation=structureTranslate(translation);
			return translation;
		}
	}
}