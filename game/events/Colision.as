package game.events 
{
	import flash.events.Event;
	
	/**
	 * Catch colid between two subject
	 * @author HD.TVA
	 */
	public class Colision extends Event 
	{
		
		public function Colision(subj:Object,obj:Object,type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			subject = subj;
			object = obj;
			super(type, bubbles, cancelable);
			
		}
		public var subject:Object;
		public var object:Object;
	}

}