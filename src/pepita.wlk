import wollok.game.*
import animados.*
import bombas.*

object bomber inherits Animados {		//hereda de animados las funciones de animacion
	
	var property enMovimiento = false
	
	var property cantidadBomba = 1		//indica la cantidad de bombas maximo que se pueden poner al mismo tiempo
	var property image = "bomber.png"	//imagen de inicio del personaje
	var property position = game.at(6,66)	//posicion de inicio del personaje
	const imagenes_arriba = ["bomber_arriba1.png","bomber_arriba2.png","bomber_atras.png","bomber_arriba3.png","bomber_arriba4.png","bomber_atras.png"]
							//lista de imagenes para la animacion de arriba
	const imagenes_abajo = ["bomber_abajo1.png","bomber_abajo2.png","bomber.png","bomber_abajo3.png","bomber_abajo4.png","bomber.png"]
							//lista de imagenes para la animacion de abajo
	const imagenes_derecha = ["bomber_derecha1.png","bomber_derecha2.png","bomber_derecha.png","bomber_derecha3.png","bomber_derecha4.png","bomber_derecha.png"]
							//lista de imagenes para la animacion de derecha
	const imagenes_izquierda = ["bomber_izquierda1.png","bomber_izquierda2.png","bomber_izquierda.png","bomber_izquierda3.png","bomber_izquierda4.png","bomber_izquierda.png"]
							//lista de imagenes para la animacion de izquierda
	const bloques_prohibidos = #{
								game.at(12,60),game.at(24,60),game.at(36,60),game.at(48,60),game.at(60,60),game.at(72,60),
								game.at(12,48),game.at(24,48),game.at(36,48),game.at(48,48),game.at(60,48),game.at(72,48),
								game.at(12,36),game.at(24,36),game.at(36,36),game.at(48,36),game.at(60,36),game.at(72,36),
								game.at(12,24),game.at(24,24),game.at(36,24),game.at(48,24),game.at(60,24),game.at(72,24),
								game.at(12,12),game.at(24,12),game.at(36,12),game.at(48,12),game.at(60,12),game.at(72,12)
								}
								//lista de prueba con los bloque que no se pueden atravesar, puede cambiar
	method resetBomba(){		//resetea una bomba despues de explotar
		cantidadBomba += 1
	}
	
	method ponerBomba(){		//coloca una bomba en el piso
		if (cantidadBomba > 0 and not enMovimiento){
			cantidadBomba -= 1
			const bomba = new Bomba(position = self.position())			//crea un objeto bomba en la posicion actual de personaje
			
			self.collisionBomba( bomba.position() )
			game.addVisual(bomba)				//lo pone en el tablero
			game.removeVisual(self)				//se remueve a si mismo
			game.addVisual(self)				// y se vuelve a poner en el tablero, esto es para que visualmente el bomber quede arriba de la bomba y no al reves
			bomba.iniciarExplosion()			//inicia la explosion de la bomba
			
		}
	}
	
	method collisionBomba(posicionDeBomba){
		var i = 0
		bloques_prohibidos.add( posicionDeBomba )
			
		game.onTick(300,"contador_bomba",{
			i += 1
			if(i > 6){
				bloques_prohibidos.remove( posicionDeBomba )
				game.removeTickEvent("contador_bomba")}
		})
	}
	
	method moverseArriba(){						//metodos de movimiento del personaje
		const destino = self.position().up(6)
		
		if (destino.y() <=  66 and not bloques_prohibidos.contains(destino) and not enMovimiento){
			self.enMovimiento(true)
			self.animacionArriba(imagenes_arriba,self)
		}
	}
	method moverseAbajo(){
		const destino = self.position().down(6)
		
		if (destino.y() >= 6 and not bloques_prohibidos.contains(destino) and not enMovimiento){
			self.enMovimiento(true)
			self.animacionAbajo(imagenes_abajo,self)
		}
	}
	
	method moverseDerecha(){
		const destino = self.position().right(6)

		if (destino.x() <= 13*6 and not bloques_prohibidos.contains(destino) and not enMovimiento){
			self.enMovimiento(true)
			self.animacionDerecha(imagenes_derecha,self)
		}
	}
	method moverseIzquierda(){
		const destino = self.position().left(6)

		if(destino.x() >= 6 and not bloques_prohibidos.contains(destino) and not enMovimiento){
			self.enMovimiento(true)
			self.animacionIzquierda(imagenes_izquierda,self)
		}
	}
}

