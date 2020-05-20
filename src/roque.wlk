import wollok.game.*
import randomizer.*
object roque {
	var property position = game.origin()
 	
 	const alimentos = #{}	
 	
	method image() { return "jugador.png" }
	
	method encontrar(_alimento) {
		alimentos.add(_alimento)
		game.removeVisual(_alimento)	
	}
		
	method alimentar(golondrina) {
		if(! alimentos.isEmpty()) {
			const alimento = alimentos.max({_alimento => _alimento.energia()})
			golondrina.come(alimento)	
			alimento.comido()
			alimentos.remove(alimento)
		}
		else {
			game.say(self, "No tengo alimento ahora")
		}
	}
	
	
	
	
	
	
}
