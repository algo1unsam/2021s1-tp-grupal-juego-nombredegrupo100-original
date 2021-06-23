import wollok.game.*
import Padre.*
import enemigos.*
import fondos.*
import bombasYFuego.*

//objeto creador, se encarga de crear todos los elementos del juego (bloques, powerUps, Enemigos)

object creador{	

//############################## Metodo de creacion de los PowerUps ##############################

	method crearPowerUp(posiciones){
		
		const powerBomba = new PowerUpBomba(position = posiciones.get(0))
		
		const powerVelocidad = new PowerUpVelocidad(position = posiciones.get(1))
		
		const powerFuego = new PowerUpFuego(position = posiciones.get(2))
		
		game.addVisual(powerBomba)
		game.whenCollideDo(powerBomba,{ algo => algo.colisionCon(powerBomba)})
		game.addVisual(powerVelocidad)
		game.whenCollideDo(powerVelocidad,{ algo => algo.colisionCon(powerVelocidad)})
		game.addVisual(powerFuego)
		game.whenCollideDo(powerFuego,{ algo => algo.colisionCon(powerFuego)})
		
	}

	
//############################## Metodo de creacion de los bloques ##############################
	
	method creacionBloques(posiciones){
		
		posiciones.forEach({posicion =>
			
			const bloque = new Bloque(position = posicion)
			game.addVisual(bloque)
			game.whenCollideDo(bloque,{ algo => algo.colisionCon(bloque)})
			
		})
	}

	
//############################## Metodo de creacion de los enemigos ##############################
		
	method creacionEnemigos(posiciones, velocidad, nivel){
		
		posiciones.forEach({posicion =>
		const enemigo = new Enemigo(position = posicion, velocidad = velocidad)
		game.addVisual(enemigo)
		game.whenCollideDo(enemigo,{ algo => algo.colisionCon(enemigo)})
		enemigo.iniciarMovimiento()
		})
		nivel.contadorDeEnemigos(posiciones.size())
	}
	
}
