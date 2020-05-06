import wollok.game.*
import randomizer.*

object roque {
	
	var property position = game.origin();
	var property image = "jugador.png"
	
	var alimento = null
	

	method dejarComida() {
		alimento.position(randomizer.emptyPosition())
		game.addVisual(alimento)
		alimento = null
	}	
	
	method encontrar(unaComida) {
		if(alimento != null) {
			self.dejarComida()
		}
		game.removeVisual(unaComida)
		alimento = unaComida
	}
	
	method alimentar(golondrina) {
		if(alimento != null) {
			golondrina.come(alimento)
			self.dejarComida()
		}	
	}
	
}
