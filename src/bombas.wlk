import wollok.game.*
import pepita.*


class Bomba{
	var property image = "bomba.png"		//imagen base de la bomba
	var property position
	var property rango = 2                 // alcance de la explosion
	const explosion = ["bomba.png","bomba2.png","bomba3.png","bomba.png","bomba2.png","bomba3.png","bomba4.png","bomba5.png","bomba6.png"]
					// lista con todas las imagenes de la animacion
	
	method iniciarExplosion(){		//inicia la animacion de la explosion, funciona similar a las otras animaciones, pero esta no se mueve
		var i = 0
		
		game.onTick(300,"explosion",{
			
			if(i == 6){self.expandeExplosion()} //Cuando explote expande la explosion a su alrededor
			self.image(explosion.get(i))
			i += 1 
			
			
			if(i > 8){
				game.removeTickEvent("explosion")
				game.removeVisual(self)
				bomber.resetBomba()	//resetea la bomba del personaje
				
			}
		})
		
	}
	
	method expandeExplosion(){
		var i = 6
		const fuegoExplosion = []
		
		(1 .. rango).forEach{ n => fuegoExplosion.add(new Fuego(position = self.position().up( 6 * n ) ))}
		(1 .. rango).forEach{ n => fuegoExplosion.add(new Fuego(position = self.position().down( 6 * n ) ))}
		(1 .. rango).forEach{ n => fuegoExplosion.add(new Fuego(position = self.position().left( 6 * n ) ))}
		(1 .. rango).forEach{ n => fuegoExplosion.add(new Fuego(position = self.position().right( 6 * n ) ))}
		
		fuegoExplosion.forEach{ obj => game.addVisual(obj)}
		
		game.onTick(300,"explosion2",{
		
			fuegoExplosion.forEach{ obj => obj.image(explosion.get(i))}
		
			i += 1
		
		 	if(i > 8){
				game.removeTickEvent("explosion2")
				fuegoExplosion.forEach{ obj => game.removeVisual(obj)}
				
			}
		})
		
	}
	
	method collisionCon(objeto){game.say(objeto,"Colisiono")}
		
}

class Fuego{
	var property image = "bomba4.png"
	var property position
	
	method collisionCon(objeto){game.say(objeto,"Colisiono")}
}