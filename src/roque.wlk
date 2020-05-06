import wollok.game.*
import randomizer.*
object roque {
	var property position = game.origin()
 	var alimento = null	
 	
	method image() { return "jugador.png" }
	
	method encontrar(_alimento) {
		if(alimento != null) {
			self.soltar()
		}
		alimento = _alimento
		game.removeVisual(alimento)	
	}
	
	method soltar() {
		alimento.position(randomizer.emptyPosition())
		game.addVisual(alimento)
		alimento = null	
	}
}
