import wollok.game.*

object pepita {
	
	var property position = game.center()

	method image() {
		return "Bomber.jpeg"

	}
	method moverseArriba(){
		const lista = []
		
		position = self.position().up(1)
	}
	method moverseAbajo(){
		const lista = []
		
		position = self.position().down(1)
	}
	method moverseDerecha(){
		const lista = []
		
		position = self.position().right(1)
	}
	method moverseIzquierda(){
		const lista = []
		
		position = self.position().left(1)
	}
}

