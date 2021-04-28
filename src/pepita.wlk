import wollok.game.*

object bomberman {
	
	var property position = game.at(10,10)

		
	method image() {
		return "bomber1.png"
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

