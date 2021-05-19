import wollok.game.*
import pepita.*


class Bomba{
	var property image = "bomba.png"		//imagen base de la bomba
	var property position
	const explosion = ["bomba.png","bomba2.png","bomba3.png","bomba4.png","bomba5.png","bomba6.png"]
					// lista con todas las imagenes de la animacion
	
	method iniciarExplosion(){		//inicia la animacion de la explosion, funciona similar a las otras animaciones, pero esta no se mueve
		var i = 0
		game.onTick(300,"explosion",{
			
			self.image(explosion.get(i))
			i += 1 
			
			if(i > 5){
				game.removeTickEvent("explosion")
				game.removeVisual(self)
				bomber.resetBomba()	//resetea la bomba del personaje
			}
		})
		
	}
}