import wollok.game.*

object pepita {
	
	var property image = "bomber.png"
	var property position = game.at(6,69)
	var indice = 0
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
		
		if (destino.y() <=  69 and not bloques_prohibidos.contains(destino)){
			game.onTick(25,"moverse arriba",{
				self.image(imagenes_arriba.get(indice))
				indice += 1
				position = self.position().up(1)
				if(indice > 5){
					game.removeTickEvent("moverse arriba")
					indice = 0
				}
			})
		}
	}
	method moverseAbajo(){
		const destino = self.position().down(6)
		
		if (destino.y() >= 6 and not bloques_prohibidos.contains(destino)){
			game.onTick(25,"moverse abajo",{
				self.image(imagenes_abajo.get(indice))
				indice += 1
				position = self.position().down(1)
				if(indice > 5){
					game.removeTickEvent("moverse abajo")
					indice = 0
				}
			})
		}
	}
	
	method moverseDerecha(){
		const destino = self.position().right(6)

		if (destino.x() <= 13*6 and not bloques_prohibidos.contains(destino)){
			game.onTick(25,"moverse derecha",{
				self.image(imagenes_derecha.get(indice))
				indice += 1
				position = self.position().right(1)
				if(indice > 5){
					game.removeTickEvent("moverse derecha")
					indice = 0
				}
			})
		}
	}
	method moverseIzquierda(){
		const destino = self.position().left(6)

		if(destino.x() >= 6 and not bloques_prohibidos.contains(destino)){
			game.onTick(25,"moverse izquierda",{
				self.image(imagenes_izquierda.get(indice))
				indice += 1
				position = self.position().left(1)
				if(indice > 5){
					game.removeTickEvent("moverse izquierda")
					indice = 0
				}
			})	
		}
	}
}

