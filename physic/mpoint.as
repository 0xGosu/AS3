package physic{
	import physic.material;
	public class mpoint extends material{
		public var disable:Boolean=false;
		public var untouchable:Boolean=false;
		public var f:vector=new vector(0,0);
		public var v:vector=new vector(0,0);
		private var mass:Number;
		private var kt:Number;
		public var color:Number;
		dynamic function sAction(mp:mpoint):void{
		}
		public function set m(value:Number):void{
			if(!m)mass=1;else mass=value;
		}				
		public function get m():Number{
			if(disable)return 10000000000*math.getsex(mass);else return mass;
		}
		public function set size(value:Number):void{
			kt=value;
			update();
		}
		public function get size():Number{
			return kt;
		}
		public function mpoint(inpmass:Number=1,inpsize:Number=10,inpdb:Boolean=false,VLut:Boolean=false){
			mass=inpmass;
			kt=inpsize;
			disable=inpdb;
			untouchable=VLut;
			update();
		}
		public function action():void{
				v.plus(vector.multi(f,1/m));
				x+=v.px;
				y+=v.py;
			f.clear();
		}
		public function get e():Number{
			if(disable)return 0;
			var delta:line=new line(0,1,-sys.x-sys.spread);
			var E:Number=m*v.square/2;
			if(sys.gravi)E+=m*sys.g*delta.distance(this);
			return E;
		}
		public function update():void{
			graphics.clear();
			graphics.lineStyle(1,color);
			graphics.beginFill(color);
			graphics.drawCircle(0,0,size);
			graphics.endFill();
		}
	}
}