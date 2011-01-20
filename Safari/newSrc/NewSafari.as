package {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	/**
	 * @author roikr
	 */
	public class NewSafari extends Sprite {
		
		private var background:Sprite;
		private var near:Layer;
		private var river:Layer;
		
		private var currentAnimal:MovieClip;
		private var blinkTimer:Timer;
		
		private static const STATE_IDLE : int = 0;
		private static const STATE_CALLED : int = 1;
		private static const STATE_ANIMATING : int = 2;
		private static const STATE_BLINKING : int = 3;
		private static const STATE_SHOOTED : int = 4;
		
		
		
		private var state : int;
		private var animalDistance : Number;
		
		private var camera : Camera;
		
		private var interfaceBar:Interface;
		private var instruction:Instruction;
		private var photoBitmap:Bitmap;
		
		private var feedback:Feedback;
		private var feedbackTimer:Timer;
		
		private var bPlaying:Boolean;
		private var _lifes : Sprite;
		
		private var tuner:GameTuner;
		
		
		public function NewSafari() {
			
			tuner = GameTuner.getInstance();
			tuner.load(this);
			
			SoundManager.setLibrary("SafariSounds");
			//SoundManager.playMusic(SafariSounds.SAFARI_MUSIC);
			
			addChild(background=new Sprite());
			background.addChild(new Layer("SkyLayerMC",0,0));
			background.addChild(new Layer("MountainsLayerMC",127,0));
			background.addChild(new Layer("FarLayerMC",20,1*1.5,true));
			background.addChild(new Layer("MiddleLayerMC",240,2*1.5));
			background.addChild(near = new Layer("NearLayerMC",-20,3*1.5,true));
			background.addChild(river = new Layer("RiverLayerMC",470,4*1.5,true));
			background.addChild(new Layer("SecondLayerMC",-51,6*1.5));
			background.addChild(new Layer("FirstLayerMC",-51,7*1.5));
			
			
			//addEventListener(Event.ENTER_FRAME,onEnterFrame);
			
			addChild(interfaceBar = new Interface());
			photoBitmap = new Bitmap();
			interfaceBar.photo1.addChild(photoBitmap);
			
			
			
			
			
			velocity = 1.5;
			blinkTimer = new Timer(250);
			blinkTimer.addEventListener(TimerEvent.TIMER,function () : void { currentAnimal.visible = !currentAnimal.visible;});

			state = STATE_IDLE;
			
			camera = new Camera(250,180,1.5);
			
			addChild(camera);
			
			
			
			feedback = new Feedback();
			feedbackTimer = new Timer(1000,1);
			feedbackTimer.addEventListener(TimerEvent.TIMER,function () : void {removeChild(feedback);});
			
			
			
			addChild(_lifes = new Sprite);
			
			
			addChild(instruction = new Instruction());
			instruction.bPlay.addEventListener(MouseEvent.CLICK, onPlay);
			bPlaying = false;
			camera.visible = false;
			
		}
		
		
		
		private function onPlay(e:Event) : void {
			instruction.visible = false;
			lifes = 3;
			bPlaying = true;
			camera.visible = true;
			e.stopImmediatePropagation();
			addEventListener(MouseEvent.CLICK,snapshot);
			GameTuner.getInstance().start();
			
			
		}
		
		private function stop() : void {
			removeEventListener(MouseEvent.CLICK,snapshot);
			bPlaying = false;
			instruction.visible = true;
			camera.visible = false;
		}
		
		public function onClient(obj:Object) : void {
			if	(obj is GameTuner) {
				
				trace(tuner.numSamples);
				trace(tuner.paramValue(SafariParameters.PARAM_SPEED, 0));
				addEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
		}
		
		private function set lifes (numLifes:int) : void {
			var i:int;
			while (_lifes.numChildren) {
				_lifes.removeChildAt(0);
			}
			
			for (i=0;i<numLifes ; i++) {
				var life:LifeMC = new LifeMC;
				life.x = i * life.width;
				_lifes.addChild(life);
			}
		}
		
		private function get lifes () :int {
			return _lifes.numChildren;
		}
		
		private function set velocity(vel:Number) : void {
			for (var i:int = 0; i<background.numChildren;i++ ) {
				(background.getChildAt(i) as Layer).velocity = vel;
			}
		}
		
		private function onEnterFrame(e:Event) : void {
			//trace(GameTuner.getInstance().currentParamValue(SafariParameters.PARAM_SPEED));
			
			var camPos:Point = new Point(stage.mouseX,stage.mouseY);
				camPos = this.globalToLocal(camPos);
				camera.x = camPos.x;
				camera.y = camPos.y;
			
			if (currentAnimal) {
				var p:Point = new Point (currentAnimal.x,currentAnimal.y);
				var animalLayer:Sprite = currentAnimal.parent as Sprite;
				p = animalLayer.localToGlobal(p);
				p = this.globalToLocal(p);
					
				//var beepDistance:int = background.currentLayer.velocity*25* Beep.getDuration(code) / 1000; //  layer velocity [pixel/frame]
				var beepDistance:int = 0;
					
				switch (state) {
					case STATE_IDLE: 
						if (p.x - beepDistance  < 890-150) { 
							currentAnimal.gotoAndPlay("start");
							state = STATE_ANIMATING;
							//SoundManager.playBeep(	code, this)
							//beepState = BEEP_STATE_CALL;
						}
						 
						break;
					case STATE_ANIMATING:
						 if (p.x<300) {
							blinkTimer.start();	 
							state = STATE_BLINKING;
						 }
						 break;
						 
					case STATE_BLINKING:
					 
						 if (p.x<0) {
						 	lifes = lifes - 1;
							blinkTimer.stop();
							currentAnimal = null;
							state = STATE_IDLE;
						}
						break;
					case STATE_SHOOTED :
						if (p.x<0) {
							currentAnimal = null;
							state = STATE_IDLE;
						}
					break;
				}	
			}			
				
			if (!currentAnimal && bPlaying) {
					
				var layer:Layer = Math.random()>0.5 ? near : river;
					
				currentAnimal =  layer.addAnimal();
				//trace(StripHolder.getAnimalCode(currentAnimal))
			} 
			
			if (currentAnimal) {
				
				var marker:Sprite = currentAnimal.mcCenter as Sprite;
				
				if (marker) {
					var p1:Point = marker.localToGlobal(new Point(0,0));
					var p2:Point = camera.localToGlobal(new Point(0,0));
						//trace(p1,p2);
					animalDistance = Point.distance(p1,p2) ;
					
					
				} else {
					animalDistance = 5000;
					trace("couldn't find center");
				}
				
				camera.adjust(animalDistance < 100);
				camera.draw(background);
			}
			
			if (!lifes) {
				stop();
				
			}
		
			
		}
		
		private function snapshot(e:Event) : void {
			
			if (animalDistance < 100) {
				blinkTimer.stop();
				
				if (!currentAnimal.visible) {
					currentAnimal.visible = true;
					camera.draw(background);
				}
				state = STATE_SHOOTED;
				
			}
			
			var photo:Photo = new Photo(camera.snapshot());
			
			photoBitmap.bitmapData =  photo.getBitmapData();
			
			if (animalDistance < 100) {
				
				photo.setMetadata(camera.focus, animalDistance, false);	
				
			}
			
			feedback.gotoAndStop(photo.getFeedbackFrame());
				
			if (photo.isPerfectShot()) {
				//beepState = BEEP_STATE_FEEDBACK;
				//SoundManager.chooseAndPlayBeep(new Array(ChatpetzCodes.SAFARI_GAME_PERFECT_SHOT_1,ChatpetzCodes.SAFARI_GAME_PERFECT_SHOT_2)	, this);
				SoundManager.playSound(SafariSounds.RIGHT_SOUND);	
			}
			
			if (photo.getFeedbackFrame() == 4) {
				SoundManager.playSound(SafariSounds.WRONG1_SOUND);
			}
				
			
			if (feedbackTimer.running) {
				feedbackTimer.reset();
			} else {
				addChild(feedback);
			}
			
			feedbackTimer.start();
			
		}
		
	}
}
