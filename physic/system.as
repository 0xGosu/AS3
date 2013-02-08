package physic{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class system extends Sprite {
		public var spread:Number=200;
		public var length:Number=200;
		public var wall:Boolean=false;
		public var gravi:Boolean=false;
		public var g:Number=9.81;
		public var fric:Boolean=false;
		public var n:Number=0.98;
		public var p:vector=new vector(0,1);
		public var time:Timer=new Timer(50);
		public var leq:Array=new Array();
		public var lmp:Array=new Array();
		public var checke:Boolean=false;
		public function get scale():Number {
			return time.delay / 1000;
		}
		public function add(obj):void {
			if (obj=="[object mpoint]") {
				obj.sys=this;
				lmp.push(obj);
			} else {
				obj.sys=this;
				leq.push(obj);
			}
		}
		public function remove(obj):void {
			if (obj.sys==this) {
				if (obj=="[object mpoint]") {
					obj.f.clear();obj.v.clear();
					lmp.splice(lmp.indexOf(obj),1);
					obj.sys=null;
				} else {
					leq.splice(leq.indexOf(obj),1);
					obj.sys=null;
				}
			}
		}
		public function start():void {
			time.start();
		}
		public function stop():void {
			time.stop();
		}
		public function system(vldelay:Number=50,vlwall:Boolean=false,vlgravi:Boolean=false,vlfric:Boolean=false):void {
			gravi=vlgravi;
			wall=vlwall;
			fric=vlfric;
			time.delay=vldelay;
			time.addEventListener(TimerEvent.TIMER, action);
		}
		private function impactwall(mp:mpoint):void {
			if (!wall) {
				return;
			}
			var xx:Number=(mp.x-x);
			var yy:Number=(mp.y-y);
			if (xx-mp.size<0) {
				mp.x=mp.size+x;
				mp.v.px=Math.abs(mp.v.px);
				return;
			}
			if (xx+mp.size>length) {
				mp.x=length-mp.size+x;
				mp.v.px=-Math.abs(mp.v.px);
				return;
			}
			if (yy-mp.size<0) {
				mp.y=mp.size+y;
				mp.v.py=Math.abs(mp.v.py);
				return;
			}
			if (yy+mp.size>spread) {
				mp.y=spread-mp.size+y;
				mp.v.py=-Math.abs(mp.v.py);
				return;
			}
		}
		public function impact(mp1:mpoint,mp2:mpoint):void {
			if(mp1.untouchable||mp2.untouchable)return;
			var vo:vector;
			if (math.distance(mp1,mp2)>mp1.size+mp2.size) return;
			vo=new vector(mp1.size+mp2.size,0);
			//////////////////////
			if (!mp1.disable) {
				vo.turn(vector.create(mp1,mp2).angle);
				mp1.x=mp2.x+vo.px;
				mp1.y=mp2.y+vo.py;
			} else if(!mp2.disable) { 
				vo.turn(vector.create(mp2,mp1).angle);
				mp2.x=mp1.x+vo.px;
				mp2.y=mp1.y+vo.py;
			}
			///////////////
			vo.create(mp2,mp1);
			// mp1
			var alpha:Number=Math.abs(mp1.v.angle-vo.angle);
			if (alpha>Math.PI) {
				alpha=2*Math.PI-alpha;
			}
			var vx1:Number=mp1.v.length*Math.cos(alpha);
			// mp2
			alpha=Math.abs(mp2.v.angle-vo.angle);
			if (alpha>Math.PI) {
				alpha=2*Math.PI-alpha;
			}
			var vx2:Number=mp2.v.length*Math.cos(alpha);
			// minus
			mp1.v.minus(vector.turn(new vector(vx1,0),vo.angle));
			mp2.v.minus(vector.turn(new vector(vx2,0),vo.angle));
			// simulation impact
			var ttl:Number=mp1.m+mp2.m;
			var dfr:Number=mp1.m-mp2.m;
			var vxn1:Number=(vx1*dfr+2*mp2.m*vx2)/ttl;
			var vxn2:Number=(-vx2*dfr+2*mp1.m*vx1)/ttl;
			// plus
			mp1.v.plus(vector.turn(new vector(vxn1,0),vo.angle));
			mp2.v.plus(vector.turn(new vector(vxn2,0),vo.angle));
			////////////////////// Special Action
			mp1.sAction(mp2);
			if(mp2.sys==null||mp1.sys==null)return;
			mp2.sAction(mp1);
		}
		private function gravitational(mp:mpoint):void {
				mp.f.plus(vector.turn(new vector(mp.m*g,0),p.angle));
		}
		private function friction(mp:mpoint):void{
				if(mp.v.length==0)return;
				var angle:Number=mp.v.angle;
				mp.v.minus(vector.turn(new vector(n*100*scale/mp.m,0),angle));
				if((mp.v.angle==angle-Math.PI)||(mp.v.angle==angle+Math.PI)||(mp.v.length<2*scale))mp.v.clear();
		}
		private function action(event:TimerEvent):void {
			var i,j:Number;
			var mp:mpoint;
			for (i=0; i<lmp.length; i++) {
				mp=lmp[i]; 
				if(!lmp[i].disable)mp.action();
				impactwall(mp);
				for (j=i+1; j<lmp.length; j++) {
					impact(mp,lmp[j]);
				}
				if (gravi) gravitational(mp);
				if (fric) friction(mp);
			}
			for (i=0; i<leq.length; i++) {
				leq[i].action();
			}
			event.updateAfterEvent();
			if (checke&&!(time.currentCount%Math.round(1000/time.delay))) {
				energy();
			}
		}
		public function energy():void {
			var e:Number=0;
			for (var i:Number=0; i<lmp.length; i++) {
				e+=lmp[i].e;
			}
			for (i=0; i<leq.length; i++) {
				e+=leq[i].e;
			}
			trace(math.xround(e,1000));
		}
		public function update():void {
			graphics.clear();
			graphics.lineStyle(5,0x000000);
			graphics.moveTo(-3,-3);
			graphics.lineTo(-3,spread+3);
			graphics.lineTo(length+3,spread+3);
			graphics.lineTo(length+3,-3);
			graphics.lineTo(-3,-3);
		}
	}
}