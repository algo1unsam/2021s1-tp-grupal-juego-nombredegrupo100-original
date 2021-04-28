import pepita.*
import wollok.game.*

object configuracion {
	
		method configurarTeclas() {
		keyboard.left().onPressDo({ pepita.moverseIzquierda() })
		keyboard.right().onPressDo({ pepita.moverseDerecha() })
		keyboard.up().onPressDo({ pepita.moverseArriba() })
		keyboard.down().onPressDo({ pepita.moverseAbajo() })
	}
}
