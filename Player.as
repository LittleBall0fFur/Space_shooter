package {
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.display.Stage;

	public class Player extends Spaceship {

		private var sprite: MovieClip;
		private var world:Space_shooter;
		
		//Movement
		private var up:Boolean = false;
		private var breaks:Boolean = false;
		private var rotateLeft:Boolean = false;
		private var rotateRight:Boolean = false;
		private var shoot:Boolean = false;
		private var propulsion:Boolean;
		private var draft:Number;

		public function Player(_world:Space_shooter) {
			// constructor code
			sprite = new PlayerImg();
			super.setHealth(3);
			speed = 35;
			draft = 0.6;
			world = _world;
			this.x = 1920/2;
			this.y = 1080/2;
			this.addChild(sprite);

			world.stage.addEventListener(KeyboardEvent.KEY_UP, keyCheckUp);
			world.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyCheckDown);
		}
		/**
		*Update all movement in world
		**/
		public function movement() {
			if(world.getTimer() > 120 && world.getTimer() < 125){
				world.stage.addEventListener(MouseEvent.CLICK, mouseLeftDown);
			}
			setRotation();
			moveUp();
			reverse();
			shootTowards();
			boundries();
		}
		/**
		*Check if the player is outside the screen
		*If so teleport player
		**/
		private function boundries(){
			if(this.x > 1920){
				this.x = 0;
			}
			if(this.x < 0){
				this.x = 1920;
			}
			if(this.y > 1080){
				this.y = 0
			}
			if(this.y < 0){
				this.y = 1080;
			}
		}
		/**
		*Rotation
		**/
		private function setRotation(){
			if(rotateLeft)this.rotation -= 10;
			else if(rotateRight)this.rotation += 10;
		}
		/**
		*Give the speed of the player
		**/
		public function getSpeed():int{
			return speed;
		}
		/**
		*Move forward
		**/
		private function moveUp(){
			if(up){
				propulsion = true;
				draft = 0.5	;
				var angle:Number = this.rotation * Math.PI / 180;
				this.x = this.x + speed * Math.cos(angle);
				this.y = this.y + speed * Math.sin(angle);
			}
			else if(world.getPropTimer() != 0){
				var angle2:Number = this.rotation * Math.PI / 180;
				this.x = this.x + world.getPropTimer() * Math.cos(angle2);
				this.y = this.y + world.getPropTimer() * Math.sin(angle2);
			}
		}
		/**
		*Shoot
		**/
		private function shootTowards(){
			if(shoot){
				world.spawnBullet();
			}
			shoot = false;
		}
		/**
		*Breaks
		**/
		private function reverse(){
			if(breaks){
				draft = 2;
			}
		}
		/**
		*Give the draft
		**/
		public function getDraft():Number{
			return draft;
		}
		/**
		*Give the propulsion
		**/
		public function getPropulsion():Boolean{
			return propulsion;
		}
		/**
		*Set the propulsion
		**/
		private function setPropulsion(value:Boolean){
			propulsion = value;
		}
		/**
		*On mouse click shoot
		**/
		private function mouseLeftDown(e:MouseEvent){
			shoot = true;
		}
		/**
		*Check if keycode is not pressed
		**/
		private function keyCheckUp(event: KeyboardEvent): void {
			switch (event.keyCode) {
				case Keyboard.A:
					rotateLeft = false;
					break;

				case Keyboard.D:
					rotateRight = false;
					break;
				
				case Keyboard.W:
					up = false;
					propulsion = false;
					break;
				
				case Keyboard.S:
					breaks = false;
					break;

				default:
					break;
			}
		}
		/**
		*Check if keycode is pressed
		**/
		private function keyCheckDown(event: KeyboardEvent): void {
			switch (event.keyCode) {
				case Keyboard.A:
					rotateLeft = true;
					break;

				case Keyboard.D:
					rotateRight = true;
					break;
				
				case Keyboard.W:
					up = true;
					break;
				
				case Keyboard.S:
					breaks = true;
					break;

				default:
					break;
			}
		}

	}

}