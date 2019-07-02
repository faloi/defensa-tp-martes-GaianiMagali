import wollok.game.*

class Mercado {

	var property monedas = 0
	var listaMercaderias = []

	method image() {
		// Modificar esto para que la imagen dependa del estado.
		return "mercado.png"
	}

	method tipo() {
		return "Mercado"
	}

	method puedoPagar(cliente) {
		return cliente.monedasDeVenta() < monedas
	}

	method pagarACliente(cliente) {
		monedas -= cliente.monedasDeVenta()
		cliente.cobrar(cliente.monedasDeVenta())
	}

	method comprar(cliente) {
		if (self.puedoPagar(cliente)) {
			cliente.cobrarAMercado(self)
			listaMercaderias.addAll(cliente.plantasCosechables())
			cliente.plantasCosechables().clear()
		} else {
			self.error("No puedo pagarte lo que vendes")
		}
	}
	
	method esPlanta() {
		return false
	}

}

