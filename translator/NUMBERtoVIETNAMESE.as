package translator
{
	public class NUMBERtoVIETNAMESE extends Translator
	{
		public function NUMBERtoVIETNAMESE(psource:String)
		{
			super(psource);
		}
		override public function translate():String
		{
			//add rules
			this.addrule(" ","");
			this.addrule(",","");
			//global
			var s:String=this.globalTranslate(this.source);
			return many2(s);
		}
		public var trans:String;
		//0: accept 0
		//1: not accept 0
		//2: special 1
		
		public function one(n:int,t:int=0):String{
			switch(n){
				case 0:if(t)return "";else return 'không';break;
				case 1:if(t==2)return 'mốt';else return 'một';break;
				case 2:return 'hai';break;
				case 3:return 'ba';break;
				case 4:return 'bốn';break;
				case 5:return 'năm';break;
				case 6:return 'sáu';break;
				case 7:return 'bảy';break;
				case 8:return 'tám';break;
				case 9:return 'chín';break;	
			}
			return 'smthingwrong';
		}
		public function two(n:int):String{
			var n1:int=n%10;
			var n2:int=n-n1;
			if(n2==10)return "mười "+one(n1,1);
			else return one(n2/10)+ " mươi "+one(n1,2); 
		}
		public function three(n:int,t:int=0):String{
			var n12:int=n%100;
			var n3:int=n-n12;
			var p12:String="";
			var p3:String="";
			p3=one(n3/100)+" trăm";
			if(n12){
				if(n12<10)p12="lẻ "+one(n12,1);
				else p12=two(n12);
			}
			return p3+" "+p12;
		}
		public function split(n:String):Array{
			
			
			var ar:Array=new Array();
			for(var i:int=0;i<n.length;i+=3){
				var k:int=Number(n.substring(n.length-i-3,n.length-i) );
				ar.push(k);
			}
			return ar;
		}
		public var arc:Array=new Array("","ngàn","triệu");
		public function many(n:String):String{
			var s:String="";
			var t:int=0;
			var arn:Array=split(n);
			for(var i:int=arn.length-1;i>=0;i--){
				if(i<arn.length-1)t=1;
				if(arn[i]==0){if(arn.length==1)return "không";}
				else if(arn[i]<10){ 
					if(t)s+="không trăm lẻ ";
					s+=one(arn[i]);
				}else{
					// u may add "ko tram" here
					if(arn[i]<100)s+=two(arn[i]);
					else s+=three(arn[i]);
				}
				if(arn[i])s+=" "+arc[i]+" ";
			}
			return s;
		}
		public function split2(n:String):Array{
			
			
			var ar:Array=new Array();
			for(var i:int=0;i<n.length;i+=9){
				var k:int=Number(n.substring(n.length-i-9,n.length-i) );
				ar.push(k);
			}
			for(i=ar.length-1;i>=0;i--){
				if(ar[i]==0)ar.pop();
				else break;
			}
			return ar;
		}
		public function many2(n:String):String{
			var s:String="";
			var t:int=0;
			var arn2:Array=split2(n);
			for(var i:int=arn2.length-1;i>=0;i--){
				if(arn2[i])s+=many(String(arn2[i]));
				if(i>0)s+="tỷ ";
			}
			return s;
		}
	}
}