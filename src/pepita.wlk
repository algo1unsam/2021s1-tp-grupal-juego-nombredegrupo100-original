import wollok.game.*
import animados.*

object bomber inherits Animados {		//hereda de animados las funciones de animacion
	
	var property image = "bomber.png"
	var property position = game.at(6,66)
	const imagenes_arriba = ["bomber_arriba1.png","bomber_arriba2.png","bomber_atras.png","bomber_arriba3.png","bomber_arriba4.png","bomber_atras.png"]
	const imagenes_abajo = ["bomber_abajo1.png","bomber_abajo2.png","bomber.png","bomber_abajo3.png","bomber_abajo4.png","bomber.png"]
	const imagenes_derecha = ["bomber_derecha1.png","bomber_derecha2.png","bomber_derecha.png","bomber_derecha3.png","bomber_derecha4.png","bomber_derecha.png"]
	const imagenes_izquierda = ["bomber_izquierda1.png","bomber_izquierda2.png","bomber_izquierda.png","bomber_izquierda3.png","bomber_izquierda4.png","bomber_izquierda.png"]
	const bloques_prohibidos = #{
								game.at(12,63),game.at(24,63),game.at(36,63),game.at(48,63),game.at(60,63),game.at(72,63),
								game.at(12,51),game.at(24,51),game.at(36,51),game.at(48,51),game.at(60,51),game.at(72,51),
								game.at(12,39),game.at(24,39),game.at(36,39),game.at(48,39),game.at(60,39),game.at(72,39),
								game.at(12,27),game.at(24,27),game.at(36,27),game.at(48,27),game.at(60,27),game.at(72,27),
								game.at(12,15),game.at(24,15),game.at(36,15),game.at(48,15),game.at(60,15),game.at(72,15)
								}

	method moverseArriba(){
		const destino = self.position().up(6)
		
		if (destino.y() <=  66 and not bloques_prohibidos.contains(destino)){
			
			self.animacionArriba(imagenes_arriba,self)
		}
	}
	method moverseAbajo(){
		const destino = self.position().down(6)
		
		if (destino.y() >= 6 and not bloques_prohibidos.contains(destino)){
			
			self.animacionAbajo(imagenes_abajo,self)
		}
	}
	
	method moverseDerecha(){
		const destino = self.position().right(6)

		if (destino.x() <= 13*6 and not bloques_prohibidos.contains(destino)){
			
			self.animacionDerecha(imagenes_derecha,self)
		}
	}
	method moverseIzquierda(){
		const destino = self.position().left(6)

		if(destino.x() >= 6 and not bloques_prohibidos.contains(destino)){
			
			self.animacionIzquierda(imagenes_izquierda,self)
		}
	}
}

