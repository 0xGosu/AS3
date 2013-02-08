package source.translator.programing.classC
{
	/**
	 * Class array name for C language 
	 * @author V.Anh Tran (Last modified: 10/20/2010)
	 * 
	 */
	public class array
	{
		public function array()
		{
		}
		public static function int(n:Number=100):Array{
			var arr:Array=new Array(n);
			var dvalue:Number=0;
			for(var i:Number=0;i<n;i++)arr[i]=dvalue;
			return arr;
		}
		public static function float(n:Number=100):Array{
			var arr:Array=new Array(n);
			var dvalue:Number=0;
			for(var i:Number=0;i<n;i++)arr[i]=dvalue;
			return arr;
		}
		public static function double(n:Number=100):Array{
			var arr:Array=new Array(n);
			var dvalue:Number=0;
			for(var i:Number=0;i<n;i++)arr[i]=dvalue;
			return arr;
		}
		public static function char(n:Number=100):Array{
			var arr:Array=new Array(n);
			var dvalue:String="";
			for(var i:Number=0;i<n;i++)arr[i]=dvalue;
			return arr;
		}
		
	}
}