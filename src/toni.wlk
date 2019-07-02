import wollok.game.*
import plantas.*
import pachamama.*

object toni {
	const property image = "toni.png"
	var x = 0
	var y = 0
	var property position = game.at(x, y)
	var property plantasSembradas = []
	var property plantasCosechables = []
	var monedasDeOro = 0
	var backUpPosicion = game.at(x, y)
	var bkX = 0
	var bkY = 0
	var plantaASembrar = "Maiz"
	
	
	method convieneCosechar(){
		return plantasSembradas.all{p => p.estaLista()}
	}

	method howAreYou() {
		return "Tengo " + monedasDeOro + " monedas de oro , me quedan " + self.cantidadParaVender() + " planta" + if(self.cantidadParaVender()>1){"s"}else{""} + " para vender" + " y " + self.cantPlantasSembradas() + " sembradas"
	}

	method cantPlantasSembradas() {
		return plantasSembradas.size()
	}

	method tipo() {
		return "toni"
	}

	method cantidadParaVender() {
		return plantasCosechables.size()
	}

	method monedasDeOro() {
		return monedasDeOro
	}

	method sembrar(planta) {
		if (not self.hayObjetoAca()) {
			plantasSembradas.add(planta)
			game.addVisualIn(planta, self.position())
		} else {
			if (self.hayPlantasAca()) {
				// bonus validaciones
				self.error("Aca ya hay una planta")
			}
		}
	}

	method regarLasPlantas() {
		self.guardarPosToni()
		plantasSembradas.forEach({ p =>
			self.moverA(p)
			p.regar()
		})
		self.recuperarPosicionAnterior()
	}

	method regarPlanta() {
		if (self.hayPlantasAca()) {
			self.plantaEnEstaPosicion().regar()
			self.recargarVisual(self.plantaEnEstaPosicion())
			game.say(self, "Listo te regué el " + self.plantaEnEstaPosicion().tipo())
		} else {
			game.say(self, "Aca no hay nada que regar...")
		}
	}

	method cosechar() {
		if (not self.hayPlantasAca()) {
			self.error("No hay plantas")
		}
		var planta = self.obtenerPlantaAca()
		if (not planta.estaLista()) {
				self.error("Esta planta no esta lista")
		} else {
			game.removeVisual(planta)
			plantasCosechables.add(planta)
			plantasSembradas.remove(planta)
		}
	}
	
	method cosecharTodo() {
		self.guardarPosToni()
		plantasSembradas.forEach({ p =>
			self.moverA(p)
			try{
				self.cosechar()
			}catch e{
			}
		})
		self.recuperarPosicionAnterior()
	}

	method moverA(objeto) {
		x = objeto.mix()
		y = objeto.miy()
		self.position(objeto.position())
	}

	method plantasListasParaCosechar() {
		return plantasCosechables
	}

	method vender(planta) {
		monedasDeOro += planta.precio()
		plantasCosechables.remove(planta)
	}

	method venderTodo() {
		if (self.hayUnMercadoAca()) {
			if (self.cantidadParaVender() > 0) {
				var monedas = self.monedasDeVenta()
				self.mercadoEnEstaPos().comprar(self)
				game.say(self, "+$" + monedas)
			}
		} else {
			self.error("No estoy en un mercado")
		}
	}

	method monedasDeVenta() {
		return plantasCosechables.sum({ p => p.precio() })
	}

	method cobrar(cuanto) {
		monedasDeOro += cuanto
	}

	method cobrarAMercado(mercado) {
		mercado.pagarACliente(self)
	}

	method paraCuantosDiasLeAlcanza() {
		return (plantasCosechables.sum({ p => p.precio() }) + monedasDeOro) / 200
	}

	method cuantoHayParaCeliacos() {
		return plantasSembradas.count({ p => not p.tieneGluten() })
	}

