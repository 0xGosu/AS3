// calucate 
			var dv:vector=vector.minus(mp1.v,mp2.v);
			var d:vector=new vector(mp1.x-mp2.x,mp1.y-mp2.y);
			var r:Number=mp1.size+mp2.size;
			var a:Number=dv.square;
			var b:Number=2*dv.dot(d);
			var c:Number=d.square-math.square(r);
			var t:Number;var vo:vector=new vector();
			var ch:Boolean=false;
			if(a){
				 var scale:Number=time.delay/1000;
				 var delta:Number=b*b-4*a*c;
				 if(!delta){t=-b/(2*a);if(t<=0&&t>-scale)ch=true;}
				 if(delta>0){
					 var n1:Number=(-b-Math.sqrt(delta))/(2*a);
					 var n2:Number=(-b+Math.sqrt(delta))/(2*a);
					 t=0;
					 if(n1<=t&&n1>-scale){t=n1;ch=true;}
					 if(n2<=t&&n2>-scale){t=n2;ch=true;}
				 }
			if(ch){// result
				mp1.x+=mp1.v.px*t;
				mp1.y+=mp1.v.py*t;
				mp2.x+=mp2.v.px*t;
				mp2.y+=mp2.v.py*t;
			}
			}
			if((d.square<r*r)&&!ch){
				vo=new vector(r,0);
				vo.turn(vector.create(mp1,mp2).angle);
				mp1.x=mp2.x+vo.px;
				mp1.y=mp2.y+vo.py;
				ch=true;
			}
			if(!ch)return;	
			////////////////
			vo.create(mp2,mp1);
			// mp1
			var alpha:Number=Math.abs(mp1.v.angle-vo.angle);
			if(alpha>Math.PI)alpha=2*Math.PI-alpha;
			var vx1:Number=mp1.v.length*Math.cos(alpha);
			mp1.v.minus(vector.turn(new vector(vx1,0),vo.angle));
			// mp2
			alpha=Math.abs(mp2.v.angle-vo.angle);
			if(alpha>Math.PI)alpha=2*Math.PI-alpha;
			var vx2:Number=mp2.v.length*Math.cos(alpha);
			mp2.v.minus(vector.turn(new vector(vx2,0),vo.angle));
			
			// simulation impact
			var ttl:Number=mp1.m+mp2.m;
			var dfr:Number=mp1.m-mp2.m;
			var vxn1:Number=(vx1*dfr+2*mp2.m*vx2)/ttl;
			var vxn2:Number=(-vx2*dfr+2*mp1.m*vx1)/ttl;
			// plus
			mp1.v.plus(vector.turn(new vector(vxn1,0),vo.angle));
			mp2.v.plus(vector.turn(new vector(vxn2,0),vo.angle));
			
	//////////////////////////////////////////////////////////////////////
public function impact(o:mpoint):void{
			if(o.untouchable)return;
			var range:Number=size+o.size;
			if(math.distance(this,o)<range){
				/*
				var dv:line=new line();
				dv.create(o,o.v);
				var i:point=dv.shadow(this);
				var vo:vector=new vector(Math.sqrt(math.square(range)-math.square(math.distance(this,i))),0);
				vo.turn(o.v.angle+Math.PI);
				o.x=i.x+vo.px;
				o.y=i.y+vo.py;
				*/
				/////////////////
				var vo:vector=new vector(range,0);
				vo.turn(vector.create(o,this).angle);
				o.x=x+vo.px;
				o.y=y+vo.py;
				////////////////
				vo.create(o,this);
				// this
				var alpha:Number=Math.abs(v.angle-vo.angle);
				if(alpha>Math.PI)alpha=2*Math.PI-alpha;
				var vx:Number=v.length*Math.cos(alpha);
				v.minus(vector.turn(new vector(vx,0),vo.angle));
				// o
				alpha=Math.abs(o.v.angle-vo.angle);
				if(alpha>Math.PI)alpha=2*Math.PI-alpha;
				var ovx:Number=o.v.length*Math.cos(alpha);
				o.v.minus(vector.turn(new vector(ovx,0),vo.angle));
				// simulation impact
				var vxn:Number=(vx*(m-o.m)+2*o.m*ovx)/(m+o.m);
				var ovxn:Number=(ovx*(o.m-m)+2*m*vx)/(m+o.m);
				// plus
				v.plus(vector.turn(new vector(vxn,0),vo.angle));
				o.v.plus(vector.turn(new vector(ovxn,0),vo.angle));
			}
		}