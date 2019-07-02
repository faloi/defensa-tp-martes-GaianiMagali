import pachamama.*
import wollok.game.*

class Maiz {

	var property mix
	var property miy
	var property position
	var esAdulto = false

	// var property esOfrenda= false
	method image() {
		return "maiz_" + if(esAdulto){"adulto"}else{"bebe"} + ".png"
	}

	method tipo() {
		return "Maiz"
	}

	method regar() {
		esAdulto = true
	}

	method estaLista() {
		return esAdulto
	}

	method precio() {
		return if (pachamama.estaAgradecida()) {
			180
		} else {
			150
		}
	}

	method tieneGluten() {
		return false
	}

	method altura() {
		return if (pachamama.estaAgradecida()) {
			"Crece alto"
		} else {
			"Crece normal"
		}
	}

	method esPlanta() {
		return true
	}
	method ofrendaPachamama(){}
}

class Trigo {

	var property mix
	var property miy
	// var property esOfrenda= false
	var property position
	var property etapa = 0

	method image() {
		return "trigo_" + etapa % 4 + ".png"
	}

	method tipo() {
		return "Trigo"
	}

	method regar() {
		var sumar = if(pachamama.estaAgradecida()){2}else{1}
		etapa =  (etapa + sumar).min(3)
	}

	method estaLista() {
		return etapa % 4 >= 2
	}

	method precio() {
		return if (etapa % 4 == 2) {
			100
		} else if (etapa % 4 == 3) {
			200
		} else {
			0
		}
	}

	method tieneGluten() {
		return true
	}

	method esPlanta() {
		return true
	}
	method ofrendaPachamama(){}
}

class Tomaco {

	var property mix
	var property miy
	// var property esOfrenda= false
	var property position

	method image() {
		return "tomaco_" + if(self.estaLista()){"ok"}else{"podrido"} + ".png"
	}

	method tipo() {
		return "Tomaco"
	}

	method regar() {
	}

	method estaLista() {
		return not pachamama.estaAgradecida()
	}

	method precio() {
		return 80
	}

	method tieneGluten() {
		return false
	}

	method esPlanta() {
		return true
	}
	method ofrendaPachamama(){}
}
