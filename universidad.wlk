object universidad {
    var carreras= []

}

class Carrera {
    var nombre
    var materias = []
    

}


class Materia{
    var nombre 
    var carrera =[]
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
    } else {
         listaEspera.add(estudiante)
  }
    }

    method hayCuposDisponibles()= not cupo == 0

//Dar de baja estudiante e inscribir al primero
    method darDeBajaEstudiante(estudiante){
        self.validarBajaEstudiante(estudiante)
        self.bajarEstudiante(estudiante)
        self.inscribirEstudianteEnEspera()
    }


    method bajarEstudiante(estudiante){
        alumnos.remove(estudiante)
        cupo =+ 1
    } 

    method validarBajaEstudiante(estudiante) {
      if(not self.cumpleCondicionParaBaja(estudiante)){
        self.error ("No se puede bajar este estudiante")
      }
    }

    method cumpleCondicionParaBaja(estudiante) = alumnos.contains(estudiante)

    method inscribirEstudianteEnEspera() {
      self.validarInscripcionDeEstudianteEnEspera()
      alumnos.add(listaEspera.first())
      listaEspera.first().inscribirA(self)
    }

    method validarInscripcionDeEstudianteEnEspera(){
        if( listaEspera.isEmpty()){
            self.error("No hay nadie en la lista de espera")
        }
    }
}
