package physic{
	import physic.material;
	public class spring extends material{
		public var k:Number;
		public var l:Number;
		public var e:Number;
		private var ln:Number;
		public var A:mpoint=new mpoint();
		public var B:mpoint=new mpoint();
		public function spring(inpa:mpoint,inpb:mpoint,inpk:Number=1,inpl:Number=100){
			A=inpa;
			B=inpb;
			k=inpk;
			l=inpl;
			update();
		}
		public function action():void{
			if((A===B)||(!A.sys&&!B.sys)){quit();this.parent.removeChild(this);return;}
			ln=math.distance(A,B);
			var fdh:vector=new vector(Math.abs(ln-l)*k,0);
			e=math.square(ln-l)*k/2;
			fdh.turn(vector.create(A,B).angle);
			if(ln<l){
				A.f.plus(fdh);
				fdh.turn(Math.PI);
				B.f.plus(fdh);
			}
			if(ln>l){
				B.f.plus(fdh);
				fdh.turn(Math.PI);
				A.f.plus(fdh);
			}
			update();
		}
		public function update():void{
			graphics.clear();
			var lst:Number=20*l/ln;
			if(lst<5)lst=5;
			if(lst>30)lst=30;
			graphics.lineStyle(lst,0x000066);
			graphics.moveTo(A.x-x,A.y-y);
			graphics.lineTo(B.x-x,B.y-y);
		}
	}
}
