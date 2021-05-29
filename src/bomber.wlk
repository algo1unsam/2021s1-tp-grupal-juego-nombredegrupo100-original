import Padre.*
import wollok.game.*
import bombasYFuego.*

//Objeto bomber, objeto del personaje principal
object bomber inherits ElementosAnimadosMovibles {
	
	var property image = "bomber.png"		//imagen de inicio del bomberman
	
	var property position = game.at(6,66)	//posicion de inicio del bomberman
	
	var property enMovimiento = false		//flag de movimiento
	
	var property velocidad = 50				//velocidad de movimiento del personaje
	
	var property cantidadBomba = 1			//cantidad de bombas del personaje
	
	var property rangoDeBombas = 1  		//rango de las bombas del personaje
	
	const imagenesArriba = ["bomber_arriba1.png","bomber_arriba2.png","bomber_atras.png","bomber_arriba3.png","bomber_arriba4.png","bomber_atras.png"]
							//lista de imagenes para la animacion de arriba
	const imagenesAbajo = ["bomber_abajo1.png","bomber_abajo2.png","bomber.png","bomber_abajo3.png","bomber_abajo4.png","bomber.png"]
							//lista de imagenes para la animacion de abajo
	const imagenesDerecha = ["bomber_derecha1.png","bomber_derecha2.png","bomber_derecha.png","bomber_derecha3.png","bomber_derecha4.png","bomber_derecha.png"]
							//lista de imagenes para la animacion de derecha
	const imagenesIzquierda = ["bomber_izquierda1.png","bomber_izquierda2.png","bomber_izquierda.png","bomber_izquierda3.png","bomber_izquierda4.png","bomber_izquierda.png"]
							//lista de imagenes para la animacion de izquierda	
	const imagenesMuerte = ["bomber_death1.png","bomber_death2.png","bomber_death3.png","bomber_death4.png","bomber_death5.png"]
							//lista de imagenes para la animacion de muerte (work in progress)
							
//########################################################################################################					
							
	override method destruccion(){
		
			var i = 0
			game.onTick(300,"F",{
				
				self.image(imagenesMuerte.get(i))
				i += 1
				
				if (i > 4){
					game.removeVisual(self)
					game.removeTickEvent("F")
				}
			})
	}
							//metodo de destruccion, overridea al original, ejecuta la animacion y se elimina el visual
	override method condicionParaMoverseArriba(){
		const destino = self.position().up(6)
		return (destino.y() <=  66 and not bloquesProhibidos.contains(destino) and not enMovimiento)
	}
							//condicion para moverse arriba
	override method condicionParaMoverseAbajo(){
		const destino = self.position().down(6)
		return (destino.y() >= 6 and not bloquesProhibidos.contains(destino) and not enMovimiento)
	}
							//condicion para moverse abajo
	override method condicionParaMoverseIzquierda(){
		const destino = self.position().left(6)
		return (destino.x() >= 6 and not bloquesProhibidos.contains(destino) and not enMovimiento)
	}
							//condicion para moverse a la izquierda
	override method condicionParaMoverseDerecha(){
		const destino = self.position().right(6)
		return (destino.x() <= 13*6 and not bloquesProhibidos.contains(destino) and not enMovimiento)
	}
							//condicion para moverse a la derecha
	override method moverseArriba(){
		if(self.condicionParaMoverseArriba()){
			self.enMovimiento(true)
			self.animacionArriba(velocidad,imagenesArriba,self)
		}
	}
							//metodo para moverse arriba
	override method moverseAbajo(){
		if(self.condicionParaMoverseAbajo()){
			self.enMovimiento(true)
			self.animacionAbajo(velocidad,imagenesAbajo,self)
		}
	}
							//metodo para moverse abajo
	override method moverseIzquierda(){
		if(self.condicionParaMoverseIzquierda()){
			self.enMovimiento(true)
			self.animacionIzquierda(velocidad,imagenesIzquierda,self)
		}
	}
							//metodo para moverse a la izquierda
	override method moverseDerecha(){
		if(self.condicionParaMoverseDerecha()){
			self.enMovimiento(true)
			self.animacionDerecha(velocidad,imagenesDerecha,self)
		}
	}
							//metodo para moverse a la derecha
	override method colisionCon(objeto){}

	method ponerBomba(){
		if (cantidadBomba > 0 and not enMovimiento){
			cantidadBomba -= 1
			bloquesProhibidos.add(self.position())
			
			const bomba = new Bomba(position = self.position(),rango = rangoDeBombas)//crea un objeto bomba en la posicion actual de personaje
			game.addVisual(bomba)			//lo pone en el tablero
			game.removeVisual(self)			//se remueve a si mismo
			game.addVisual(self)			// y se vuelve a poner en el tablero, esto es para que visualmente el bomber quede arriba de la bomba y no al reves
			bomba.iniciarExplosion()		//inicia la explosion de la bomba
		}
	}
							//metodo para poner una bomba
	method reiniciarBomba(posicion){
		bloquesProhibidos.remove(posicion)
		cantidadBomba += 1
	}
							//metodo para reiniciar la cantidad de bombas
}