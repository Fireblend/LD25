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
	public var trail : Shape;
	public var mines : Array<Mine>;
	private var gameScreen: GameScreen;
	
	public function new(newgameScreen:GameScreen) 
	{
		super();
		gameScreen = newgameScreen;
		asteroid = Utils.loadGraphic ("assets/gfx/astrid.png", true);
		scaleFactor = 1;
		mines = new Array<Mine>();
		
		addChild(asteroid);
	}
	
	public function addMine() {
		
		var newMine : Mine = new Mine(gameScreen);
		var xOffSet:Int;
		var yOffSet:Int;
		
		if (Std.random(2) == 1) {
			xOffSet = Std.random(Std.int(asteroid.width / 4));
			newMine.rotation = Std.random(90);
		}
		else{
			xOffSet = -Std.random(Std.int(asteroid.width / 4));
			newMine.rotation = -Std.random(90);
		}
		if (Std.random(2) == 1) {
			yOffSet = Std.random(Std.int(asteroid.height / 4));
		}
		else{
			yOffSet = -Std.random(Std.int(asteroid.height / 4));
		}
		
		
		newMine.x = asteroid.width/2 + xOffSet;
		newMine.y = asteroid.height/2 + yOffSet;
		
		addChild(newMine);
		newMine.startBeeping();
		mines.push(newMine);
	}
	
	public function reviewMines() {
		var st:Int = 0;
		
		while (st < mines.length) {
			var mine :Mine = mines[st];
				
			if (mine != null && mine.delete) {
				if(mines.remove(mine)){
					removeChild(mine);
				}
				else {
					break;
				}
			}
			else {
				st += 1;
			}
		}
	}
	
	public function explode()
	{
		scaleFactor -= 0.01;
		scaleX = scaleFactor;
		scaleY = scaleFactor;
		//Actuate.tween(centralCircle, 0.4, { rotation: 360 } ).ease (Quad.easeInOut).repeat (3);
		
	}
	
}