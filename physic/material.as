package physic{
	import flash.display.Sprite;
	public class material extends Sprite{
		public function material(){}
		public var sys:system;
		public function quit():void{
			if(sys==null)return;
			sys.remove(this);
		}
	}
}