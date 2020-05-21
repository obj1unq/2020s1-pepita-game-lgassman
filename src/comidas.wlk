import wollok.game.*
import randomizer.*

class Manzana {
	var property position = game.at(5,5)
	method image() = "manzana.png"
	
	method energia() = 80
	
	method fuisteComido() {
		generadorAlimento.eliminar(self)
	}

}

class Alpiste {
	var property position = game.at(5,1)
	const energia
	
	method image() {
		return "alpiste" + self.prefijo() + ".png"
	} 
	
	method prefijo() {
		return if (self.energia() > 50 ) "Poderoso" else "" 
	}
	
	method energia() {
		return energia
	} 
	
	method fuisteComido() {
		generadorAlimento.eliminar(self)
	}

}

object alpisteFactory {
	method crear() {
		return new Alpiste(position=randomizer.emptyPosition(),
						  			 energia = (1..100).anyOne())
	}
}

object manzanaFactory {
	method crear() {
		return new Manzana(position=randomizer.emptyPosition())
	}
}

object generadorAlimento {
	
	const generados = #{}
	const maximo = 5
	const factories = [manzanaFactory, alpisteFactory]
	
	method accion() {
		if(generados.size() < maximo) {
			self.generar()
		}	
	}
	
	method elegirFactory() {
		const indiceAlAzar = (0..factories.size()-1).anyOne()  
		return factories.get( indiceAlAzar)
	}
	
	method generar() {
		const alimento = self.elegirFactory().crear() 			 
		game.addVisual(alimento)
		game.say(alimento, "aporto " + alimento.energia())
		generados.add(alimento)
		game.onCollideDo(alimento, {jugador => jugador.encontrar(alimento)})
	}
	
	method eliminar(alimento) {
		generados.remove(alimento)
	}
	
		
}
