import wollok.game.*
import pepita.*
import objects.*

class Animados {		//esta clase se encarga de todas las animaciones del personaje
	var property time = 25		//variable time sirve para medir la velociad
	
	method animacionArriba(imagenes,objeto){
		var i = 0
		game.onTick(time,"animacionArriba",{		//ejecuta un on tick el cual cada <time> tiempo cambia la imagen
													// y mueve al personaje una espacio en una direccion
			objeto.position(objeto.position().up(1))
			objeto.image(imagenes.get(i))
			i += 1									//usa un indice para moverse por la lista de imagenes
			if(i > 5){
				game.removeTickEvent("animacionArriba")	//cuando llega a 6 remueve el evento tick
				objeto.enMovimiento(false)
			}											
		})
	}
	
	method animacionAbajo(imagenes,objeto){
		var i = 0
		game.onTick(time,"animacionAbajo",{
			
			objeto.position(objeto.position().down(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > 5){
				game.removeTickEvent("animacionAbajo")
				objeto.enMovimiento(false)
			}
		})
	}
	
	method animacionIzquierda(imagenes,objeto){
		var i = 0
		game.onTick(time,"animacionIzq",{
			
			objeto.position(objeto.position().left(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > 5){
				game.removeTickEvent("animacionIzq")
				objeto.enMovimiento(false)
			}
		})
	}
	
	method animacionDerecha(imagenes,objeto){
		var i = 0
		game.onTick(time,"animacionDer",{
			
			objeto.position(objeto.position().right(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > 5){
				game.removeTickEvent("animacionDer")
				objeto.enMovimiento(false)
			}
		})
	}
}