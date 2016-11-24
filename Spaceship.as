package  {
	import flash.display.MovieClip;
	
	public class Spaceship extends MovieClip{

		private var health:int;
		private var damage:int;
		public var speed:int = 0;
		private var draft:int;
		
		public function Spaceship() {
			// constructor code
		}
		/**
		*Set the health of the child
		**/
		public function setHealth(_health:int){
			health = _health;
		}
		/**
		*Get the damage from the child
		**/
		public function getDamage():int{
			return damage;
		}
		/**
		*Set the damage of the child
		**/
		public function setDamage(_damage:int){
			damage = _damage;
		}
		/**
		*Get the health from the child
		**/
		public function getHealth():int{
			return health;
		}
		/**
		*Aplly the damage on the childs health
		**/
		public function applyDamage(){
			health = health - 1;
		}
		
	}
	
}
