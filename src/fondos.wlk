import Padre.*
import wollok.game.*
import bomber.*
import creador.*

object fondoMenu {			//fondo del menu principal

	var property animaciones = true
	
	method image() = "menu1.png"
	method position() = game.origin()
	
	method configurar() {
		keyboard.num(1).onPressDo{ primerNivel.iniciar(animaciones)}
		keyboard.num(2).onPressDo{ game.stop()}
		keyboard.num(0).onPressDo{ self.animaciones(false)}
		}
}

object primerNivel {		//fondo del primer nivel

//Bloque prohibidos del primer nivel
	var property bloquesProhibidos = #{
		game.at(12,60),game.at(24,60),game.at(36,60),game.at(48,60),game.at(60,60),game.at(72,60),
		game.at(12,48),game.at(24,48),game.at(36,48),game.at(48,48),game.at(60,48),game.at(72,48),
		game.at(12,36),game.at(24,36),game.at(36,36),game.at(48,36),game.at(60,36),game.at(72,36),
		game.at(12,24),game.at(24,24),game.at(36,24),game.at(48,24),game.at(60,24),game.at(72,24),
		game.at(12,12),game.at(24,12),game.at(36,12),game.at(48,12),game.at(60,12),game.at(72,12)
		}

	method image() = "fondo.png"
	method position() = game.origin()
	
	method iniciar(animaciones){
		game.clear()
		game.addVisual(self)
		
		//creador.creacionBloquesNivel1()
		creador.creacionEnemigoNivel1()
		if(animaciones){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
		self.configurar(animaciones)
			
	}	

	method configurar(animaciones) {
		if(animaciones){
			keyboard.left().onPressDo({ bomber.moverseIzquierda() })
			keyboard.right().onPressDo({ bomber.moverseDerecha() })
			keyboard.up().onPressDo({ bomber.moverseArriba()})
			keyboard.down().onPressDo({ bomber.moverseAbajo()})
			keyboard.space().onPressDo({ bomber.ponerBomba()})		//por ahora, con espacio se pone una bomba
	
			game.whenCollideDo(bomber,{ algo => algo.colisionCon(bomber)})
			
			}else{
			keyboard.left().onPressDo({ bomberSinAnimaciones.moverseIzquierda() })
			keyboard.right().onPressDo({ bomberSinAnimaciones.moverseDerecha() })
			keyboard.up().onPressDo({ bomberSinAnimaciones.moverseArriba()})
			keyboard.down().onPressDo({ bomberSinAnimaciones.moverseAbajo()})
			keyboard.space().onPressDo({ bomberSinAnimaciones.ponerBomba()})
	
			game.whenCollideDo(bomberSinAnimaciones,{ algo => algo.colisionCon(bomberSinAnimaciones)})
			}
		}
}