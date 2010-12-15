package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	/**
	 * @author roikr
	 */
	public class QuickGameManager extends Sprite implements IGameManager{
		
		public var testUI : QuickGameManagerUIAssets;
		public var game:IChatpetzGame;
		
		
		public function QuickGameManager() {
			addChild(testUI=new QuickGameManagerUIAssets());
			testUI.bStart.enabled = false;
			testUI.bClose.enabled = false;
		}
		
		public function test(game:IChatpetzGame) {
			testUI.bStart.enabled = true;
			testUI.bClose.enabled = true;
			testUI.cbSound.selected = true;
		
			testUI.bStart.addEventListener(MouseEvent.MOUSE_DOWN,onStart);
			testUI.bClose.addEventListener(MouseEvent.MOUSE_DOWN,onClose);
			testUI.bHelp.addEventListener(MouseEvent.MOUSE_DOWN,onHelp);
			testUI.cbSound.addEventListener(Event.CHANGE, function() : void {SoundMixer.soundTransform = new SoundTransform(testUI.cbSound.selected ? 1 : 0);} );
			
			
			this.game = game;
			testUI.mcGame.addChild(this.game as Sprite);
		}
		
		public function load(url:String) : void {
		}
		
		public function unload() :void {
			game.exit();
			game = null;
			testUI.bStart.enabled = false;	
			testUI.bClose.enabled = false;	
		}
		
		public function close() : void {
			
		}

		
		
		

		private function onStart(e:Event) : void {
			e.stopImmediatePropagation();
			game.start(this);
			testUI.bStart.enabled = false;	
			testUI.bClose.enabled = true;		
		}
		
		public function onClose(e:Event) : void {
			e.stopImmediatePropagation();
			unload();
			close();
		}
		
		public function onHelp(e:Event) : void {
			e.stopImmediatePropagation();
			game.help();
		}
		
		public function setStars(stars:int) : void {
			testUI.laStars.text = stars.toString();
		}

		public function setScore(score:int) : void {
			testUI.laScore.text = score.toString();
		}
		
		public function setLevel(level:int) : void {
			testUI.laLevel.text = level.toString();
		}
		
		public function setTime(time:int) : void {
			testUI.laTime.text = time.toString();
		}
		
		public function getAvatar() : MovieClip {
			var mc:MovieClip = new MovieClip;
			mc.graphics.beginFill(0x4466AA);
			mc.graphics.drawEllipse(-50, -150, 100, 150);
			return mc
;			
		}
		
		public function onBeepCompleted(obj:Object) : void {
			
		}

	}
}
