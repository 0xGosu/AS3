package translator
{
	import translator.Translator;
	
	/**
	 * Get movie name and year from "list of movie.txt" 
	 * @author TVA
	 * 
	 */
	public class Getmoviename extends Translator
	{
		public function Getmoviename(psource:String,includeYear:Boolean=false)
		{
			super(psource);
			year=includeYear;
		}
		public var year:Boolean=true;
		override public function translate():String{
			//add rules
			this.addrule(" ",".");
			this.addrule("_",".");
			// global
			var trans:String=this.globalTranslate(this.source);
			return "*** Get movie name ***\n"+specialTranslate(trans);
		}		
		public function specialTranslate(str:String):String{
			
			var ar:Array=str.split("\n");
			var s:String="Quatity: "+ar.length+"\n";
			for(var i:int=0;i<ar.length;i++)s+=lineTrans(ar[i])+"\n";
			return s;
		}
		public function lineTrans(str:String):String{
			var s:String=str.substring(1);
			var ar:Array=s.split(".");
			s='';
			for(var i:int=0;i<ar.length;i++){
				if(Number(ar[i])>=1000||ar[i]=='720p'){
					for(var j:int=0;j<i;j++)s+=ar[j]+" ";
					if(year&&ar[i]!='720p')s+="("+ar[i]+")";
					break;
				}
			}
			if(i==ar.length)s="***some thing wrong here***";
			return s;
		}

	}
}