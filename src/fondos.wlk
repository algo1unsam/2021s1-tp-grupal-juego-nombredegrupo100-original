import Padre.*
import wollok.game.*
import bomber.*
import creador.*

object fondoMenu {		//fondo del menu principal

	var property animaciones = true
	
	method image() = "menu1.png"
	method position() = game.origin()
	
	method configurar() {
		keyboard.num(1).onPressDo{ nivel1.iniciar()}
		keyboard.num(2).onPressDo{ game.stop()}
		keyboard.num(0).onPressDo{ self.animaciones(false)}
		}
}

class Niveles {		//fondo del primer nivel

	var property contadorDeEnemigos

//Bloque prohibidos del primer nivel
	var property bloquesProhibidos = #{
		game.at(12,60),game.at(24,60),game.at(36,60),game.at(48,60),game.at(60,60),game.at(72,60),
		game.at(12,48),game.at(24,48),game.at(36,48),game.at(48,48),game.at(60,48),game.at(72,48),
		game.at(12,36),game.at(24,36),game.at(36,36),game.at(48,36),game.at(60,36),game.at(72,36),
		game.at(12,24),game.at(24,24),game.at(36,24),game.at(48,24),game.at(60,24),game.at(72,24),
		game.at(12,12),game.at(24,12),game.at(36,12),game.at(48,12),game.at(60,12),game.at(72,12)
		}

	method murioUnEnemigo(){
		contadorDeEnemigos -= 1
	}

	method position() = game.origin()
	
	method iniciar()

	method configurar() {
		if(fondoMenu.animaciones()){
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
		
	method ganar()
	
}

object nivel1 inherits Niveles {
	
	method image() = "fondo.png"
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		
		creador.creacionBloquesNivel1()
		creador.creacionEnemigoNivel1()
		
		if(fondoMenu.animaciones()){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
		self.configurar()	
	}
	
	override method ganar(){
		if(contadorDeEnemigos == 0){
			game.schedule(5000,{
				game.clear()
				game.schedule(10000,{nivel2.iniciar()})
			})
			
		}
	}	
}

object nivel2 inherits Niveles {
	
	method image() = "fondo2.png"
	
	override method iniciar(){
		
		if(fondoMenu.animaciones()){bomber.position(game.at(6,6))}
		else{bomberSinAnimaciones.position(game.at(6,6))}
		
		game.clear()
		game.addVisual(self)
		
		creador.creacionBloquesNivel2()
		creador.creacionEnemigoNivel2()
		
		if(fondoMenu.animaciones()){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
		self.configurar()	
	}
	
	override method ganar(){
		if(contadorDeEnemigos == 0){
			game.schedule(5000,{
				game.clear()
				game.schedule(10000,{nivel3.iniciar()})
			})
		}
	}	
}

object nivel3 inherits Niveles {
	
	method image() = "fondo3.png"
	
	override method iniciar(){
		
		if(fondoMenu.animaciones()){bomber.position(game.at(30,30))}
		else{bomberSinAnimaciones.position(game.at(78,6))}
		
		game.clear()
		game.addVisual(self)
		
		creador.creacionBloquesNivel3()
		creador.creacionEnemigoNivel3()
		
		if(fondoMenu.animaciones()){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
		self.configurar()	
	}
	
	override method ganar(){
		if(contadorDeEnemigos == 0){
			game.say(self,"ganaste")
		}
	}	
}