package mathematic.solver
{
	/**
	 * Quadratic Equation Solver <p>
	 * Form: ax^2 + bx +c = 0 <p>
	 * Number of Result is given in .root <p>
	 * Result is given in .x1 , .x2 (x1<x2)
	 * @author TVA-Created: 11/20/2010
	 * 
	 */
	public class solveQuadraticEquation
	{
		public function solveQuadraticEquation(a:Number,b:Number,c:Number)
		{
			if(a){
				delta=b*b-4*a*c;
				if(delta>0){
					// 2 root x1=[-b+sqrt(delta) ]/2a; x2=x1=[-b+sqrt(delta) ]/2a
					var dd:Number=Math.sqrt(delta);
					root=2;
					x2=(-b+dd)/(2*a);
					x1=x2-dd/a;
					if(x1>x2){dd=x2;x2=x1;x1=dd;}
				}else{
					// no root
					if(delta<0)root=0;
					else{
					// 1 root
					root=1;
					x1=-b/(2*a);
					}
				}
			}else{// form: bx+c=0;
				if(b){
					// 1 root x=-c/b
					root=1;
					x1=-c/b;
				}
				else{// form c=0;
					if(c)root=0;
					else root=Infinity;
				}
			}
			
			
		}
		public function toString():String{
			var  str:String;
			str="This equation has "+root+" root!";
			if(root==1)str+="\nx1="+x1;
			if(root==2){str+="\nx1="+x1;str+="\nx2="+x2;}
			return str;
		}
		public var root:Number=0;
		public var delta:Number;
		public var x1:Number;
		public var x2:Number;
	}
}