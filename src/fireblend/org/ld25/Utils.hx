package fireblend.org.ld25;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.display.Loader;
import nme.net.URLRequest;
import nme.utils.ByteArray;
import nme.Assets;
import nme.media.Sound;

class Utils {

	private static var loadGraphicCache:Hash <BitmapData> = new Hash <BitmapData> ();
	private static var loadSoundCache:Hash<Sound> = new Hash <Sound>();
	
	public static function loadGraphic (path:String, forceSprite:Bool = false, cache:Bool = true):Dynamic {
		
		var bitmap:Bitmap;
		
		if (cache) {
			
			if (!loadGraphicCache.exists (path)) {
				loadGraphicCache.set (path, Assets.getBitmapData (path));
			}
			
			bitmap = new Bitmap (loadGraphicCache.get (path));
			
		} else {
			bitmap = new Bitmap (Assets.getBitmapData (path));
		}
	
		if (forceSprite) {
			
			var sprite:Sprite = new Sprite ();
			sprite.addChild (bitmap);
			
			return sprite;
			
		} else {
			
			return bitmap;
			
		}
		
	}

	public static function loadSound (path:String, cache:Bool = true):Dynamic {
		
		var sound:Sound;
		
		if (cache) {
			
			if (!loadSoundCache.exists (path)) {
				loadSoundCache.set (path, Assets.getSound (path));
			}
			sound = loadSoundCache.get (path);
			
		} else {
			sound = Assets.getSound (path);
		}
	
		return sound;
		
	}


}
