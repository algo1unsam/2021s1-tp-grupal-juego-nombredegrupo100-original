import Padre.*
import wollok.game.*
import bomber.*

//Clase Bomba, clase de, como si nombre lo indica, las bombas
class Bomba inherits Elementos {
	
	var property image = "bomba.png"
	const property position
	const property imagenesExplosion = ["bomba2.png","bomba3.png"]
	const property velocidad = 1000
	var property rango = 1

//Metodos de condicion, estos se usan para la extension del fuego
	method condicionArriba(n){
		const destino = self.position().up(6 * n)
		return destino.y() <=  66 and not game.getObjectsIn(game.origin()).first().bloquesProhibidos().contains(destino)
	}
	
	method condicionAbajo(n){
		const destino = self.position().down(6 * n)
		return destino.y() >= 6 and not game.getObjectsIn(game.origin()).first().bloquesProhibidos().contains(destino) 
	}
	
	method condicionIzquierda(n){
		const destino = self.position().left(6 * n)
		return destino.x() >=  6 and not game.getObjectsIn(game.origin()).first().bloquesProhibidos().contains(destino)
	}
	
	method condicionDerecha(n){
		const destino = self.position().right(6 * n)
		return destino.x() <= 13*6 and not game.getObjectsIn(game.origin()).first().bloquesProhibidos().contains(destino)		
	}
	
//###############################################################################################	

//metodo que inicia la explosion de la bomba cuando se la coloca
	method iniciarExplosion(){
		var i = 0
		
		game.onTick(velocidad,"iniciarExplosion",{
			if(i > 1){
				game.removeVisual(self)
				self.explotar()								//se encarga del fuego
				
				if(game.hasVisual(bomber)){
					bomber.reiniciarBomba(self.position())
				}else{
					bomberSinAnimaciones.reiniciarBomba(self.position())
				}
				game.removeTickEvent("iniciarExplosion")
			} 
			else{
				self.image(imagenesExplosion.get(i))
				i += 1
			}
		})
	}

//metodo que se encarga de la creacion de los fuegos generados por la bomba (tiene un para de problemas, genera lag cuando explota la bomba)
	method explotar(){

//lista de todos los fuegos generados por la bomba
		const fuegoExplosion = []
		
//flags usados pra la expansion de la bomba
		var flagArriba = false
		var flagAbajo = false
		var flagIzquierda = false
		var flagDerecha = false

//creacion de todos los fuegos	

//Centro
		fuegoExplosion.add(new Fuego(position =self.position()))

//Arriba
		(1 .. rango).forEach{n => 
			if(not flagArriba  and self.condicionArriba(n) ){
				fuegoExplosion.add(new Fuego(position = self.position().up( 6 * n ) ))
			}else{flagArriba = true}
		}

//Abajo
		(1 .. rango).forEach{n =>
			if(not flagAbajo  and self.condicionAbajo(n)){
			 fuegoExplosion.add(new Fuego(position = self.position().down( 6 * n ) ))
			 }else{flagAbajo = true}
		}

//Izquierda
		(1 .. rango).forEach{n =>
			if(not flagDerecha and self.condicionIzquierda(n)){
			fuegoExplosion.add(new Fuego(position = self.position().left( 6 * n ) ))
			}else{flagDerecha = true}
		}		

//Derecha
		(1 .. rango).forEach{n =>
			if(not flagIzquierda and self.condicionDerecha(n)){
			 fuegoExplosion.add(new Fuego(position = self.position().right( 6 * n ) ))
			 }else{flagIzquierda = true}
		}
		
//agrega los todos los fuegos generados por la bomba al tablero e inicia la animacion de apagarse de cada fuego
		fuegoExplosion.forEach({fuego => 
			game.addVisual(fuego)
			fuego.apagarFuego()
		})
	}
	
//metodo para la colision con bomber

	override method colisionCon(objeto){
		
	}

}

//Clase Fuego, clase del fuego de la bomba
class Fuego inherits ElementosAnimadosSinMovimiento {
	
	const property position
	var property image = "bomba4.png"
	const property imagenesExplosion = ["bomba4.png","bomba5.png","bomba6.png"]
	const property velocidad = 100
	
	
//metodo que inicia el apagado del fuego, usa el metodo heredado animacionFija
	method apagarFuego() {
		self.animacionFija(velocidad,imagenesExplosion,self)
	}
	
	override method colisionCon(objeto){
		objeto.destruccion()
	}
	
}


