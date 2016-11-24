package  {
	import flash.display.*;
	
	public class ParticleSystem extends MovieClip{
		private var maxParticles:int = 30;
		private var particles:Array;
		private var particle:Particle;
		private var world:Space_shooter;
		private var position:Vector2;
		
		public function ParticleSystem(_world, posX, posY) {
			// constructor code
			this.x = posX;
			this.y = posY;
			world = _world;
			position = new Vector2(this.x, this.y);
			particles = new Array();
			particles[maxParticles];
			setupParticles();
			
		}
		/**
		*Intialize particles
		**/
		public function setupParticles(){
			for(var i:int = 0; i < maxParticles; i++){
				particles[i] = new Particle(world, this.x, this.y);
				particles.push(particles[i]);
			}
		}
		/**
		*Movement update
		**/
		public function updateParticle(){
			for(var i:int = 0; i < maxParticles; i++){
				var p:Particle = particles[i];
				p.updateSelf();
				p.displaySelf();
				if(p.isDead()){
					p.killSelf();
				}
			}
		}
		/**
		*Give the position
		**/
		public function givePosition():Vector2{
			return position;
		}	
		/**
		*Give the particles in array
		**/
		public function getParticles():Array{
			return particles;
		}
	}	
}
