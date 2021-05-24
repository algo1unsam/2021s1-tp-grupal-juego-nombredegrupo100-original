import wollok.game.*
import pepita.*

class Bloque{
	//clase de prueba para los bloques, tiene la imagen muro por ahora y una posicion fija
	var property image = "muro.png"
	var property position = game.at(12,66)
	
	method collisionCon(objeto){game.say(objeto,"Colisiono")}
		
	
}