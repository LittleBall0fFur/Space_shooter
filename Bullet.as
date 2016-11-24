package  {
	
	import flash.display.MovieClip;
	import flash.geom.Vector3D;
	
	
	public class Bullet extends MovieClip {
		private var speed:Number = 50;
		private var position:Vector2;
		private var mouse:Vector2;
		private var dir:Vector2;
		//Flag
		private var hasSpawned;
		
		
		public function Bullet() {
			//Intitialize varibles
			dir = new Vector2();
			position = new Vector2();
			hasSpawned = false;
		}
		/**
		*Give the player the mouse position
		**/
		public function getMousePosition(msX, msY){
			mouse = new Vector2(msX, msY);
		}
		/**
		*Set the flag
		**/
		public function setHasSpawned(value){
			hasSpawned = value;
		}
		/**
		*Bullet Movement
		**/
		public function moveBullet(){
			position = new Vector2(this.x, this.y);
			if(hasSpawned){
				dir.create(position, mouse);
				this.rotation = dir.getAngle();
				hasSpawned = false;
			}
			var angle:Number = this.rotation * Math.PI / 180;
			this.x = this.x - speed * Math.cos(angle);
			this.y = this.y - speed * Math.sin(angle);

		}

	}
	
}
