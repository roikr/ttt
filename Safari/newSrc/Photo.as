package {
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * @author roikr
	 */
	public class Photo extends Sprite {
		
		private var focus:Number;
		private var distance:int;
		private var data:BitmapData;
		private var bChatpet:Boolean;
		private var score:int;
		private var bAnimal:Boolean;
		private var frame:int;
		
		public function Photo(data:BitmapData) {
			this.data = data;
			bAnimal = false;
			score = 0;
			distance = 5000;
			focus = 0;
			frame = 4;
		}
		
		public function setMetadata(focus:Number,distance:Number,bChatpet:Boolean) : void {
			bAnimal = true;
			this.focus = focus;
			this.distance = distance;
			this.bChatpet = bChatpet;
			 
			score = 50;
			
			if (distance < 20)
				score += 50;
				
			if (focus == 1) 
				score += 50;
				
			//if (bChatpet)
			//	score += 50;
				
			if (focus == 1) {
				frame = distance < 20 ? 1 : 3;
			} else {
				frame = distance < 20 ? 2 : 4;
			}
		}
		
		public function getScore() : int {	
			return score;
		}
		
		public function getFocus() : Number {
			return focus;
		}
		
		public function getDistnace() : int {
			return distance;
		}
		
		public function getFeedbackFrame() : int {
			return frame;
		}
		
		public function hasAnimal() : Boolean {
			return bAnimal;
		}
		
		public function getBitmapData() : BitmapData {
			return data;
		}
		
		public function isPerfectShot() : Boolean {
			return frame == 1;
		}
		
		
		
		
	}
}
