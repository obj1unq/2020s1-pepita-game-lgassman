import ciudades.*
import wollok.game.*
import randomizer.*

object pepita {
	var property energia = 100
	var property ciudad = buenosAires 

	var property position = game.at(3,3)
	var property vecesAlimentadas = 0	
	
	method image() {
		return if (self.esGrande()) "pepita-grande-raw.png" else "pepita.png"
	} 

	method come(comida) {
		energia = energia + comida.energia()
		vecesAlimentadas = vecesAlimentadas + 1
		game.say(self, "tengo " + energia + " de energia")
	}
	
	method volaHacia(unaCiudad) {
		if (unaCiudad.position() != self.position()) {
			self.move(unaCiudad.position())
			ciudad = unaCiudad
		}
		else {
			game.say(pepita, "Ya estoy ahi")
		}
	}
	
	method esGrande() { return energia > 100} 


	method energiaParaVolar(distancia) = 15 + 5 * distancia

	method move(nuevaPosicion) {
		const energiaAConsumir = self.energiaParaVolar(position.distance(nuevaPosicion))
		if(energiaAConsumir > energia) {
			self.error("me quede sin energia")
		}
		energia -= self.energiaParaVolar(position.distance(nuevaPosicion))
		self.position(nuevaPosicion)
		game.say(self, "tengo " + energia + " de energia")
	}
		
	method irAComer(alimento) {
		if(game.hasVisual(alimento)) {
			self.move(alimento.position())	
			self.come(alimento)
			game.removeVisual(alimento)
		}
	} 
	
	method volaAOtroLugar() {
		self.move(randomizer.emptyPosition())
	}
	
	
}
