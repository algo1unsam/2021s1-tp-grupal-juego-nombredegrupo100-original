import wollok.game.*

object pepita {
	
	var property image = "bomber.png"
	var property position = game.origin().up(6*11).right(6)
	var indice = 0

	method moverseArriba(){
		const imagenes = ["bomber_arriba1.png","bomber_arriba2.png","bomber_atras.png","bomber_arriba3.png","bomber_arriba4.png","bomber_atras.png"]

		game.onTick(50,"moverse arriba",{
			self.image(imagenes.get(indice))
			indice += 1
			position = self.position().up(1)
			if(indice > 5){
				game.removeTickEvent("moverse arriba")
				
				indice = 0
			}
		})
	}
	method moverseAbajo(){
		const imagenes = ["bomber_abajo1.png","bomber_abajo2.png","bomber.png","bomber_abajo3.png","bomber_abajo4.png","bomber.png"]

		game.onTick(50,"moverse abajo",{
			self.image(imagenes.get(indice))
			indice += 1
			position = self.position().down(1)
			if(indice > 5){
				game.removeTickEvent("moverse abajo")
				
				indice = 0
			}
		})
	}
	
	method moverseDerecha(){
		const imagenes = ["bomber_derecha1.png","bomber_derecha2.png","bomber_derecha.png","bomber_derecha3.png","bomber_derecha4.png","bomber_derecha.png"]

		game.onTick(50,"moverse derecha",{
			self.image(imagenes.get(indice))
			indice += 1
			position = self.position().right(1)
			if(indice > 5){
				game.removeTickEvent("moverse derecha")
				
				indice = 0
			}
		})
	}
	method moverseIzquierda(){
		const imagenes = ["bomber_izquierda1.png","bomber_izquierda2.png","bomber_izquierda.png","bomber_izquierda3.png","bomber_izquierda4.png","bomber_izquierda.png"]

		game.onTick(50,"moverse izquierda",{
			self.image(imagenes.get(indice))
			indice += 1
			position = self.position().left(1)
			if(indice > 5){
				game.removeTickEvent("moverse izquierda")
				
				indice = 0
			}
		})
	}
}

