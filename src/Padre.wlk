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

	const property position 
	const property image = "muro.png"	
	//const imagenesDestruccion = []
	const velocidad = 50
	
	override method destruccion(){
		//self.animacionFija(velocidad,imagenesDestruccion,self)
		super()
	}
	
	method colisionCon(objeto){
		
	}	
	
}

//Clase enemigo, clase de los enemigos
class Enemigo inherits ElementosMovibles {

	var property image = "mentaGranizada.png"
	const property position
	
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


//#######################################################################################################

object creador{
	
	const posicionesNivel1=#{
							game.at(18,66),game.at(24,66),game.at(30,66),game.at(36,66),game.at(42,66),game.at(48,66),game.at(54,66),game.at(60,66),game.at(66,66),
							game.at(18,60),game.at(30,60),game.at(54,60),game.at(66,60),
							game.at(6,54),game.at(12,54),game.at(30,54),game.at(36,54),game.at(42,54),game.at(54,54),game.at(60,54),game.at(78,54),
							game.at(30,48),game.at(42,48),game.at(54,48),game.at(66,48),game.at(78,48),
							game.at(6,42),game.at(12,42),game.at(24,42),game.at(42,42),game.at(48,42),game.at(54,42),game.at(60,42),game.at(72,42),game.at(78,42),
							game.at(6,36),game.at(18,36),game.at(30,36),game.at(42,36),game.at(54,36),game.at(66,36),game.at(78,36),
							game.at(6,30),game.at(12,30),game.at(18,30),game.at(24,30),game.at(30,30),game.at(36,30),game.at(42,30),game.at(60,30),game.at(66,30),game.at(72,30),game.at(78,30),
							game.at(6,24),game.at(18,24),game.at(54,24),game.at(66,24),game.at(78,24),
							game.at(6,18),game.at(12,18),game.at(24,18),game.at(30,18),game.at(36,18),game.at(48,18),game.at(54,18),game.at(60,18),game.at(66,18),game.at(72,18),game.at(78,18),
							game.at(18,12),game.at(30,12),game.at(42,12),
							game.at(18,6),game.at(24,6),game.at(30,6),game.at(36,6),game.at(42,6),game.at(48,6),game.at(54,6),game.at(60,6),game.at(66,6)
							}
	
	method creacionBloquesNivel1(){
		
		posicionesNivel1.forEach({posicion =>
			
			const bloque = new Bloque(position = posicion)
			game.addVisual(bloque)
			game.whenCollideDo(bloque,{ algo => algo.colisionCon(bloque)})
			
		})

	}
	
}


