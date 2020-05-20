import wollok.game.*
import randomizer.*

class Manzana {
	var property position = game.at(5,5)
	method image() = "manzana.png"
	
	method energia() = 80
	
	method comido() {
		generadorAlimento.remove(self)
	}
}

class Alpiste {
	var property position = game.at(5,1)
	var property energia = 5
	method image() {
		return "alpiste" + self.prefijo() + ".png"
	} 
	
	method comido() {
		generadorAlimento.remove(self)
	}
	
	method prefijo() {
		return if (self.energia() > 50)  "Poderoso" else ""
	}

}


object alpisteFactory {
	method nuevo() {
		return new Alpiste( position=randomizer.emptyPosition(), 
									 energia=0.randomUpTo(100).truncate(0)) 
	}
}

object manzanaFactory {
	method nuevo() {
		return new Manzana( position=randomizer.emptyPosition()) 
	}
}


object generadorAlimento {
	const generated = #{}
	const factories = [alpisteFactory, manzanaFactory]
	const max = 5
	
	method action() {
		if(generated.size() < max) {
			self.generate()
		}
	}
	
	method generate() {
		const alimento = self.elegirAlimento().nuevo()
		generated.add(alimento)
		game.addVisual(alimento)
		game.say(alimento, "aporto " + alimento.energia() )
		game.onCollideDo(alimento, {jugador => jugador.encontrar(alimento)})
	}
	
	method elegirAlimento() {
		return factories.get((0..factories.size() - 1).anyOne());
	}

	method remove(alimento) {
		if(game.hasVisual(alimento)){
			game.removeVisual(alimento)
		}
		generated.remove(alimento)
	}
		
}
