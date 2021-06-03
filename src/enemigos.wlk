import wollok.game.*
import Padre.*


//Clase enemigo, clase de los enemigos
class Enemigo inherits ElementosMovibles {

	var property image = "mentaGranizada.png"
	var property position
	var property flagVida = true
	
	override method destruccion(){
		self.flagVida(false)
		game.removeVisual(self)
		
	}
	
	override method condicionParaMoverseArriba(){
		const destino = self.position().up(6)
		return destino.y() <=  66 and not game.getObjectsIn(game.origin()).first().bloquesProhibidos().contains(destino) and game.getObjectsIn(destino).isEmpty()
	}
	
	override method condicionParaMoverseAbajo(){
		const destino = self.position().down(6)
		return destino.y() >= 6 and not game.getObjectsIn(game.origin()).first().bloquesProhibidos().contains(destino) and game.getObjectsIn(destino).isEmpty()
	}
	
	override method condicionParaMoverseIzquierda(){
		const destino = self.position().left(6)
		return destino.x() >=  6 and not game.getObjectsIn(game.origin()).first().bloquesProhibidos().contains(destino) and game.getObjectsIn(destino).isEmpty()
	}
	
	override method condicionParaMoverseDerecha(){
		const destino = self.position().right(6)
		return destino.x() <= 13*6 and not game.getObjectsIn(game.origin()).first().bloquesProhibidos().contains(destino) and game.getObjectsIn(destino).isEmpty()	
	}
	
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
	
	method meMuevoSolo(direccion){
		
		if (direccion == 1 and self.condicionParaMoverseArriba()){self.moverseArriba()}
		if (direccion == 2 and self.condicionParaMoverseAbajo()){self.moverseAbajo()}
		if (direccion == 3 and self.condicionParaMoverseIzquierda()){self.moverseIzquierda()}
		if (direccion == 4 and self.condicionParaMoverseDerecha()){self.moverseDerecha()}
	}
	
	override method colisionCon(objeto){
		objeto.destruccion()
	}	
	
}