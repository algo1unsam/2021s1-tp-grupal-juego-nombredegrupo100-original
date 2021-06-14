import wollok.game.*
import Padre.*
import enemigos.*
import fondos.*
import bombasYFuego.*

//objeto creador, se encarga de crear todos los elementos del juego (bloques, powerUps, Enemigos)

object creador{
//############################## Posiciones de los bloques de los niveles ##############################
	const posicionesBloquesNivel1=#{
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
	const posicionesBloquesNivel2= #{
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
	const posicionesBloquesNivel3= #{
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
	
//############################## Posiciones de los enemigos de los niveles ##############################
	
	const posicionesEnemigosNivel1 = #{game.at(66,6),game.at(66,66),game.at(30,60),game.at(6,6)}
	const posicionesEnemigosNivel2 = #{game.at(66,6),game.at(66,66),game.at(30,60),game.at(66,36),game.at(42,54)}
	const posicionesEnemigosNivel3 = #{game.at(18,30),game.at(30,60),game.at(6,6),game.at(66,36),game.at(36,54),game.at(36,18)}

//############################## Posiciones de los PowerUps de los niveles ##############################

	const posicionesPowerUpNivel1 = [game.at(42,48),game.at(36,66),game.at(36,30)]
	const posicionesPowerUpNivel2 = [game.at(30,36),game.at(6,42),game.at(54,66)]
	const posicionesPowerUpNivel3 = [game.at(66,48),game.at(18,12),game.at(60,6)]

//############################## Metodo de creacion de los PowerUps, uno por cada nivel ##############################

	method crearPowerUpBomba1(){
		
		const powerBomba = new PowerUpBomba(position = posicionesPowerUpNivel1.get(0))
		
		const powerVelocidad = new PowerUpVelocidad(position = posicionesPowerUpNivel1.get(1))
		
		const powerFuego = new PowerUpFuego(position = posicionesPowerUpNivel1.get(2))
		
		game.addVisual(powerBomba)
		game.whenCollideDo(powerBomba,{ algo => algo.colisionCon(powerBomba)})
		game.addVisual(powerVelocidad)
		game.whenCollideDo(powerVelocidad,{ algo => algo.colisionCon(powerVelocidad)})
		game.addVisual(powerFuego)
		game.whenCollideDo(powerFuego,{ algo => algo.colisionCon(powerFuego)})
		
	}
	
	method crearPowerUpBomba2(){
		
		const powerBomba = new PowerUpBomba(position = posicionesPowerUpNivel2.get(0))
		
		const powerVelocidad = new PowerUpVelocidad(position = posicionesPowerUpNivel2.get(1))
		
		const powerFuego = new PowerUpFuego(position = posicionesPowerUpNivel2.get(2))
		
		game.addVisual(powerBomba)
		game.whenCollideDo(powerBomba,{ algo => algo.colisionCon(powerBomba)})
		game.addVisual(powerVelocidad)
		game.whenCollideDo(powerVelocidad,{ algo => algo.colisionCon(powerVelocidad)})
		game.addVisual(powerFuego)
		game.whenCollideDo(powerFuego,{ algo => algo.colisionCon(powerFuego)})
		
	}
	
	method crearPowerUpBomba3(){
		
		const powerBomba = new PowerUpBomba(position = posicionesPowerUpNivel3.get(0))
		
		const powerVelocidad = new PowerUpVelocidad(position = posicionesPowerUpNivel3.get(1))
		
		const powerFuego = new PowerUpFuego(position = posicionesPowerUpNivel3.get(2))
		
		game.addVisual(powerBomba)
		game.whenCollideDo(powerBomba,{ algo => algo.colisionCon(powerBomba)})
		game.addVisual(powerVelocidad)
		game.whenCollideDo(powerVelocidad,{ algo => algo.colisionCon(powerVelocidad)})
		game.addVisual(powerFuego)
		game.whenCollideDo(powerFuego,{ algo => algo.colisionCon(powerFuego)})
		
	}
	
//############################## Metodo de creacion de los bloques, uno por cada nivel ##############################
	
	method creacionBloquesNivel1(){
		
		posicionesBloquesNivel1.forEach({posicion =>
			
			const bloque = new Bloque(position = posicion)
			game.addVisual(bloque)
			game.whenCollideDo(bloque,{ algo => algo.colisionCon(bloque)})
			
		})
	}
	
	method creacionBloquesNivel2(){

		posicionesBloquesNivel2.forEach({posicion =>
			
			const bloque = new Bloque(position = posicion)
			game.addVisual(bloque)
			game.whenCollideDo(bloque,{ algo => algo.colisionCon(bloque)})
			
		})
	}
	
	method creacionBloquesNivel3(){

		posicionesBloquesNivel3.forEach({posicion =>
			
			const bloque = new Bloque(position = posicion,image ="bloque2.png")
			
			game.addVisual(bloque)
			
			game.whenCollideDo(bloque,{ algo => algo.colisionCon(bloque)})
			
		})
	}
	
//############################## Metodo de creacion de los enemigos, uno por cada nivel ##############################
		
	method creacionEnemigoNivel1(){
		
		posicionesEnemigosNivel1.forEach({posicion =>
		const enemigo = new Enemigo(position = posicion, velocidad = 2000)
		game.addVisual(enemigo)
		game.whenCollideDo(enemigo,{ algo => algo.colisionCon(enemigo)})
		enemigo.iniciarMovimiento()
		})
		nivel1.contadorDeEnemigos(posicionesEnemigosNivel1.size())
	}
	
	method creacionEnemigoNivel2(){
		posicionesEnemigosNivel2.forEach({posicion =>
		const enemigo = new Enemigo(position = posicion, velocidad = 1000)
		game.addVisual(enemigo)
		game.whenCollideDo(enemigo,{ algo => algo.colisionCon(enemigo)})
		enemigo.iniciarMovimiento() 
		})
		nivel2.contadorDeEnemigos(posicionesEnemigosNivel2.size())
	}
	
	method creacionEnemigoNivel3(){
		posicionesEnemigosNivel3.forEach({posicion =>
		const enemigo = new Enemigo(position = posicion, velocidad = 500)
		game.addVisual(enemigo)
		game.whenCollideDo(enemigo,{ algo => algo.colisionCon(enemigo)})
		enemigo.iniciarMovimiento() 
		})
		nivel3.contadorDeEnemigos(posicionesEnemigosNivel3.size())
	}
}
