import wollok.game.*
import toni.*
object pachamama {

	var agradecimiento = 5
	var posiciones = [ game.at(0,game.height()-2), game.at(game.width()-2,game.height()-2), game.at(game.width()-2,0), game.at(0,0) ]
	var property position = posiciones.get(0)
	var indicePosiciones = 0

	method pasear() {
		indicePosiciones += 1
//		var nuevapos = posiciones.get(indicePosiciones % 4)
////		if(game.getObjectsIn(nuevapos).size()==1 ){
////			game.getObjectsIn(nuevapos).first().position(self.position())
////		}
		self.position(posiciones.get(indicePosiciones % 4))
	}
	method image() {
		return "pachamama-" + if(self.estaAgradecida()){""}else{"no"} + "agradecida.png"
	}

	method yoMisma(){
		return self
	}

	method llover() {
		agradecimiento += 5

	}

	method tirarBasura() {
		agradecimiento -= 10

	}

	method fumigar() {
		agradecimiento = 0

	}

	method abonar() {
		agradecimiento *= 2
	}

	method estaAgradecida() {
		return agradecimiento >= 10
	}

	method tipo() {
		return "pachamama"
	}

	method recibirOfrenda(quien) {
		if (not self.estaAgradecida()) {
			agradecimiento += 10 - agradecimiento
		}else{
			self.llover()
		}
		self.pasear()
		if ((indicePosiciones % 4)>1){
			2.times({quien.up()})
		}else{
			quien.down()
		}
	}
	method esPlanta() {
		return false
	}

}

