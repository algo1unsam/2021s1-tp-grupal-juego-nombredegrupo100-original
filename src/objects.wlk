import pepita.*
import wollok.game.*

object configuracion {				//configuracion de las teclas
		method configurarTeclas() {
		keyboard.left().onPressDo({ bomber.moverseIzquierda() })
		keyboard.right().onPressDo({ bomber.moverseDerecha() })
		keyboard.up().onPressDo({ bomber.moverseArriba()})
		keyboard.down().onPressDo({ bomber.moverseAbajo()})
	}
}
