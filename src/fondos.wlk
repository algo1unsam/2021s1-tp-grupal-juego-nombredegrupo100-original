import Padre.*
import wollok.game.*
import bomber.*
import creador.*

object musica{		//objeto musica, se encarga de la musica.
	
	const property musicaMenu = game.sound("01_TitleScreen.mp3")
 	const property musicaJuego1 = game.sound("Bomberman (NES) Music - Stage Theme.mp3")
 	const property musicaJuego2 = game.sound("Bomberman (NES) Music - Stage Theme.mp3")
 	const property musicaJuego3 = game.sound("Bomberman (NES) Music - Stage Theme.mp3")
	
}

object animaciones{		//objeto usado solo para especificar si hay animaciones o no
	var property animaciones = true 
	var property position = game.at(18,25)
	var property image = "cruz.png"
}


class Fondos {		//clase de los fondos, todos poseen los mismos bloques prohibidos y la misma configuracion

	var property contadorDeEnemigos

//Bloque prohibidos
	var property bloquesProhibidos = #{
		game.at(12,60),game.at(24,60),game.at(36,60),game.at(48,60),game.at(60,60),game.at(72,60),
		game.at(12,48),game.at(24,48),game.at(36,48),game.at(48,48),game.at(60,48),game.at(72,48),
		game.at(12,36),game.at(24,36),game.at(36,36),game.at(48,36),game.at(60,36),game.at(72,36),
		game.at(12,24),game.at(24,24),game.at(36,24),game.at(48,24),game.at(60,24),game.at(72,24),
		game.at(12,12),game.at(24,12),game.at(36,12),game.at(48,12),game.at(60,12),game.at(72,12)
		}
//metodo que indica si se murio un enemigo, si contadorDeEnemigos llega a 0, se pasa de nivel
	method murioUnEnemigo(){
		contadorDeEnemigos -= 1
	}
//posicion de los fondos es siempre igual, (0,0)
	method position() = game.origin()
//metodo abstracto iniciar
	method iniciar()
