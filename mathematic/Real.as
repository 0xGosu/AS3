package mathematic
{
	import string.Pstring;
	public class Real
	{
		public function Real(xn:*=0)
		{
			n=Number(xn);
		}
		public var n:Number=0;
		public function valueOf():Number{ 
			return n;
		}
		public function toString():String{
			return String(n);
		}
		public function toNumber():Number{
			return Number(n);
		}
		
		//// Short Static Methods
		/**
		 * Relation Equal<p>
		 * Check a=b (a,b are Real)
		 * @param b
		 * @return 
		 * 
		 */
		public function equal(b:*):Boolean{
			if(b is Number)return Real.equal(this,new Real(b));
			if(b is Real)return Real.equal(this,b);
			//Nsystem.log.addlog("Unable to check the relationship of Real with "+Pstring.className(b));
			return b.equal(this);
		}
		public function smaller(b:*):Boolean{
			if(b is Number)return Real.smaller(this,new Real(b));
			if(b is Real)return Real.smaller(this,b);
			Nsystem.log.addlog("Unable to check the relationship of Real with "+Pstring.className(b));
			return false;
		}
		public function plus(b:*):*{
			if(b is Number)return Real.add(this,new Real(b));
			if(b is Real)return Real.add(this,b);
			return b.plus(this);
		}
		public function multi(b:*):*{
			if(b is Number)return Real.multi(this,new Real(b));
			if(b is Real)return Real.multi(this,b);
			return b.multi(this);
		}
		public function nega():Real{
			return Real.negative(this);
		}
		public function inv():*{
			return Real.inverse(this);
		}
		// semi operator 
		public function minus(b:*):*{
			return this.plus(b.nega());
		}
		public function div(b:*):*{
			return this.multi(b.inv());
		}
		// check special value
		public function checkN():Boolean{
			if(!n&&n!=0)return true;
			return false
		}
		/**
		 * Check whether this is Zero or not
		 * @return 
		 * 
		 */
		public function check0():Boolean{
			if(n==0)return true;
			return false;
		}
		/**
		 * Check whether this is Infinity or not 
		 * @return 
		 * 
		 */
		public function checkI():Boolean{
			if(n==Infinity)return true;
			return false;
		}
		public function format():Real{
			return this;
		}
		////////////// Static //////////
		// Relations
		public static function equal(a:Real,b:Real):Boolean{
			if(a.n==b.n)return true;
			return false;
		}
		public static function smaller(a:Real,b:Real):Boolean{
			if(a.n<b.n)return true;
			return false;
		}
		// Operators
		public static function add(a:Real,b:Real):Real{
			return new Real(a.n+b.n);
		}
		public static function multi(a:Real,b:Real):Real{
			return new Real(a.n*b.n);
		}
		// Identities
		public static const z:Real = new Real(0);
		public static const e:Real = new Real(1);
		public static const NaN:Real = new Real(NaN);
		public static const inf:Real = new Real(Infinity);
		// Inverses
		public static function negative(a:Real):Real{
			return new Real(-a.n);
		}
		public static function inverse(a:Real):*{
			return new Rational(1,a);
		}
	}
}
/*
"Tôi nghe nói công chúa vàng là hoàn toàn say mê với các hoàng tử xanh ..."
"Bạn có biết bây giờ ....?"
"Vâng, cha ...."
"Ah .... Tôi xin lỗi ..."
Một thời gian trước đây ở những nơi,
Trên một đất nước hỗn loạn
Có ai biết giá trị của hòa bình 1 thời đã qua
Một cô gái tóc xanh lá ở thị trấn
Hy vọng có thể làm điều gì đó cho cuộc sống ...
	Cho hòa bình, tôi nói với bản thân mình-
		Để kết thúc cái ác. Tôi sẽ hành động
Và cho cả những người đã hy sinh vì quốc gia.
	Nếu có 1 vị hoàng tử xanh ẩn danh
Đến với thị trấn này,
Tôi sẽ giả vờ tiếp cận anh ta và
Với 1 nụ cười (dù) không từ trái tim
"Oh, rất vui được làm quen?"
Đóa hoa ác quỷ
Nở rộ điềm tĩnh
Được tô điểm bởi sự chết chóc
	những tham vọng đáng thương xung quanh,
Oh, mục nát ra trở thành một nền tảng.
	Bỗng dưng gặp 1 tên hầu trong thị trấn ...
		Với khuôn mặt buồn cười đến mức có thể tự chế giễu.
			Cả 2 như lại được sống tạm thời,
2 trái tim đang lặng lẽ thu hút lẫn nhau.
"Lần đầu tiên 1 nụ cười xuất phát từ trái tim tôi"
Tất cả các như viết nên câu truyện.
	Khi cả hai biết hoàn cảnh của họ,
Thì bao nhiêu giây sau họ sẽ tuyệt vọng?
	Nắm trái tim của hoàng tử trong tay nhưng bây giờ
Một cốt truyện như trò đùa của sự hòa hợp ko lường trước,
"Bị xử tử bởi lệnh công chúa", sau đó tất cả mọi thứ trong
Màn kịch bây giờ đã lên đến đỉnh điểm
"Nhanh .... Hãy kết thúc đi ..."
Đóa hoa ác quỷ
Nở rộ rực rỡ
Trong sự chết chóc buồn.
	Và kết quả của đóa hoa là
Oh, giá treo cổ chỉ ngay đó
Một buổi tối anh đến
(Với) nụ cười giả tạo nén nước mắt ...
	Giả vờ như không nhận thấy đã có một nụ cười (lại)
Tôi hy vọng tôi có thể chết mỉm cười với người cuối cùng (thời điểm đó).
	Lúc nửa đêm, bị mang tới chỗ cái giếng.
		Nhìn anh không nói một lời
Có cơ hội này để (yêu anh dù nó ngắn)
Tôi cảm ơn anh với cả trái tim.
	Cuối cùng 1 nhát dao,
Bàn tay anh run rẩy và sững sờ .... bàn tay đó của anh,
Tôi đặt tôi lên tay anh như tiếp thêm sức cho anh
Đẩy (con dao) về phía tôi.
"... Cảm ơn anh."
Đóa hoa ác quỷ,
Nở rộ rực rỡ
Trong sự chết chóc thân yêu.
	Trong sự trở lại của cuộc đời mình,
Oh, dấu hiệu của chiến tranh đã giảm nhanh chóng.
	Một thời gian trước đây ở một số nơi,
Trong một vương quốc thối nát đến cực điểm,
Một cuộc cách mạng của những người thất vọng quốc gia ...
	Một cô gái thành phố đã trở thành sự hy sinh cho điều đó.
		Vàng và Xanh đã chiến đấu và
	Và chị cả Đỏ sẽ dẫn dắt người dân.
		Tôi sinh ra, chỉ vì nó
	Câu truyện mà tôi sống.
		Cuối cùng cũng kết thúc.
			Tôi muốn Anh giết tôi.
				Câu truyện chỉ ra rằng
	Sự ích kỷ cần thiết của tôi.
	"Ah ... tôi xin lỗi ..."
	Đóa hoa ác Quỷ
	Tán sắc rực rỡ 
	Vô cùng sống động.
		Người dân ngày đó đều không biết,
	Về một cô gái thành phố người đã hy sinh vì họ.
*/