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
