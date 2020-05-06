import pepita.*
import wollok.game.*

object randomizer {
	
	method position() {
		return 	game.at( 
					(0).randomUpTo(game.width() - 1).truncate(0),
					(0).randomUpTo(game.height() - 1).truncate(0)
		) 
	}
	
	method emptyPosition() {
		const r = self.position()
		if(game.getObjectsIn(r).isEmpty()) {
			return r	
		}
		else {
			return self.emptyPosition()
		}
	}
}

object roque {
	
	var property position = game.origin();
	var property image = "jugador.png"
	
	var alimento = null
	
	
	method encontrar(unaComida) {
		if(alimento != null) {
			alimento.position(randomizer.emptyPosition())
			game.addVisual(alimento)
		}
		game.removeVisual(unaComida)
		alimento = unaComida
	}
	
}
