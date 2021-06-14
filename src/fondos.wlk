import Padre.*
import wollok.game.*
import bomber.*
import creador.*

object animaciones{
	var property animaciones = true 
	var property position = game.at(18,25)
	var property image = "cruz.png"
}


class Fondos {		//fondo del primer nivel

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
		if(animaciones.animaciones()){
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

object gameOver inherits Fondos {
	
	method image() = "Game_Over.png"
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		self.configurar()
	}
	
	override method configurar() {
		keyboard.num(0).onPressDo{ game.stop()}
	}
	
	override method ganar() {}	

}

object fondoMenu inherits Fondos {		//fondo del menu principal
	var flagMusica = false
	method image() = "menu2.png"
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		self.configurar()
		
		if (!flagMusica){
			game.onTick(50,"Sonido",{
			game.sound("01_TitleScreen.mp3").play()
			game.sound("01_TitleScreen.mp3").shouldLoop(true)
			game.sound("01_TitleScreen.mp3").volume(0.3)
			game.removeTickEvent("Sonido")
			flagMusica = !flagMusica})
		}
	}
	
	override method configurar() {
		keyboard.num(1).onPressDo{ nivel1.iniciar()}
		keyboard.num(2).onPressDo{ game.stop()}
		keyboard.num(3).onPressDo{ menuAyuda.iniciar()}
	}
	
	override method ganar() {}
}

object menuAyuda inherits Fondos{
	
	method image() = "menu_ayuda.png"
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		self.configurar()
		
		if (animaciones.animaciones()){
			game.addVisual(animaciones)
		}
	}
	
	override method configurar() {
		keyboard.num(1).onPressDo{
			
			if(animaciones.animaciones()){
				animaciones.animaciones(false)
				game.removeVisual(animaciones)
			}else{
				animaciones.animaciones(true)
				game.addVisual(animaciones)
			}
			
		}
		keyboard.num(0).onPressDo{fondoMenu.iniciar()}
		
	}
		
	override method ganar() {}
}

object fondoGanarNivel1 inherits Fondos{
	
	method image()= "Ganar nivel.png"
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		game.schedule(10000,{nivel2.iniciar()})
	}
	
	override method configurar(){}
	
	override method ganar(){}
	
}

object fondoGanarNivel2 inherits Fondos{
	
	method image()= "Ganar nivel.png"
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		game.schedule(10000,{nivel3.iniciar()})
	}
	
	override method configurar(){}
	
	override method ganar(){}
	
}


object nivel1 inherits Fondos {
	
	method image() = "fondo.png"
	
	
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		creador.crearPowerUpBomba1()
		creador.creacionBloquesNivel1()
		creador.creacionEnemigoNivel1()
		
		if(animaciones.animaciones()){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
		self.configurar()
		
		game.sound("Bomberman (NES) Music - Stage Theme.mp3").play()
		game.sound("Bomberman (NES) Music - Stage Theme.mp3").shouldLoop(true)
		game.sound("Bomberman (NES) Music - Stage Theme.mp3").volume(0.3)
	}
	
	override method ganar(){
		if(contadorDeEnemigos == 0){
			game.schedule(5000,{
				game.clear()
				fondoGanarNivel1.iniciar()
			})
			
		}
	}	
}

object nivel2 inherits Fondos {
	
	method image() = "fondo2.png"
	
	override method iniciar(){
		
		if(animaciones.animaciones()){bomber.position(game.at(6,6))}
		else{bomberSinAnimaciones.position(game.at(6,6))}
		
		game.clear()
		game.addVisual(self)
		
		creador.creacionBloquesNivel2()
		creador.creacionEnemigoNivel2()
		
		if(animaciones.animaciones()){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
		self.configurar()	
	}
	
	override method ganar(){
		if(contadorDeEnemigos == 0){
			game.schedule(5000,{
				game.clear()
				fondoGanarNivel2.iniciar()
			})
		}
	}	
}

object nivel3 inherits Fondos {
	
	method image() = "fondo3.png"
	
	override method iniciar(){
		
		if(animaciones.animaciones()){bomber.position(game.at(30,30))}
		else{bomberSinAnimaciones.position(game.at(78,6))}
		
		game.clear()
		game.addVisual(self)
		
		creador.creacionBloquesNivel3()
		creador.creacionEnemigoNivel3()
		
		if(animaciones.animaciones()){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
		self.configurar()	
	}
	
	override method ganar(){
		if(contadorDeEnemigos == 0){
			game.clear()
			game.addVisual("GG.png")
		}
	}	
}


	



