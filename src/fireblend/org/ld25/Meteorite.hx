package fireblend.org.ld25;
import nme.display.Shape;
import nme.display.Sprite;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;

/**
 * ...
 * @author Sergio Morales
 */

class Meteorite extends Sprite
{
	public var scaleFactor : Float;
	public var asteroid : Sprite;
	public var centralCircle : Sprite;
	public var trail : Shape;
	public function new() 
	{
		super();
		
		asteroid = Utils.loadGraphic ("assets/gfx/astrid.png", true);
		scaleFactor = 1;
		
		centralCircle = new Sprite();
		centralCircle.visible = true;
		
		asteroid.x = (centralCircle.x - asteroid.width/2);
		asteroid.y = (centralCircle.y - asteroid.height/2);
		
		addChild(centralCircle);
		centralCircle.addChild(asteroid);
	}
	
	public function explode()
	{
		scaleFactor -= 0.01;
		scaleX = scaleFactor;
		scaleY = scaleFactor;
		Actuate.tween(centralCircle, 0.4, { rotation: 360 } ).ease (Quad.easeInOut).repeat (3);
		
	}
	
}