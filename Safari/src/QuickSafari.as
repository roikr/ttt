package {

	/**
	 * @author roikr
	 */
	public class QuickSafari extends QuickGameManager {
		public function QuickSafari() {
			super();
			SoundManager.setTestChatpetz(false)
			SoundManager.mainChatpet="PIFF";
			SoundManager.playMainChatpetBeep(this);
			new BeepsImporter();
			test(new Safari());
			
			
		}
	}
}
