package logger
{
	/**
	 * Class ErrorLog: Store, Catch and Demonstrated errors <p>
	 * GUIDE: Folow this example to use ErrorLog for catching errors<p>
	 * <code>
	 * var log:ErrorLog = new ErrorLog();<p>
	 * {log.ccp();<p>
	 * someFunction(a,b,c,log); <p>
	 * if(log.check()){code Error Case }else....
	 * </code>
	 * @author TVA-Created 10/25/2010
	 * @see Logger
	 */
	public class ErrorLog extends Logger
	{
		/**
		 * Create a Error Log 
		 * @param autoC true will create a check point right after now
		 * @param xpdate print date Event
		 * @param xpcreated print Created Event
		 * 
		 */
		public function ErrorLog(autoC:Boolean=true,xpdate:Boolean=false,xpcreated:Boolean=false)
		{
			super(xpdate,xpcreated);
			if(autoC)lcp.push(1);
		}
		/**
		 *List of check point
		 * @see ccp()
		 * @see check() 
		 */
		protected var lcp:Array=new Array();
		/**
		 * Check whether 1 or many Errors have happend <p>
		 * You must create a check point before check except the first check 
		 * @return 
		 * @see ccp()
		 */
		public function check():Boolean{
			//No check point error
			if(!lcp.length){addlog('You would create a check point before check!');return true};
			//Check for last check point
			if(log.length>lcp.pop())return true;
			return false;
		}
		/**
		 * Create a check point to prepare for a catch error 
		 * @see check
		 */
		public function ccp():void{
			lcp.push(log.length);
		}
	}
}