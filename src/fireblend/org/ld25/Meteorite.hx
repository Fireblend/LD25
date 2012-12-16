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
	
	private var activeMines :Int;
	
	
	public function new(newgameScreen:GameScreen) 
	{
		super();
		activeMines = 0;
		gameScreen = newgameScreen;
		asteroid = Utils.loadGraphic ("assets/gfx/astrid.png", true);
		scaleFactor = 1;
		mines = new Array<Mine>();
		
		addChild(asteroid);
	}
	
	public function addMine(gold:Bool) {
		if (mines.length > 6){
			mines[0].explodeDamage();
			return;
		}
		var newMine : Mine = new Mine(gameScreen, gold);
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
	
	public function addDistance(dist:Float) {
		for (i in 0...mines.length) {
			mines[i].distance += dist;
			if (mines[i].distance > 1500 && !mines[i].removed && !mines[i].gold) {
				mines[i].remove();
			}
		}
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