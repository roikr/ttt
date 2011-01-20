package {
	import flash.display.Sprite;

	/**
	 * @author roikr
	 */
	public class BeepTest extends Sprite {
		
		
		
		public function BeepTest() {
			var highBand : HighBand = new HighBand;
			new Beep(ChatpetzCodes.TEST_BEEP,this);
			new RKSound("HIGH_BAND.WAV_000.wav",this,false,false);
		}
		
		public function onSoundComplete(obj:Object) : void {
			trace("sound done");
		}
		
		public function onBeepCompleted(obj:Object) : void {
			trace("beep done");
			
		}
	}
}
