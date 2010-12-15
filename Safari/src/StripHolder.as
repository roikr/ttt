package {
	import layers.*;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author roikr
	 */
	public class StripHolder extends MovieClip {
	
		private static var importer:Array = [
            Sky,
            Mountains,
            Far,
            Middle,
            Near,
            River,
            Second,
            First,
            Fish,
            Eli1,
            Eli2,
            Giraffe,
            Monkey,
            Raccoon,
            Bird,
            Hipo,
            Lion,
            Monkey2
        ];
        
        private static var markersNames:Array = ["WaterMarker","LandMarker","HidingMarker","TreeMarker"];
        private static var waterAnimals:Array = ["Fish","Hipo"];
        private static var landAnimals:Array = ["Eli1","Monkey","Bird","Lion"];
        private static var hidingAnimals:Array = ["Giraffe","Monkey","Raccoon","Eli2","Monkey2"];
        private static var treeAnimals:Array = ["Bird"];
        private static var animalsNames:Array=["Fish","Hipo","Eli1","Monkey","Bird","Lion","Giraffe","Raccoon","Eli2","Monkey2"];
        private static var animalsCodes:Array=[ChatpetzCodes.SAFARI_GAME_FISH,ChatpetzCodes.SAFARI_GAME_I_CAN_SEE_YOU,ChatpetzCodes.SAFARI_GAME_ELEPHANT,ChatpetzCodes.SAFARI_GAME_MONKEY,
        									ChatpetzCodes.SAFARI_GAME_BIRD,ChatpetzCodes.SAFARI_GAME_LION,ChatpetzCodes.SAFARI_GAME_I_CAN_SEE_YOU,ChatpetzCodes.SAFARI_GAME_RACCOON,
        									ChatpetzCodes.SAFARI_GAME_ELEPHANT,ChatpetzCodes.SAFARI_GAME_MONKEY];

		private var layer0:Sprite;
		private var layer1:Sprite;
		private var velX:int;
		
		private var animalsLayer:Sprite;
		private var className:String;
		
		public function StripHolder(className:String, initY:int, velX:int,addAnimals:Boolean = false) {
			
			this.className = className;
			var ClassReference:Class = getDefinitionByName(className) as Class;
			
			layer0 = new ClassReference() as Sprite;
			layer0.y = initY;
			addChild(layer0);
			
			
			layer1 = new ClassReference() as Sprite;
			layer1.y = initY;
			layer1.x = layer1.width;
			addChild(layer1);
			
			this.velX = velX;
			
			//trace(className+' '+this.velX);
			
			if (addAnimals) {
				animalsLayer = new Sprite();
				addChild(animalsLayer);
				animalsLayer.y = initY;
				
				/*
				for (var j:int = 0 ; j<20 ; j++ ) {
				
					for	(var i:int = 0 ; i < layer0.numChildren ; i++) {
						if (layer0.getChildAt(i) is AnimalMarker) {
							
							if (Math.random()>0.75)
								continue;
							
							addAnimalToMarker(layer0.getChildAt(i) as AnimalMarker,j * layer0.width);		
						}
					}
					
				}
				 * 
				 */
				 
			}
			
			
			//addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		/*
		public function getNearestMarker() : AnimalMarker {
			var relX : int = (890 - animalsLayer.x) % layer0.width;
			trace("layer: "+className+", relX: ",relX);
				
			var max:int = layer0.width;
			var marker:AnimalMarker = null;
			
			for	(var i:int = 0 ; i < layer0.numChildren ; i++) {
				if (layer0.getChildAt(i) is AnimalMarker) {
					
					var temp:AnimalMarker = layer0.getChildAt(i) as AnimalMarker;
					//trace("layer: "+className+", marker found at: ",temp.x);
					if (temp.x> relX && temp.x<max) {
						//trace("replacing")
						marker = temp;
						max = temp.x
					}		
				}
			}
					
			
			return marker;
		}
		 
		 */
		 
		 public function getNearestMarker() : AnimalMarker {
		 	
				
			var max:int = layer0.width;
			var marker:AnimalMarker = null;
			var temp:AnimalMarker ;
			var p:Point;
			
			for	(var i:int = 0 ; i < layer0.numChildren ; i++) {
				if (layer0.getChildAt(i) is AnimalMarker) {
					temp = layer0.getChildAt(i) as AnimalMarker;
					p = new Point(temp.x,temp.y);
					p = layer0.localToGlobal(p);
					p = this.parent.globalToLocal(p);
					
					//trace("layer: "+className+", marker found at: ",temp.x);
					if ( p.x > 890 && p.x<max) {
						//trace("replacing")
						marker = temp;
						max = temp.x
					}		
				}
			}
			
			for	(i = 0 ; i < layer1.numChildren ; i++) {
				if (layer1.getChildAt(i) is AnimalMarker) {
					temp = layer1.getChildAt(i) as AnimalMarker;
					p = new Point(temp.x,temp.y);
					p = layer1.localToGlobal(p);
					p = this.parent.globalToLocal(p);
					
					//trace("layer: "+className+", marker found at: ",temp.x);
					if ( p.x > 890 && p.x<max) {
						//trace("replacing")
						marker = temp;
						max = temp.x
					}		
				}
			}
					
			return marker;
		}
		
		public function addAnimal() : Animal {
			var marker:AnimalMarker = getNearestMarker();
			
			if (marker) {
				
				//trace("layer: "+className+", nearest marker: ",getQualifiedClassName(marker));
				return addAnimalToMarker(marker);	
				
			} else
				return null;
		}
		
		private function addAnimalToMarker(marker:AnimalMarker) : Animal {
			var name:String = getQualifiedClassName(marker);
			var index:int = markersNames.indexOf(name);
			
	
			if (index!=-1) {
				var arr:Array;
				switch (index) {
					case 0:
						arr = waterAnimals;
						break;
					case 1:
						arr = landAnimals;
						break;
					case 2:
						arr = hidingAnimals;
						break;
					case 3:
						arr = treeAnimals;
						break;
						
				}
				
				
				
				var animalIndex:int = Math.floor(arr.length*Math.random());
				var animalName:String = arr[animalIndex];
				var AnimalClassReference:Class = getDefinitionByName(animalName) as Class;
				
				//var mc:Sprite = marker as Sprite;
				//var p:Point = mc.localToGlobal(new Point(0,0));
				var p:Point = new Point(marker.x,marker.y);
				p = marker.parent.localToGlobal(p);
				p = animalsLayer.globalToLocal(p);
				
				
				var animal:Animal = new AnimalClassReference() as Animal;
				animal.x = p.x ;
				animal.y = p.y;
				animalsLayer.addChild(animal);
					//trace(i+' '+className);
				trace("animal: "+ animalName + " add to layer: " + className +" at: "+animal.x)
				return animal;
				
			}
			
			return null;
		}
		
		public function update() : void{
			
			layer0.x -= velX;
			layer1.x -= velX;
			if (animalsLayer)
				animalsLayer.x -= velX;
			
			if (layer0.x+layer0.width < 0)
				layer0.x+=2*layer0.width;
				
			if (layer1.x+layer1.width < 0)
				layer1.x+=2*layer1.width;
		
		}
		
		public function hitTest(obj:DisplayObject) : Object {
			for (var i:int = 0;i<animalsLayer.numChildren;i++) {
				if ( animalsLayer.getChildAt(i) is Animal) {
					var animal:Animal =  animalsLayer.getChildAt(i) as Animal;
					if (animal.distance(obj) < 100) {
						return animal;
					}
				}				
			}
			return null;			
		}
		
		public static function getAnimalCode(animal:Animal) : int {
			var name:String = getQualifiedClassName(animal);
			var index:int = animalsNames.indexOf(name);
			return animalsCodes[index];
		}
		
		public function get velocity() : int {
			return velX;
		}
	}
}
