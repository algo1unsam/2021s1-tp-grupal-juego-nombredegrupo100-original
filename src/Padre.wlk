import wollok.game.*
import bomber.*
import fondos.*

//Clase padre de todos los elementos, contienen algunas variables  escenciales para cada objeto
class Elementos {
	
//metodo de destrucion de un elemento
	method destruccion(){
		game.removeVisual(self)
	}
	
	method colisionCon(objeto)
}

//Clase de elementos que se pueden mover
class ElementosMovibles inherits Elementos {
	
	method condicionParaMoverseArriba()
	
	method condicionParaMoverseAbajo()
	
	method condicionParaMoverseIzquierda()
	
	method condicionParaMoverseDerecha()
	
	method moverseArriba()
	
	method moverseAbajo()
	
	method moverseIzquierda()
	
	method moverseDerecha()
}

//Clase de elementos animados que se mueven
class ElementosAnimadosMovibles inherits ElementosMovibles {
	
	method animacionMuerte(imagenes,objeto){
		var i = 0
		game.onTick(300,"Press F to pay respect",{
			
			if(i > imagenes.size() - 1){
				gameOver.iniciar()
			} 
			else{
				objeto.image(imagenes.get(i))
				i += 1
			}
		})
}
	
	method animacionArriba(velocidad,imagenes,objeto){
		var i = 0
		game.onTick(velocidad,"animacionArriba",{		//ejecuta un on tick el cual cada <time> tiempo cambia la imagen
														// y mueve al personaje una espacio en una direccion
			objeto.position(objeto.position().up(1))
			objeto.image(imagenes.get(i))
			i += 1										//usa un indice para moverse por la lista de imagenes
			if(i > imagenes.size() - 1){
				game.removeTickEvent("animacionArriba")	//cuando llega a 6 remueve el evento tick
				objeto.enMovimiento(false)
			}
		})
	}
	
	method animacionAbajo(velocidad,imagenes,objeto){
		var i = 0
		game.onTick(velocidad,"animacionAbajo",{
			
			objeto.position(objeto.position().down(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > imagenes.size() - 1){
				game.removeTickEvent("animacionAbajo")
				objeto.enMovimiento(false)
			}
		})		
	}
	
	method animacionIzquierda(velocidad,imagenes,objeto){
		var i = 0
		game.onTick(velocidad,"animacionIzq",{
			
			objeto.position(objeto.position().left(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > imagenes.size() - 1 ){
				game.removeTickEvent("animacionIzq")
				objeto.enMovimiento(false)
			}
		})		
	}
	
	method animacionDerecha(velocidad,imagenes,objeto){
		var i = 0
		game.onTick(velocidad,"animacionDer",{
			
			objeto.position(objeto.position().right(1))
			objeto.image(imagenes.get(i))
			i += 1
			if(i > imagenes.size() - 1 ){
				game.removeTickEvent("animacionDer")
				objeto.enMovimiento(false)
			}
		})
	}		
}

//Clase de todos los elemento que tienen amiancione pero no se mueven
class ElementosAnimadosSinMovimiento inherits Elementos{
	
	method animacionFija(velocidad,imagenes,objeto){
		var i = 0
		game.onTick(velocidad,"animacion" + objeto.identity().toString(),{
			if(i > imagenes.size() - 1){
				game.removeTickEvent("animacion" + objeto.identity().toString())
				objeto.destruccion()	
			} 
			else{
				objeto.image(imagenes.get(i))
				i += 1
			}
		})
	}
}


//#######################################################################################################


//Clase Bloque, clase de los bloques
class Bloque inherits Elementos {

	const property position 
	const property image = "bloque.png"	
	
	method esAtravesable(){return false}
	
	override method colisionCon(objeto){
		
	}	
}