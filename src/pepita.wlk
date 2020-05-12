import ciudades.*
import wollok.game.*
import randomizer.*

object pepita {
	var property energia = 100
	var property ciudad = buenosAires 

	var property position = game.at(3,3)
	
	method image() {
		return if (self.esGrande()) "pepita-grande-raw.png" else "pepita.png"
	} 

	method come(comida) {
		energia = energia + comida.energia()
	}
	
	
	method volaHacia(unaCiudad) {
		// Responsabilidad
		if (unaCiudad.position() == self.position()) {
			self.error("Ya estoy ahi") // Lanza una excepción
		}
		self.move(unaCiudad.position())
		ciudad = unaCiudad
	}
	
	method esGrande() { return energia > 100} 

	method energiaParaVolar(distancia) = 15 + 5 * distancia

	method alcanzaLaEnergia(distancia) { 
		return energia >= self.energiaParaVolar(distancia)
	}
	
	method validarEnergiaParaDistancia(distancia) {
		if (not self.alcanzaLaEnergia(distancia)) {
			self.error("Dame de comer primero")
		}
	}

	method move(nuevaPosicion) {
		const distancia = position.distance(nuevaPosicion)		
		self.validarEnergiaParaDistancia(distancia)
		// VALIDAR ANTES DE HACER EL EFECTO
		energia -= self.energiaParaVolar(distancia)
		self.position(nuevaPosicion)
	}

	method irAComer(alimento) {
		if(game.hasVisual(alimento)) { //TODO: Lanzar excepcion
			self.move(alimento.position())	
			self.come(alimento)
			game.removeVisual(alimento)
		}
	} 
	
	method volaAOtroLugar() {
		self.move(randomizer.emptyPosition())
	}
	
	
}
