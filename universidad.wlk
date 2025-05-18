import MateriasTest.*

class Universidad {

    var listaCarreras

    method carreras()= listaCarreras
}



class Carrera {
    var materias = []
    
    method materias() = materias 
    method estudianteBuscado(estudiante) = 
    materias.filter({materia => materia.estaCursandoEstudiante(estudiante)}) 

    method esCursadaPor(estudiante) = materias.any({materia => materia.estaCursandoEstudiante(estudiante)||
                                                                materia.estaEnListaDeEspera(estudiante)})


}


class Materia{
    var requisitos = []
    var cupo    = 0
    var alumnos = []
    var listaEspera = []

    method requisitos() {
      return requisitos
    }

    method inscribirEstudiante(estudiante) {
        if (self.hayCuposDisponibles()) {
            alumnos.add(estudiante)
            cupo -= 1
    } else {
         listaEspera.add(estudiante)
  }
    }

    method hayCuposDisponibles()= alumnos.size()< cupo

//Dar de baja estudiante e inscribir al primero
    method darDeBajaEstudiante(estudiante){
        self.validarBajaEstudiante(estudiante)
        self.bajarEstudiante(estudiante)
        self.inscribirEstudianteEnEspera()
    }


    method bajarEstudiante(estudiante){
        alumnos.remove(estudiante)
        cupo += 1
    } 

    method validarBajaEstudiante(estudiante) {
      if(not self.cumpleCondicionParaBaja(estudiante)){
        self.error ("No se puede bajar este estudiante")
      }
    }

    method cumpleCondicionParaBaja(estudiante) = alumnos.contains(estudiante)

    method inscribirEstudianteEnEspera() {
      self.validarInscripcionDeEstudianteEnEspera()
      self.agregarACursada(listaEspera.first())

    }

     method agregarACursada(estudiante){
      alumnos.add(estudiante)
      listaEspera.remove(estudiante)
  
     }


    method validarInscripcionDeEstudianteEnEspera(){
        if( listaEspera.isEmpty()){
            self.error("No hay nadie en la lista de espera")
        }
    }

    method alumnos()= alumnos 

    method estudiantesEnEspera() = listaEspera

    method estaCursandoEstudiante(estudiante) = alumnos.contains(estudiante)

    method estaEnListaDeEspera(estudiante) =listaEspera.contains(estudiante)
}
