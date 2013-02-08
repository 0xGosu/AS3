package game.interfaces 
{
	import mathematic.Vector2D;
	
	/**
	 * Physic Object'properties
	 * @author HD.TVA
	 */
	public interface PhysicProperties 
	{
		/*mass*/
		function get m():Number;
		function set m(val:Number):void;
		/*vector possition	*/	
		function get p():Vector2D;
		function set p(val:Vector2D):void;
		/*vector velocity*/
		function get v():Vector2D;
		function set v(val:Vector2D):void;
		/*angle (rad)*/
		function get angle():Number;
		function set angle(val:Number):void;
		/*spin (rad/s)*/
		function get spin():Number;
		function set spin(val:Number):void;
		
		/*delta t*/
		function get dt():Number;
		function set dt(val:Number):void;
		/*friction*/
		function get fric():Number;
		function set fric(val:Number):void;
		
	}
	
}