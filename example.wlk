class Universidad {
  var provincia
  var honorarios

  method provinciaActual() = provincia
  method honorariosActuales() = honorarios

  method cambiarProvincia(provinciaACambiar) {
    provincia = provinciaACambiar
  }

  method cambiarHonorarios(honorarioACambiar) {
    honorarios = honorarioACambiar
  }
}

class Profesional {
  var universidadEnQueEstudiaron

  method universidadEnQueEstudiaron() = universidadEnQueEstudiaron

  method cambiarUniversidadQueEstudiaron(nuevaUniversidad) {
    universidadEnQueEstudiaron = nuevaUniversidad
  }

  method honorarios()
  method provinciasQuePuedeTrabajar()
}

class ProfesionalVinculado inherits Profesional {
  override method honorarios() = universidadEnQueEstudiaron.honorariosActuales()
  override method provinciasQuePuedeTrabajar() = [universidadEnQueEstudiaron.provinciaActual()]
}

class ProfesionalDelLitoral inherits Profesional {
  override method honorarios() = 3000
  override method provinciasQuePuedeTrabajar() = ["Entre Ríos", "Santa Fe", "Corrientes"]
}

class ProfesionalLibre inherits Profesional {
  var honorarios = 0
  const provincias = []

  override method honorarios() = honorarios
  method cambiarHonorarios(unValor) { honorarios = unValor }

  override method provinciasQuePuedeTrabajar() = provincias
  method agregarProvincia(unaProvincia) { provincias.add(unaProvincia) }
}



class Empresa {
  const profesionales = [  ]
  var honorarioDeReferencia = 0

  method honorarioDeReferencia() = honorarioDeReferencia
  method honorarioDeReferencia(unValor) { 
    honorarioDeReferencia = unValor 
  }

  method contratar(unProfesional) {
    profesionales.add(unProfesional)
  }


  method despedir(unProfesional){
   profesionales.remove(unProfesional)

  }

  method  CuantosestudiaronEnUnaUniversidadDeterminada(unaUniversidad) {
    profesionales.count({p => p.universidadEnQueEstudiaron() ==unaUniversidad })

  }

  method profesionalesCaros(){
return
    profesionales.filter({ p => p.honorarios()> self.honorarioDeReferencia()                } )
    
  }

  method universidadesFormadoras() = profesionales.map( { p => p.universidadEnQueEstudiaron(  ).asSet()      })

  method profesionarMasBarato() = profesionales.min({p => p.honorarios() })

  method esDeGenteAcotada() = profesionales.all ({ p => p.provinciasQuePuedeTrabajar().size() <=3  })


 method puedeSatisfacer(unSolicitante) = 
  profesionales.any({ p => unSolicitante.puedeSerAtendidoPor(p) })

}

class Personas{
  const provincia 
  method provinciaDondeVive() = provincia

  method puedeSerAtendidoPor(unProfesional) = 
    unProfesional.provinciasQuePuedeTrabajar().contains(provincia)




}


class Instituciones{
  const universidadesConocidas = []
  method universidadesConocidas()= universidadesConocidas

  method puedeSerAtendidoPor(unProfesional) = 
   universidadesConocidas.contains(unProfesional.universidadEnQueEstudiaron())


}


class Clubes{
  const provincias = []
  method provincias()= provincias

method puedeSerAtendidoPor(unProfesional) = 
  provincias.any({ p => unProfesional.provinciasQuePuedeTrabajar().contains(p) })


}
