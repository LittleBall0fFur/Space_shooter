package  {
	import flash.display.*;
	import flash.geom.*;
	
	public class Particle {
		private var position:Vector2;
		
		private var speed = 80;
		
		private var world:Space_shooter;
		
		private var particle:Shape;
		private var lifeSpan:Number = 1.0;

		public function Particle(_world, posX, posY) {
			// constructor code
			particle = new Shape();
			position = new Vector2(posX, posY);
			world = _world;
		}
		/**
		*Update movement
		**/
		public function updateSelf(){
			var angle:Number = randomAngle(0,360) * Math.PI / 180;
			particle.x = position.x - speed * Math.cos(angle);
			particle.y = position.y - speed * Math.sin(angle);
			lifeSpan -= 0.05;
			particle.alpha = lifeSpan;
			
		}
		/**
		*Give the particle color and form
		**/
		public function displaySelf(){
			particle.graphics.beginFill(0xFFFF00,1);
			particle.graphics.drawCircle(5,5,5);
			var my_color:ColorTransform = new ColorTransform();
			world.stage.addChild(particle);
		}
		/**
		*Create a random dergrees
		**/
		private function randomAngle(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		/**
		*Check if the lifespan is over
		**/
		public function isDead():Boolean{
			if(lifeSpan <= 0.0){
				return true;
			}
			else return false;
		}
		/**
		*Remove self
		**/
		public function killSelf(){
			world.stage.removeChild(particle);
		}
	}
}
