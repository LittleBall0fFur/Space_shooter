package  {
	
	public class Vector2 {
		public var x:Number;
		public var y:Number;
		
		public function Vector2(_x:Number = 0, _y:Number = 0) {
			// constructor code
			x = _x;
			y = _y
		}
		public function addS(other){
			y = y + other.y;
			x = x + other.x;
		}
		public function sub(other:Vector2){
			y = y - other.y;
			x = x - other.x;
		}
		public function subS(n:Number){
			y = y - n;
			x = x - n;
		}
		
		//magnitude
		public function mag():Number{
			return Math.sqrt(x*x + y*y);
		}
		public function normalize():void{
			var e:Number = mag();
			if(e != 0){
				divS(e);
			}
		}
		public function divS(s:Number){
			x/= s;
			y/= s;
		}
		public function limit(max:Number):void{
			if(mag() > max){
				normalize();
				multS(max);
			}
		}
		public function multS(s:Number){
			x*= s;
			y*= s;
		}
		public static function distancePoints(a:Vector2, b:Vector2):Number{
			var _x:Number = a.x - b.x;
			var _y:Number = a.y - b.y;
			return Math.sqrt((_x * _x) + (_y * _y));
		}
		public static function moveTowards(start:Vector2, target:Vector2,speed:int):Vector2{
			var _x:Number = start.x - target.x;
			var _y:Number = start.y - target.y;
			var c = Vector2.distancePoints(start, target);
			return new Vector2(speed * _x / c, speed * _y / c);
		}
		public static function returnSub(a:Vector2, b:Vector2):Vector2{
			return new Vector2(a.x - b.x, a.y - b.y);
		}
		public function copy(){
			var v:Vector2 = new Vector2(x,y);
			return v;
		}
		public function create(from:Vector2, to:Vector2){
			x = from.x - to.x;
			y = from.y - to.y;
		}
		
		public static function getAngle2(from:Vector2, to:Vector2):Number{
			var verticalDiffrence:Number = to.y - from.y;
			var horizontalDiffrence:Number = to.x - from.x;
			var radians:Number = Math.atan2(verticalDiffrence, horizontalDiffrence);
			return radians;
		}
		
		public function getAngle(){
			var radians:Number = Math.atan2(y,x);
			var degrees:Number = radians * 180 / Math.PI;
			return degrees;
		}
	}
}