//configuracion de las teclas de cada nivel
	method configurar() {
		if(animaciones.animaciones()){	//dependiendo de las animaciones, el programa va a configurar las teclas de cada uno de los bomber y sus coliciones
			keyboard.left().onPressDo({ bomber.moverseIzquierda() })
			keyboard.right().onPressDo({ bomber.moverseDerecha() })
			keyboard.up().onPressDo({ bomber.moverseArriba()})
			keyboard.down().onPressDo({ bomber.moverseAbajo()})
			keyboard.space().onPressDo({ bomber.ponerBomba()})		
	
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
		
	method ganar()		//metodo abstracto ganar, indica que se gano el nivel y se pasa al siguiente nivel
	
}

//################################### Fondos no Jugables (menus, pantallas de carga etc) ###############################################

object gameOver inherits Fondos {		// fondo cuando se pierde
	
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

			musica.musicaMenu().shouldLoop(true)	
			musica.musicaMenu().play()
			musica.musicaMenu().volume(0.3)
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

object menuAyuda inherits Fondos{		//menu de ayuda
	
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
		keyboard.num(1).onPressDo{		//configura el 1 para la activacion / desactivacion de las animaciones 
			
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

object fondoGanarNivel1 inherits Fondos{	//fondo de victoria al ganar el nivel 1
	
	method image()= "Ganar nivel.png"
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		game.schedule(10000,{nivel2.iniciar()})
	}
	
	override method configurar(){}
	
	override method ganar(){}
	
}

object fondoGanarNivel2 inherits Fondos{	//fondo de victoria al ganar el nivel 2
	
	method image()= "Ganar nivel.png"
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		game.schedule(10000,{nivel3.iniciar()})
	}
	
	override method configurar(){}
	
	override method ganar(){}
	
}

object fondoGanarNivel3 inherits Fondos{
	
	method image()= "GGWP.png"
	
	override method iniciar(){
		game.clear()
		game.addVisual(self)
		self.configurar()
	}
	
	override method configurar() {
		keyboard.num(0).onPressDo{ game.stop()}
	}
	
	override method ganar(){}
	
}
//######################################## Fondo Jugables (Niveles de juego) ##################################3

object nivel1 inherits Fondos {
	
	const posicionesDelNivelBloques = #{
							game.at(18,66),game.at(24,66),game.at(30,66),game.at(36,66),game.at(42,66),game.at(48,66),game.at(54,66),game.at(60,66),game.at(66,66),
							game.at(18,60),game.at(30,60),game.at(54,60),game.at(66,60),
							game.at(6,54),game.at(12,54),game.at(30,54),game.at(36,54),game.at(42,54),game.at(54,54),game.at(60,54),game.at(78,54),
							game.at(30,48),game.at(42,48),game.at(54,48),game.at(66,48),game.at(78,48),
							game.at(6,42),game.at(12,42),game.at(24,42),game.at(42,42),game.at(48,42),game.at(54,42),game.at(60,42),game.at(72,42),game.at(78,42),
							game.at(6,36),game.at(18,36),game.at(30,36),game.at(42,36),game.at(54,36),game.at(66,36),game.at(78,36),
							game.at(6,30),game.at(12,30),game.at(18,30),game.at(24,30),game.at(30,30),game.at(36,30),game.at(42,30),game.at(60,30),game.at(66,30),game.at(72,30),game.at(78,30),
							game.at(6,24),game.at(18,24),game.at(54,24),game.at(66,24),game.at(78,24),
							game.at(6,18),game.at(12,18),game.at(24,18),game.at(30,18),game.at(36,18),game.at(48,18),game.at(54,18),game.at(60,18),game.at(66,18),game.at(72,18),game.at(78,18),
							game.at(18,12),game.at(30,12),game.at(42,12),
							game.at(18,6),game.at(24,6),game.at(30,6),game.at(36,6),game.at(42,6),game.at(48,6),game.at(54,6),game.at(60,6),game.at(66,6)
							} 
	
	const posicionesDelNivelEnemigos = #{game.at(66,6),game.at(66,66),game.at(30,60),game.at(6,6)}
	
	const posicionesDelNivelPowerUp = [game.at(42,48),game.at(36,66),game.at(36,30)]
	
	method image() = "fondo.png"
	
	override method iniciar(){
		
		musica.musicaMenu().stop()
		
		game.clear()
		game.addVisual(self)
		
		creador.crearPowerUp(posicionesDelNivelPowerUp)
		creador.creacionBloques(posicionesDelNivelBloques)
		creador.creacionEnemigos(posicionesDelNivelEnemigos,2000,self)
		
		if(animaciones.animaciones()){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
			
		self.configurar()
		
		musica.musicaJuego1().shouldLoop(true)
		musica.musicaJuego1().play()
		musica.musicaJuego1().volume(0.3)
		
	}
	
	override method ganar(){
		
		if(contadorDeEnemigos == 0){
			game.schedule(5000,{
				game.clear()
				musica.musicaJuego1().stop()
				fondoGanarNivel1.iniciar()
			})
			
		}
	}	
}

object nivel2 inherits Fondos {
	
	const posicionesDelNivelBloques = #{
							game.at(6,66),game.at(12,66),game.at(18,66),game.at(24,66),game.at(30,66),game.at(36,66),game.at(42,66),game.at(48,66),game.at(54,66),game.at(60,66),game.at(72,66),game.at(78,66),
							game.at(6,66),game.at(18,60),game.at(30,60),game.at(54,60),game.at(66,60),game.at(78,60),
							game.at(6,54),game.at(12,54),game.at(18,54),game.at(24,54),game.at(30,54),game.at(54,54),game.at(60,54),game.at(66,54),game.at(72,54),game.at(78,54),
							game.at(30,48),game.at(42,48),game.at(54,48),game.at(66,48),game.at(78,48),
							game.at(6,42),game.at(12,42),game.at(24,42),game.at(42,42),game.at(48,42),game.at(54,42),game.at(60,42),game.at(72,42),game.at(78,42),
							game.at(6,36),game.at(18,36),game.at(30,36),game.at(42,36),game.at(54,36),game.at(66,36),game.at(78,36),
							game.at(6,30),game.at(12,30),game.at(18,30),game.at(24,30),game.at(30,30),game.at(36,30),game.at(42,30),game.at(60,30),game.at(66,30),game.at(72,30),game.at(78,30),
							game.at(6,24),game.at(18,24),game.at(54,24),game.at(66,24),game.at(78,24),
							game.at(6,18),game.at(12,18),game.at(24,18),game.at(30,18),game.at(36,18),game.at(48,18),game.at(54,18),game.at(60,18),game.at(66,18),game.at(72,18),game.at(78,18),
							game.at(18,12),game.at(30,12),game.at(42,12),
							game.at(18,6),game.at(24,6),game.at(30,6),game.at(36,6),game.at(42,6),game.at(48,6),game.at(54,6),game.at(60,6),game.at(66,6)
	}
	
	const posicionesDelNivelEnemigos = #{game.at(66,6),game.at(66,66),game.at(30,60),game.at(66,36),game.at(42,54)}
	
	const posicionesDelNivelPowerUp = [game.at(30,36),game.at(6,42),game.at(54,66)]
	method image() = "fondo2.png"
	
	override method iniciar(){
		
		if(animaciones.animaciones()){bomber.position(game.at(6,6))}
		else{bomberSinAnimaciones.position(game.at(6,6))}
		
		game.clear()
		game.addVisual(self)
		
		creador.crearPowerUp(posicionesDelNivelPowerUp)
		creador.creacionBloques(posicionesDelNivelBloques)
		creador.creacionEnemigos(posicionesDelNivelEnemigos,1000,self)
		
		if(animaciones.animaciones()){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
		self.configurar()
		
		musica.musicaJuego2().shouldLoop(true)
		musica.musicaJuego2().play()
		musica.musicaJuego2().volume(0.3)
		
			
	}
	
	override method ganar(){
		if(contadorDeEnemigos == 0){
			game.schedule(5000,{
				game.clear()
				musica.musicaJuego2().stop()
				fondoGanarNivel2.iniciar()
			})
		}
	}	
}

object nivel3 inherits Fondos {
	
	const posicionesDelNivelBloques = #{
							game.at(6,66),game.at(12,66),game.at(42,66),game.at(48,66),game.at(54,66),game.at(60,66),game.at(72,66),
							game.at(6,66),game.at(18,60),game.at(54,60),game.at(66,60),game.at(78,60),
							game.at(6,54),game.at(12,54),game.at(18,54),game.at(24,54),game.at(30,54),game.at(48,54),game.at(54,54),game.at(60,54),game.at(66,54),game.at(72,54),game.at(78,54),
							game.at(30,48),game.at(42,48),game.at(54,48),game.at(66,48),game.at(78,48),
							game.at(6,42),game.at(12,42),game.at(24,42),game.at(42,42),game.at(48,42),game.at(54,42),game.at(60,42),game.at(78,42),
							game.at(6,36),game.at(18,36),game.at(30,36),game.at(42,36),game.at(54,36),game.at(78,36),
							game.at(6,30),game.at(30,30),game.at(36,30),game.at(42,30),game.at(60,30),game.at(66,30),game.at(72,30),game.at(78,30),
							game.at(6,24),game.at(18,24),game.at(54,24),game.at(66,24),game.at(78,24),
							game.at(6,18),game.at(12,18),game.at(24,18),game.at(48,18),game.at(54,18),game.at(60,18),game.at(66,18),game.at(72,18),game.at(78,18),
							game.at(18,12),game.at(30,12),
							game.at(18,6),game.at(24,6),game.at(30,6),game.at(36,6),game.at(42,6),game.at(48,6),game.at(54,6),game.at(60,6)
	}
	
	const posicionesDelNivelEnemigos = #{game.at(18,30),game.at(30,60),game.at(6,6),game.at(66,36),game.at(36,54),game.at(36,18)}
	
	const posicionesDelNivelPowerUp = [game.at(66,48),game.at(18,12),game.at(60,6)]
	
	method image() = "fondo3.png"
	
	override method iniciar(){
		
		if(animaciones.animaciones()){bomber.position(game.at(78,6))}
		else{bomberSinAnimaciones.position(game.at(78,6))}
		
		game.clear()
		game.addVisual(self)
		
		creador.crearPowerUp(posicionesDelNivelPowerUp)
		creador.creacionBloques(posicionesDelNivelBloques)
		creador.creacionEnemigos(posicionesDelNivelEnemigos,500,self)
		
		if(animaciones.animaciones()){game.addVisual(bomber)}
		else{game.addVisual(bomberSinAnimaciones)}
		self.configurar()	
		
		musica.musicaJuego3().shouldLoop(true)
		musica.musicaJuego3().play()
		musica.musicaJuego3().volume(0.3)
	}
	
	override method ganar(){
		if(contadorDeEnemigos == 0){
			game.clear()
			musica.musicaJuego3().stop()
			fondoGanarNivel3.iniciar()
		}
	}	
}


	



