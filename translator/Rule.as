package translator
{
	/**
	 * Class Rule use for define an element of property rule in Translator
	 * @author V.Anh Tran (Last modified: 10/21/2010)
	 * @see Translator
	 */
	public class Rule
	{
		/**
		 * 
		 * @param pori input original
		 * @param ptrans input translation 
		 * 
		 */
		public function Rule(pori:String,ptrans:String='')
		{
			if(pori){
			original=pori;
			translation=ptrans;
			}
		}
		/**
		 *Original 
		 */
		private var original:String;
		/**
		 *Translation 
		 */
		private var translation:String;
		/**
		 * 
		 * @return Orignal
		 * 
		 */
		public function get ori():String{
			return original;
		}
		/**
		 * 
		 * @return Translation
		 * 
		 */
		public function get trans():String{
			return translation;
		}
	}
}