package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 * @author roikr
	 */
	public class Camera extends Sprite {
		
		public var cameraMC:CameraMC;
		
		private var data:BitmapData;
		private var zoom:Number;
		private var bitmap:Bitmap;
		private var focusSound:RKSound;
		private var _focus:Number;
		
		//private var animal:Animal;
		//private var lastAnimal:Animal;
		
		
		public function Camera(width:int,height:int,zoom:Number) {
			data = new BitmapData(width,height,false);
			this.zoom = zoom;
		
			bitmap = new Bitmap(data);
			bitmap.x -= bitmap.width/2;
			bitmap.y -= bitmap.height/2;
			addChild(bitmap);
			addChild(cameraMC = new CameraMC);
			
			
			
			
			_focus = 0;
		
			//animal = null;
			//lastAnimal = null;
			
			
		}
		
		
		public function get focus() : Number {
			return _focus;
		}
		
		
		
		public function adjust(bAnimal:Boolean) : void {
			
			
			//if (animal)
			//	animal.startAnimation();
			
			_focus = bAnimal ? _focus + 0.05 : 0;
			
			if (_focus > 0 && _focus < 1) {
				if	(focusSound==null || !focusSound.playing) {
					focusSound = SoundManager.playSound(SafariSounds.CAMERA_FOCUS_SOUND);
				}
			} else {
				if (focusSound!=null && focusSound.playing) {
					focusSound.stop();	
				}
			}
			
			_focus = _focus > 1 ? 1 : _focus;
			
			
		}
		
		public function draw(background:Sprite) : void {
			
			var matrix:Matrix = new Matrix();
			
			var p:Point = new Point(stage.mouseX,stage.mouseY);
			p = parent.globalToLocal(p);
			
			matrix.translate(-p.x,-p.y);
			matrix.scale(zoom,zoom);
			matrix.translate(bitmap.width/2,bitmap.height/2);
			
			var myFilters:Array = new Array();
			
			if (_focus <1) {
				var blurX:Number = (1-_focus) * 20;
				var blurY:Number = (1-_focus) * 20;
				var filter:BitmapFilter  = new BlurFilter(blurX, blurY, BitmapFilterQuality.LOW);
				
				myFilters.push(filter);
			}
			
			
			data.draw(background,matrix);
			bitmap.filters = myFilters;
		}
		
		public function snapshot() : BitmapData {
			
				
			SoundManager.playSound(SafariSounds.CAMERA_SHOT_SOUND);
			var photoData : BitmapData = new BitmapData(data.width,data.height,false);
			photoData.draw(bitmap);
			return photoData;
			
			
			
		}
		
		
	}
}
