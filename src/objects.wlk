import Padre.*
import wollok.game.*
import bomber.*



object fondoMenu {
	method image() = "menu1.png"
	method position() = game.origin()
	
	method configurar() {
		keyboard.num(1).onPressDo{ primerNivel.iniciar()}
		keyboard.num(2).onPressDo{ game.stop()}
		//keyboard.num(0).onPressDo{ self.gameOver()}

		}
	
}

object primerNivel {
	method image() = "fondo.png"
	method position() = game.origin()
	
	method iniciar(){
			game.clear()
			creador.creacionBloquesNivel1()
			
			game.addVisual(self)
			game.addVisual(bomber)
			
	
			self.configurar()}	

	method configurar() {
			keyboard.left().onPressDo({ bomber.moverseIzquierda() })
			keyboard.right().onPressDo({ bomber.moverseDerecha() })
			keyboard.up().onPressDo({ bomber.moverseArriba()})
			keyboard.down().onPressDo({ bomber.moverseAbajo()})
			keyboard.space().onPressDo({ bomber.ponerBomba()})		//por ahora, con espacio se pone una bomba
	

			game.whenCollideDo(bomber,{ algo => algo.colisionCon(bomber)})
			
		}

}

/