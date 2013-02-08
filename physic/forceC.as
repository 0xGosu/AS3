package physic{
	import physic.material;
	public class forceC extends material{
		public var o:mpoint;
		public var f:vector;
		public var omega:Number;
		public function forceC(VLmp:mpoint,VLpx:Number=0,VLpy:Number=0,VLom:Number=1){
		o=VLmp;
		f=new vector(VLpx,VLpy);
		omega=VLom;
		}
		public function action():void{
			o.f.plus( vector.turn(new vector(f.length*Math.cos(omega*sys.time.currentCount),0),f.angle) );
		}
	}
}
	