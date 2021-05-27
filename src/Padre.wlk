import wollok.game.*
import bomber.*

//Clase padre de todos los elementos, contienen algunas variables escenciales para cada objeto
class Elementos {

//lista con todos los bloques prohibidos 
	var property bloquesProhibidos = #{
		game.at(12,60),game.at(24,60),game.at(36,60),game.at(48,60),game.at(60,60),game.at(72,60),
		game.at(12,48),game.at(24,48),game.at(36,48),game.at(48,48),game.at(60,48),game.at(72,48),
		game.at(12,36),game.at(24,36),game.at(36,36),game.at(48,36),game.at(60,36),game.at(72,36),
		game.at(12,24),game.at(24,24),game.at(36,24),game.at(48,24),game.at(60,24),game.at(72,24),
		game.at(12,12),game.at(24,12),game.at(36,12),game.at(48,12),game.at(60,12),game.at(72,12)
		}

//metodo de destrucion de un elemento
	method destruccion(){
		game.removeVisual(self)
	}
	
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
class Bloque inherits ElementosAnimadosSinMovimiento {
	
	const imagenesDestruccion = []
	const velocidad = 50
	
	override method destruccion(){
		self.animacionFija(velocidad,imagenesDestruccion,self)
		super()
	}
	
}

//Clase enemigo, clase de los enemigos
class Enemigo inherits ElementosMovibles {

	override method destruccion(){
		super()
	}	
	
	override method condicionParaMoverseArriba(){}
	override method condicionParaMoverseAbajo(){}
	override method condicionParaMoverseIzquierda(){}
	override method condicionParaMoverseDerecha(){}
	
	override method moverseArriba(){}
	override method moverseAbajo(){}
	override method moverseIzquierda(){}
	override method moverseDerecha(){}
		
}



