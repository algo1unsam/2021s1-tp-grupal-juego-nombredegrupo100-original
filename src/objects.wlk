import Padre.*
import wollok.game.*
import bomber.*


object configuracion {				//configuracion de las teclas
		method configurar() {
			keyboard.left().onPressDo({ bomber.moverseIzquierda() })
			keyboard.right().onPressDo({ bomber.moverseDerecha() })
			keyboard.up().onPressDo({ bomber.moverseArriba()})
			keyboard.down().onPressDo({ bomber.moverseAbajo()})
			keyboard.space().onPressDo({ bomber.ponerBomba()})		//por ahora, con espacio se pone una bomba
	

			game.whenCollideDo(bomber,{ algo => algo.colisionCon(bomber)})
			
			
		}
}
