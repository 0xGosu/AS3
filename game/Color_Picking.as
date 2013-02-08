package game
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import game.object.board;
	import game.object.cell;
	import game.random.Suffle;
	
	import graph.Paint;
	
	import mathematic.Vector2D;
	import mathematic.math;
	
	public class Color_Picking 
	{
		public function Color_Picking(size:Number=400, pcontainer:DisplayObjectContainer=null)
		{
			container=pcontainer;
			brd=new board(10, 10, size/10, container);
			brd.sprite.addEventListener(MouseEvent.MOUSE_DOWN,mouseHandle);
		}
		public var container:DisplayObjectContainer;
		public var brd:board;
		public function newGame(lv:uint):void{
			brd.clearBoard();
			brd.createBoardNull();
			var startCl:uint=0;var deltaCl:uint=1000;
			switch(lv){
				case 0:startCl=math.random(Math.pow(16,5));deltaCl=Math.pow(15,5);break;
				case 1:startCl=math.random(15*Math.pow(16,5));deltaCl=Math.pow(15,4);break;
				case 2:startCl=math.random(15*Math.pow(16,5)+15*Math.pow(16,4));deltaCl=Math.pow(15,3);break;
				case 3:startCl=math.random(15*Math.pow(16,5)+15*Math.pow(16,4)+15*Math.pow(16,3));deltaCl=Math.pow(15,2);break;
				case 4:startCl=math.random(15*Math.pow(16,5)+15*Math.pow(16,4)+15*Math.pow(16,3)+15*Math.pow(16,2));deltaCl=50;break;
				case 5:startCl=math.random(15*Math.pow(16,5)+15*Math.pow(16,4)+15*Math.pow(16,3)+15*Math.pow(16,2)+15);deltaCl=15;break;				
			}
			for(var i:int=0;i<8;i++)
				for(var j:int=0;j<8;j++){
					// 2D to 1D
					var t:Number=(i*brd.width+j);
					// div int for 4
					t=(t-t%4)/4;
					// calculate cl
					var cl:uint=startCl+t*deltaCl;
					var nc:cell=new cell(String(cl),brd.sprite,null,brd.cellSize,cl);
					nc.px=brd.cellSize*j;
					nc.py=brd.cellSize*i;
					brd[i][j].selfRemove();
					brd[i][j]=nc;
				}
			Suffle.squareArray(brd,8,8);
			//swap row 0 to 8
			var trans:Array=brd[0];
			brd[0]=brd[8];
			brd[8]=trans;
			//swap colum 0 to 8
			for(i=1;i<9;i++){
				var tr:Object=brd[i][0];
				brd[i][0]=brd[i][8];
				brd[i][8]=tr;
			}
			brd.refreshBoard();
		}
		// 4 direction bound
		protected function leftOf(row:uint,col:uint):int{
			if(brd[row][col+1]&&brd[row][col+1].id=='null')return leftOf(row,col+1);
			else return col+1;
		}
		protected function rightOf(row:uint,col:uint):int{
			if(brd[row][col-1]&&brd[row][col-1].id=='null')return rightOf(row,col-1);
			else return col-1;
		}
		public function downOf(row:uint,col:uint):int{
			if(brd[row-1]&&brd[row-1][col].id=='null')return downOf(row-1,col);
			else return row-1;
		}
		public function upOf(row:uint,col:uint):int{
			if(brd[row+1]&&brd[row+1][col].id=='null')return upOf(row+1,col);
			else return row+1;
		}
		
		public var clickStatus:int=0;
		public var lrow:int=0;
		public var lcol:int=0;
		
		/**
		 *  Drawing Array of point
		 */
		public var darp:Array=new Array();
		/**
		 * Handle mouse
		 * @param px
		 * @param py
		 * @return 
		 * 
		 */
		protected function mouseHandle(evt:MouseEvent):void{trace('Click '+clickStatus);
			var mrow:int=math.divine(evt.stageY,brd.cellSize);
			var mcol:int=math.divine(evt.stageX,brd.cellSize);
			trace("row "+mrow+"|col "+mcol+'|id '+brd[mrow][mcol].id);
			if(mrow<0||mrow>brd.height||mcol<0||mcol>brd.width||brd[mrow][mcol].id=='null')return;
			switch(clickStatus){
				case 0:
					brd.createBasicVisual();
					Paint.circle(brd[mrow][mcol].sprite.graphics,brd.cellSize/2,brd.cellSize/2,5,1,0xffffff,false);
					lrow=mrow;
					lcol=mcol;
					break;
				case 1:
					check2point(mrow,mcol);
					if(darp.length){trace('correct!');
						Paint.drawLine(brd.sprite.graphics,darp,1,0x000000);
						brd[mrow][mcol].selfRemove();
						brd[lrow][lcol].selfRemove();
						//1
						var cellSize:Number=brd.cellSize;
						var nc:cell=new cell('null',brd.sprite);
						nc.createBasicVisual(cellSize,1,1000);
						nc.px=cellSize*mcol;
						nc.py=cellSize*mrow;
						brd[mrow][mcol]=nc;
						//2
						nc=new cell('null',brd.sprite);
						nc.createBasicVisual(cellSize,1,1000);
						nc.px=cellSize*lcol;
						nc.py=cellSize*lrow;
						brd[lrow][lcol]=nc;
					}else
					brd[lrow][lcol].createBasicVisual(brd.cellSize,2,0,true,Number(brd[lrow][lcol].id));
					
					break;
			}
			clickStatus++;
			if(clickStatus==2)clickStatus=0;
			brd.refreshBoard();
		}
		/**
		 * Push a vector possition to array darp 
		 * @param r
		 * @param c
		 * 
		 */
		private function pushCellPoint(r:int,c:int):void{
			var v:Vector2D=new Vector2D(brd.cellSize/2+c*brd.cellSize,brd.cellSize/2+r*brd.cellSize);
			darp.push(v)
		}
		/**
		 * Check 2 point can be linked or not <p>
		 * push the Vector Possition of everypoint on theirlink to array darp via pushCellPoint 
		 * @param r
		 * @param c
		 * 
		 */
		protected function check2point(r:int,c:int):void{
			//new array for new check
			darp=new Array();
			// check incorrect
			if(brd[lrow][lcol].id!=brd[r][c].id||brd[r][c].id=='null'||(r==lrow&&c==lcol))return;
			// check direct link
			if( (lrow==r&& (leftOf(lrow,lcol)==c||rightOf(lrow,lcol)==c) )  
			||  (lcol==c&& (upOf(lrow,lcol)==r||downOf(lrow,lcol)==r) )    )
				{trace('direct link');
				pushCellPoint(lrow,lcol);
				pushCellPoint(r,c);
				return;
			}
			// check intersect
			var a:Vector2D=new Vector2D(lcol,lrow);
			var b:Vector2D=new Vector2D(c,r);
			var check:int=checkIntersect(a,b);
			if(check){
				pushCellPoint(lrow,lcol);
				// intersect at last row and current colum
				if(check==1)pushCellPoint(lrow,c);
				// intersect at current row and last colum
				if(check==2)pushCellPoint(r,lcol);
				pushCellPoint(r,c);
				return;
			}
			//check 2 turn 
			// left 
			for(var i:int=c+1;i<leftOf(r,c);i++){
				b=new Vector2D(i,r);
				check=checkIntersect(a,b);
				if(check){
					pushCellPoint(lrow,lcol);
					if(check==1)pushCellPoint(lrow,i);
					if(check==2)pushCellPoint(r,lcol);
					pushCellPoint(r,i);
					pushCellPoint(r,c);
					return;
				}
			}
			// right 
			for(i=c-1;i>rightOf(r,c);i--){
				b=new Vector2D(i,r);
				check=checkIntersect(a,b);
				if(check){
					pushCellPoint(lrow,lcol);
					if(check==1)pushCellPoint(lrow,i);
					if(check==2)pushCellPoint(r,lcol);
					pushCellPoint(r,i);
					pushCellPoint(r,c);
					return;
				}
			}
			// up 
			for(var j:int=r+1;j<upOf(r,c);j++){
				b=new Vector2D(c,j);
				check=checkIntersect(a,b);
				if(check){
					pushCellPoint(lrow,lcol);
					if(check==1)pushCellPoint(lrow,c);
					if(check==2)pushCellPoint(j,lcol);
					pushCellPoint(j,c);
					pushCellPoint(r,c);
					return;
				}
			}
			// down
			for(j=r-1;j>downOf(r,c);j--){
				b=new Vector2D(c,j);
				check=checkIntersect(a,b);
				if(check){
					pushCellPoint(lrow,lcol);
					if(check==1)pushCellPoint(lrow,c);
					if(check==2)pushCellPoint(j,lcol);
					pushCellPoint(j,c);
					pushCellPoint(r,c);
					return;
				}
			}
		}
		
		/**
		 * Return 0 if 2 point are not intersect <p>
		 * Return 1 if 2 point intersect at BxAy (or row A col B) <p>
		 * Return 2 if 2 point intersect at AxBy (or row B col A)
		 */
		protected function checkIntersect(a:Vector2D,b:Vector2D):int{
			if(rightOf(a.y,a.x)<b.x&&b.x<leftOf(a.y,a.x) && downOf(b.y,b.x)<a.y&&a.y<upOf(b.y,b.x) )return 1;
			if(rightOf(b.y,b.x)<a.x&&a.x<leftOf(b.y,b.x) && downOf(a.y,a.x)<b.y&&b.y<upOf(a.y,a.x) )return 2;
			return 0;
		}
	}
}