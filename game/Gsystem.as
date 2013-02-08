package game
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 
	 * @author TVA-Created 11/14/2010
	 * 
	 */
	public class Gsystem extends Array
	{
		public function Gsystem(cont:DisplayObjectContainer)
		{
			super();
			container=cont;
		}
		/**
		 * Display Container (where the game system demonstrate) 
		 */
		public var container:DisplayObjectContainer;
		/**
		 * SUI 
		 * @return 
		 * 
		 */
		/*
		public function toString():String{
			var str:String="";
			for(var i:int=0;i<this.length;i++){
				str+="ID "+i+":{"+this[i]+"}\n";
			}
			return str;
		}
		*/
		public function add(ob:Gobject):void{
			ob.sys=this;
			this.push(ob);
		}
		/**
		 * Step action  
		 * 
		 */
		public function step():void{
			for(var i:int=0;i<this.length;i++)this[i].step();
		}
	}
}