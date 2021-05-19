import wollok.game.*
import pepita.*
import objects.*

class Animados {		
	var property time = 25
	
	method animacionArriba(imagenes,objeto){
		var i = 0
		game.onTick(time,"animacionArriba",{
			
			objeto.position(objeto.position().up(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > 5){game.removeTickEvent("animacionArriba")}
		})
	}
	
	method animacionAbajo(imagenes,objeto){
		var i = 0
		game.onTick(time,"animacionAbajo",{
			
			objeto.position(objeto.position().down(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > 5){game.removeTickEvent("animacionAbajo")}
		})
	}
	
	method animacionIzquierda(imagenes,objeto){
		var i = 0
		game.onTick(time,"animacionIzq",{
			
			objeto.position(objeto.position().left(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > 5){game.removeTickEvent("animacionIzq")}
		})
	}
	
	method animacionDerecha(imagenes,objeto){
		var i = 0
		game.onTick(time,"animacionDer",{
			
			objeto.position(objeto.position().right(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > 5){game.removeTickEvent("animacionDer")}
		})
	}
}