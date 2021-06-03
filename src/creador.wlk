import wollok.game.*
import Padre.*
import enemigos.*

object creador{
	
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
	
	method creacionBloquesNivel1(){

		posicionesBloquesNivel1.forEach({posicion =>
			
			const bloque = new Bloque(position = posicion)
			game.addVisual(bloque)
			game.whenCollideDo(bloque,{ algo => algo.colisionCon(bloque)})
			
		})
	}
		
	method creacionEnemigoNivel1(){
		const enemigo = new Enemigo(position = game.at(66,6))
		game.addVisual(enemigo)
		game.whenCollideDo(enemigo,{ algo => algo.colisionCon(enemigo)})
				 
		game.onTick(1000,"meMuevoChe",{
			
			enemigo.meMuevoSolo((1..4).anyOne())
			
			if (not enemigo.flagVida()){
				game.removeTickEvent("meMuevoChe")}
		})
	}
}