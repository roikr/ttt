package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author roikr
	 */
	public class Layer extends Sprite {
		
		private static var layersImporter:Array = [
            SkyLayerMC,
            MountainsLayerMC,
            FarLayerMC,
            MiddleLayerMC,
            NearLayerMC,
            RiverLayerMC,
            SecondLayerMC,
            FirstLayerMC,
            
        ];
        
        private static var animalsImporter:Array = [
            FishMC,
            Eli1MC,
            Eli2MC,
            GiraffeMC,
            MonkeyMC,
            RaccoonMC,
            BirdMC,
            HipoMC,
            LionMC,
            Monkey2MC
        ];
        
        private static var markersNames:Array = ["WaterMarker","LandMarker","HidingMarker","TreeMarker"];
        private static var waterAnimals:Array = ["FishMC","HipoMC"];
        private static var landAnimals:Array = ["Eli1MC","MonkeyMC","BirdMC","LionMC"];
        private static var hidingAnimals:Array = ["GiraffeMC","MonkeyMC","RaccoonMC","Eli2MC","Monkey2MC"];
        private static var treeAnimals:Array = ["BirdMC"];
        private static var animalsNames:Array=["FishMC","HipoMC","Eli1MC","MonkeyMC","BirdMC","LionMC","GiraffeMC","RaccoonMC","Eli2MC","Monkey2MC"];
        private static var animalsCodes:Array=[ChatpetzCodes.SAFARI_GAME_FISH,ChatpetzCodes.SAFARI_GAME_I_CAN_SEE_YOU,ChatpetzCodes.SAFARI_GAME_ELEPHANT,ChatpetzCodes.SAFARI_GAME_MONKEY,
        									ChatpetzCodes.SAFARI_GAME_BIRD,ChatpetzCodes.SAFARI_GAME_LION,ChatpetzCodes.SAFARI_GAME_I_CAN_SEE_YOU,ChatpetzCodes.SAFARI_GAME_RACCOON,
        									ChatpetzCodes.SAFARI_GAME_ELEPHANT,ChatpetzCodes.SAFARI_GAME_MONKEY];

		private var layer0:Sprite;
		private var layer1:Sprite;
		private var velX:int;
		
		private var animalsLayer:Sprite;
		private var className:String;
		
		private var _velocity:Number;
		
		public function Layer(className:String, initY:int, velX:int,addAnimals:Boolean = false) {
			
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
			}
			
			_velocity = 1;
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		public function set velocity(vel:Number) : void {
			_velocity = vel;
		}
		
		private function onEnterFrame(e:Event) : void{
			
			layer0.x -= velX * _velocity;
			layer1.x -= velX * _velocity;
			if (animalsLayer)
				animalsLayer.x -= velX * _velocity;
			
			if (layer0.x+layer0.width < 0)
				layer0.x+=2*layer0.width;
				
			if (layer1.x+layer1.width < 0)
				layer1.x+=2*layer1.width;
		
		}
		
		private function getNearestMarker(layer:Sprite,marker:AnimalMarker) : AnimalMarker {
		 	
				
			var max:int = layer.width;
			var temp:AnimalMarker ;
			var p:Point;
			
			for	(var i:int = 0 ; i < layer.numChildren ; i++) {
				if (layer.getChildAt(i) is AnimalMarker) {
					temp = layer.getChildAt(i) as AnimalMarker;
					p = new Point(temp.x,temp.y);
					p = layer.localToGlobal(p);
					p = this.parent.globalToLocal(p);
					
					//trace("layer: "+className+", marker found at: ",temp.x);
					if ( p.x > 890 && p.x<max) {
						//trace("replacing")
						marker = temp;
						max = temp.x;
					}		
				}
				
				
			}
			
			return marker;
		}
			
			
		
		
		public function addAnimal() : MovieClip {
			
			var marker:AnimalMarker = null;
			
			marker = getNearestMarker(layer0,marker);
			marker = getNearestMarker(layer1,marker);
			
			if (!marker) {
				return null;
			}
			
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
				var ref:Class = getDefinitionByName(animalName) as Class;
				
				//var mc:Sprite = marker as Sprite;
				//var p:Point = mc.localToGlobal(new Point(0,0));
				var p:Point = new Point(marker.x,marker.y);
				p = marker.parent.localToGlobal(p);
				p = animalsLayer.globalToLocal(p);
				
				
				var animal:MovieClip = new ref() as MovieClip;
				animal.x = p.x ;
				animal.y = p.y;
				animalsLayer.addChild(animal);
					//trace(i+' '+className);
				trace("animal: "+ animalName + " add to layer: " + className +" at: "+animal.x)
				return animal;
				
			}
			
			return null;
		}	
			
	
		
		
	}
}
