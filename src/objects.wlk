import pepita.*
import wollok.game.*

object configuracion {
	
		method configurarTeclas() {
		keyboard.left().onPressDo({ bomberman.moverseIzquierda() })
		keyboard.right().onPressDo({ bomberman.moverseDerecha() })
		keyboard.up().onPressDo({ bomberman.moverseArriba() })
		keyboard.down().onPressDo({ bomberman.moverseAbajo() })
	}
}
