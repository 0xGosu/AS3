package physic{
	import physic.material;
	public class force extends material{
		public var o:mpoint;
		public var f:vector;
		public function force(VLmp:mpoint,VLpx:Number=0,VLpy:Number=0){
		o=VLmp;
		f=new vector(VLpx,VLpy);
		}
		public function action():void{
			o.f.plus(f);
		}
	}
}