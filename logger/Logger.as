package logger
{
	
	/**
	 * Class logger to store and demonstrate logs!
	 * @author TVA-Created: 10/23/2010-Last modified:11/2/2010
	 * @see LogEvent
	 */
	public class Logger
	{
		/**
		 * Create a logger
		 * @param xpdate true if wanna print date in Event
		 * @param xpcreated true if wanna print Created Event
		 * 
		 */
		public function Logger(Reverse:Boolean=false,xDate:Boolean=false,SelfLog:Boolean=false)
		{
			
			saveReverse=Reverse;
			saveDate = xDate;
			selfLog = SelfLog;
			if (xDate) date = new Date(); else date = null;
			log=new Array();
			if(selfLog)log.push(new LogEvent(date,"Log Created!"));
		}
		/**
		 * Get Date from Computer 
		 */
		protected var date:Date;
		/**
		 * Hold data 
		 */
		public var log:Array;
		/**
		 * Whether save Date in Log Event or not 
		 */
		protected var saveDate:Boolean=false;
		
		/**
		 * Whether save Log in reverse or not 
		 */
		protected var saveReverse:Boolean=false;
		/**
		 * Whether save Log Event about itself or not 
		 */
		protected var selfLog:Boolean=false;
		
		
		
		/**
		 * add a log to logger 
		 * @param str Should be a string
		 * 
		 */
		
		public function addlog(str:*):void{
			if(saveDate)date=new Date(); else date = null;
			if (saveReverse) log.unshift(new LogEvent(date, String));
			else log.push(new LogEvent(date,String(str)));
		}
		public function clearlog():void{
			log=new Array();
			if (saveDate) date = new Date(); else date = null;
			if(selfLog)log.push(new LogEvent(date,"Log Clean!"));
		}
		/**
		 * Return logger as a String with Interface. For example <p>
		 * 1 | Success<p>
		 * 2 | Processing<p>
		 * 3 | Failed<p>
		 * id | Log 
		 * @return String User Interface
		 * 
		 */
		public function toString():String{
			var str:String="";
			for(var i:int=0;i<log.length;i++){
					str+=i+" | ";
					if(log[i].date!=null)str+=String(log[i].date)+":";
					str+=log[i].event+"\n";
				
			}
			return str;
		}
	}
}

/*

*/