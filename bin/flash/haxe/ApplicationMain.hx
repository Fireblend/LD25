import fireblend.org.ld25.Main;
import nme.Assets;
import nme.events.Event;


class ApplicationMain {
	
	static var mPreloader:NMEPreloader;

	public static function main () {
		
		var call_real = true;
		
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		
		nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		
		if (loaded < total || true) /* Always wait for event */ {
			
			call_real = false;
			mPreloader = new NMEPreloader();
			nme.Lib.current.addChild(mPreloader);
			mPreloader.onInit();
			mPreloader.onUpdate(loaded,total);
			nme.Lib.current.addEventListener (nme.events.Event.ENTER_FRAME, onEnter);
			
		}
		
		
		
		haxe.Log.trace = flashTrace; // null
		

		if (call_real)
			begin ();
	}

	
	private static function flashTrace( v : Dynamic, ?pos : haxe.PosInfos ) {
		var className = pos.className.substr(pos.className.lastIndexOf('.') + 1);
		var message = className+"::"+pos.methodName+":"+pos.lineNumber+": " + v;

        if (flash.external.ExternalInterface.available)
			flash.external.ExternalInterface.call("console.log", message);
		else untyped flash.Boot.__trace(v, pos);
    }
	
	
	private static function begin () {
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields(fireblend.org.ld25.Main))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (fireblend.org.ld25.Main, Reflect.field (fireblend.org.ld25.Main, "main"), []);
		}
		else
		{
			nme.Lib.current.addChild(cast (Type.createInstance(fireblend.org.ld25.Main, []), nme.display.DisplayObject));	
		}
		
	}

	static function onEnter (_) {
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		mPreloader.onUpdate(loaded,total);
		
		if (loaded >= total) {
			
			nme.Lib.current.removeEventListener(nme.events.Event.ENTER_FRAME, onEnter);
			mPreloader.addEventListener (Event.COMPLETE, preloader_onComplete);
			mPreloader.onLoaded();
			
		}
		
	}

	public static function getAsset (inName:String):Dynamic {
		
		
		if (inName=="assets/gfx/astrid.png")
			 
            return Assets.getBitmapData ("assets/gfx/astrid.png");
         
		
		if (inName=="assets/gfx/mine.png")
			 
            return Assets.getBitmapData ("assets/gfx/mine.png");
         
		
		if (inName=="assets/gfx/planet1.png")
			 
            return Assets.getBitmapData ("assets/gfx/planet1.png");
         
		
		if (inName=="assets/gfx/planet2.png")
			 
            return Assets.getBitmapData ("assets/gfx/planet2.png");
         
		
		if (inName=="assets/gfx/planet3.png")
			 
            return Assets.getBitmapData ("assets/gfx/planet3.png");
         
		
		
		return null;
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		mPreloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		
		nme.Lib.current.removeChild(mPreloader);
		mPreloader = null;
		
		begin ();
		
	}
	
}


class NME_assets_gfx_astrid_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_gfx_mine_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_gfx_planet1_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_gfx_planet2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_gfx_planet3_png extends nme.display.BitmapData { public function new () { super (0, 0); } }