	method convieneRegar() {
		plantasSembradas.forEach({ p =>
			if (not p.estaLista()) {
				p.regar()
			}
		})
	}

	method up() {
		y += 1
			self.cambiarPosicion(x,y)
	}

	method down() {
		y -= 1
		if (y < 0) {
			y = game.height()-1
		}

			self.cambiarPosicion(x,y)
	}

	method right() {
		x += 1

			self.cambiarPosicion(x,y)
	}

	method left() {
		x -= 1
		if (x < 0) {
			x = game.width()-1
		}

		self.cambiarPosicion(x,y)
	}
	
	method cambiarPosicion(xx,yy){
		self.position(game.at(xx % game.width(), yy % game.height()))
	}

	
	method recargarVisual(objeto) {
		game.removeVisual(objeto)
		game.addVisualIn(objeto, objeto.position())
	}

	method guardarPosToni() {
		backUpPosicion = position
		bkX = x
		bkY = y
	}

	method recuperarPosicionAnterior() {
		self.position(backUpPosicion)
		x = bkX
		y = bkY
	}

	method crearPlantaTipo(tipo) {
		return
		if (tipo == "Maiz") {
			new Maiz(position = self.position(), mix = x, miy = y)
		} else if (tipo == "Trigo") {
			new Trigo(position = self.position(), mix = x, miy = y)
		} else {
			new Tomaco(position = self.position(), mix = x, miy = y)
		}
	}

	method sembrarVoH(esVertical) {
		self.guardarPosToni()
		var movimientos = if(esVertical){game.height()}else{game.width()}
		movimientos.times({ p =>
			if (esVertical) {
				self.up()
			} else {
				self.right()
			}
			if (not self.hayObjetoAca()) {
				self.sembrar(self.crearPlantaTipo(plantaASembrar))
			}
		})
		self.recuperarPosicionAnterior()
	}

	method cosecharVoH(esVertical) {
		self.guardarPosToni()
		var movimientos = if(esVertical){game.height()}else{game.width()}
		movimientos.times({ p =>
			try{
				self.cosechar()
			}catch e {
				console.println(e)
			}
				
			if (esVertical) {
				self.up()
			} else {
				self.right()
			}
		})
		self.recuperarPosicionAnterior()
	}

	method elegirOfrenda() {
		return plantasSembradas.filter({ p => not p.esOfrenda() })
	}

	method ofrendaPachamama() {
		if (self.cantPlantasSembradas() > 0) {
			var seleccionada = plantasSembradas.anyOne()
//			var seleccionada = plantasSembradas.last()
			console.println(seleccionada)
//			self.down()
			pachamama.recibirOfrenda(self)
			plantasSembradas.remove(seleccionada)
			game.removeVisual(seleccionada)
		}
	}

	method estoyParadoSobre() {
		return game.colliders(self)
	}

	method hayObjetoAca() {
		return self.estoyParadoSobre().size() > 0
	}

	method obtenerPlantaAca() {
		return self.estoyParadoSobre().find({ p => p.esPlanta() })
	}

	method hayPlantasAca() {
		return self.estoyParadoSobre().any({ p => p.esPlanta() })
	}

	method sobreQueEstoyParado() {
		if (self.hayObjetoAca() and self.obtenerPlantaAca() != null) {
			return "Planta"
		} else {
			return game.colliders(self).last().tipo()
		}
	}

	method plantaEnEstaPosicion() {
		return if (self.hayPlantasAca()) {
			self.obtenerPlantaAca()
		} else {
			null
		}
	}

	method esPlanta() {
		return false
	}

	method cambiarPlantaASembrar(aCual) {
		plantaASembrar = aCual
		game.say(self, aCual)
	}

	method mercadoEnEstaPos() {
		return self.estoyParadoSobre().find({ m => m.tipo() == "Mercado" })
	}

	method hayUnMercadoAca() {
		return self.estoyParadoSobre().any({ m => m.tipo() == "Mercado" })
	}

}