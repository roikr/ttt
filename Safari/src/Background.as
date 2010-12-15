package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author roikr
	 */
	public class Background extends Sprite {
		
		private var sky:StripHolder;
		private var mountains:StripHolder;
		private var far:StripHolder;
		//private var farAnimals:AnimalsHolder;
		private var middle:StripHolder;
		private var near:StripHolder;
		//private var nearAnimals:AnimalsHolder;
		//private var riverAnimals:AnimalsHolder;
		private var river:StripHolder;
		private var second:StripHolder;
		private var first:StripHolder;
		private var _currentLayer:StripHolder;
		
		
		
		public function Background() {
			
			addChild(sky = new StripHolder("layers.Sky",0,0));
			addChild(mountains = new StripHolder("layers.Mountains",127,0));
			addChild(far = new StripHolder("layers.Far",20,1*1.5,true));
			//addChild(farAnimals = new AnimalsHolder(300,1.5*1.5,0));
			addChild(middle = new StripHolder("layers.Middle",240,2*1.5));
			addChild(near = new StripHolder("layers.Near",-20,3*1.5,true));
			//addChild(middleAnimals = new AnimalsHolder(350,3*1.5,1));
			//addChild(riverAnimals = new AnimalsHolder(435,4*1.5,2));
			addChild(river = new StripHolder("layers.River",470,4*1.5,true));
			addChild(second = new StripHolder("layers.Second",-51,6*1.5));
			addChild(first = new StripHolder("layers.First",-51,7*1.5));
			
		}
		
		public function addAnimal() : Animal {
			_currentLayer = Math.random()>0.5 ? near : river;
			return _currentLayer.addAnimal() ;
		}
		
		public function get currentLayer() : StripHolder {
			return _currentLayer;
		}
		
		
		
		public function hitTest(obj:DisplayObject) : Object {
			
			//return farAnimals.hitTest(obj) || middleAnimals.hitTest(obj) || riverAnimals.hitTest(obj);
			
			var res:Object;
			
			res = river.hitTest(obj);
			if (!res)
				res = near.hitTest(obj);	
				
			return res; 		
			
		}
		
		public function update() : void {
			for (var i:int=0;i<numChildren;i++) {
				var sh:StripHolder = getChildAt(i) as StripHolder;
				sh.update();
			}
		}
		
		
	}
}
