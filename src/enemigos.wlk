import wollok.game.*
import Padre.*
import bomber.*

//Clase enemigo, clase de los enemigos
class Enemigo inherits ElementosMovibles {

	var property image = "mentaGranizada.png"		//imagen del enemigo... menta granizada...
	var property position
	var property velocidad							//velocidad del enemigo
		
	method esAtravesable(){return false}
	
	override method destruccion(){
		game.getObjectsIn(game.origin()).first().murioUnEnemigo()
		game.removeTickEvent("Me muevo"+self.identity().toString())
		game.removeVisual(self)
		game.getObjectsIn(game.origin()).first().ganar()
	}
	
//########################### Metodos de condicion para moverse ##################################

	override method condicionParaMoverseArriba(){
		const destino = self.position().up(6)
		const objetosDeDestino = game.getObjectsIn(destino)
		const fondo = game.getObjectsIn(game.origin()).first()
		
		return destino.y() <=  66 and not fondo.bloquesProhibidos().contains(destino) and objetosDeDestino.all({objeto => objeto.esAtravesable()})
	}
	
	override method condicionParaMoverseAbajo(){
		const destino = self.position().down(6)
		const objetosDeDestino = game.getObjectsIn(destino)
		const fondo = game.getObjectsIn(game.origin()).first()
		
		return destino.y() >= 6 and not fondo.bloquesProhibidos().contains(destino) and objetosDeDestino.all({objeto => objeto.esAtravesable()})
	}
	
	override method condicionParaMoverseIzquierda(){
		const destino = self.position().left(6)
		const objetosDeDestino = game.getObjectsIn(destino)
		const fondo = game.getObjectsIn(game.origin()).first()
			
		return destino.x() >=  6 and not fondo.bloquesProhibidos().contains(destino) and objetosDeDestino.all({objeto => objeto.esAtravesable()})
	}
	
	override method condicionParaMoverseDerecha(){
		const destino = self.position().right(6)
		const objetosDeDestino = game.getObjectsIn(destino)
		const fondo = game.getObjectsIn(game.origin()).first()
			
		return destino.x() <= 13*6 and not fondo.bloquesProhibidos().contains(destino) and objetosDeDestino.all({objeto => objeto.esAtravesable()})
	}
	
//########################### Metodos de movimiento ##################################
	
	override method moverseArriba(){
		self.position(self.position().up(6))
	}
	override method moverseAbajo(){
		self.position(self.position().down(6))
	}
	override method moverseIzquierda(){
		self.position(self.position().left(6))
	}
	override method moverseDerecha(){
		self.position(self.position().right(6))
	}
	
	method meMuevoSolo(direccion){	// metodo que, dependiendo de la condicion y del numero aneatorio generado, mueve el enemigo
		
		if (direccion == 1 and self.condicionParaMoverseArriba()){self.moverseArriba()}
		if (direccion == 2 and self.condicionParaMoverseAbajo()){self.moverseAbajo()}
		if (direccion == 3 and self.condicionParaMoverseIzquierda()){self.moverseIzquierda()}
		if (direccion == 4 and self.condicionParaMoverseDerecha()){self.moverseDerecha()}
		
	}
	
	override method colisionCon(objeto){
		objeto.destruccion()
	}
	
	method iniciarMovimiento(){		//cada 'velocidad' intenta moverse a una direccion aleatoria
		game.onTick(velocidad,"Me muevo"+self.identity().toString(),{
			self.meMuevoSolo((1..4).anyOne())
		})
	}
}
