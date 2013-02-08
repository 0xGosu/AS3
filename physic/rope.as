package physic{
	import physic.material;
	public class rope extends material{
		public var l:Number;
		public var A:mpoint;
		public var B:mpoint;
		public var e:Number=0;
		public function rope(mpA:mpoint,mpB:mpoint,VLl:Number=50){
		A=mpA;
		B=mpB;
		l=VLl;
		update();
		}
		public function action():void{
			if((A===B)||(!A.sys&&!B.sys)){quit();this.parent.removeChild(this);return;}
			update();
			var d:Number=math.distance(A,B)-l;
			if(d<0||d==0)return;
			var vo:vector=new vector();
			vo.create(B,A);
			var vi:vector=new vector(d,0);
			vi.turn(vo.angle);
			if (!A.disable||!A.sys) {
			A.x+=vi.px;
			A.y+=vi.py;
			}else if(!B.disable||!B.sys){
			vi.turn(Math.PI);
			B.x+=vi.px;
			B.y+=vi.py;
			}
			// A
			var alpha:Number=Math.abs(A.v.angle-vo.angle);
			if(alpha>Math.PI)alpha=2*Math.PI-alpha;
			var vx1:Number=A.v.length*Math.cos(alpha);
			// B
			alpha=Math.abs(B.v.angle-vo.angle);
			if(alpha>Math.PI)alpha=2*Math.PI-alpha;
			var vx2:Number=B.v.length*Math.cos(alpha);
			//if(vx1>=vx2)return;
			// minus
			A.v.minus(vector.turn(new vector(vx1,0),vo.angle));
			B.v.minus(vector.turn(new vector(vx2,0),vo.angle));
			// simulation impact
			
			//rope kieu? he vat.
			var vx:Number=Math.sqrt( (A.m*vx1*vx1+B.m*vx2*vx2)/(A.m+B.m) );
			
			/* rope kieu? va cham.
			var ttl:Number=A.m+B.m;
			var dfr:Number=A.m-B.m;
			var vxn1:Number=(vx1*dfr+2*B.m*vx2)/ttl;
			var vxn2:Number=(-vx2*dfr+2*A.m*vx1)/ttl;*/
			
			// plus
			A.v.plus(vector.turn(new vector(vx,0),vo.angle));
			B.v.plus(vector.turn(new vector(vx,0),vo.angle));
			update();
		}
		public function update():void{
			graphics.clear();
			graphics.lineStyle(8,0x996633);
			graphics.moveTo(A.x-x,A.y-y);
			graphics.lineTo(B.x-x,B.y-y);
		}
	}
}