import universidad.*

class Alumno {
var materiasAprobadas = []
var universidad 


method registrarMateria(materia,nota) {
  self.validarMateriaAprobada(materia,nota)
  materiasAprobadas.add(new MateriaAprobada(materiaAprobada = materia,notaMateria = nota))
}

method validarMateriaAprobada(materia,nota) {
   if (self.estaAprobadaMateria(materia)|| self.noEsNotaSuficiente(nota)){
            self.error ("No es posible registrar la materia")
        }
}
//Si tiene materia aprobada
method estaAprobadaMateria(materia) =materiasAprobadas.any({aprobada => aprobada.materia() == materia})

method noEsNotaSuficiente(nota) = nota < 7

//cantidad de materias aprobadas
method cantidadMateriasAprobadas() {
  return  materiasAprobadas.size()
}
//Promedio
method promedio() {
    return self.calculoPromedio()
}

method validarPromedio(){
    if(materiasAprobadas.isEmpty()){
    self.error("No tenes ninguna materia aprobada")
    }
} 

method calculoPromedio(){
    self.validarPromedio()
    return self.sumaDeNotas()/ materiasAprobadas.size()
}
method sumaDeNotas() {
  return materiasAprobadas.sum({materia=> materia.nota()})
}
//Todas las materias de las carreras a la que esta inscripto
method materiasDeCarreras() {
  return  universidad.carrerasDeEstudiante(self).map({carrera => carrera.materias()}).flatten()

}
method carrerasDeEstudiante(estudiante) = universidad.carreras().filter({carrera => carrera.esCursadaPor(self)})



method puedeInscribirseAMateria(materia) = self.condicionDeInscripcion(materia)

method condicionDeInscripcion(materia) {
  return    self.perteneceMateriaACarrera(materia)
       and  not self.estaAprobadaMateria(materia)
       and  not self.estaInscriptoEn(materia)
       and  self.cumpleRequisitosDe(materia)

}

method perteneceMateriaACarrera(materia) =self.materiasDeCarreras().contains(materia)

method estaInscriptoEn(materia)=materia.alumnos().contains(self) 

method estaEnListaDeEspera(materia) =materia.estudiantesEnEspera().contains(self)

method cumpleRequisitosDe(materia)=
materia.requisitos().all({requisito => self.estaAprobadaMateria(requisito)})

//Inscribir estudiante
method inscribirA(materia){
  self.validarInscripcionMateria(materia)
  materia.inscribirEstudiante(self)
}

method validarInscripcionMateria(materia) {
  if(materia.estaCursandoEstudiante(self)|| materia.estaEnListaDeEspera(self)){
    self.error ("No te podes inscribir")
  }
}

//Las materias a la que esta inscripto y a las que esta en lista de espera
method materiasInscripto() = self.materiasDeCarreras().filter({materia => materia.alumnos().contains(self)})

method materiasListaDeEspera() = 
self.materiasDeCarreras().filter({materia => materia.estudiantesEnEspera().contains(self)}) 

//Todas las materias a la que se puede inscribir

method posibilidadDeCursado(carrera){
  self.validarCursado(carrera)
  return carrera.materias().filter({materia=> self.puedeInscribirse(materia)})
} 
method validarCursado(carrera) {
  if(not carrera.esCursadaPor(self)){
    self.error("No esta cursando esta carrera")
  }
}

method puedeInscribirse(materia) = not self.estaInscriptoEn(materia)
                              and  not self.estaEnListaDeEspera(materia)
                              and  self.cumpleRequisitosDe(materia)

}



class MateriaAprobada{
    const materiaAprobada 
    const notaMateria 

    method materia() =materiaAprobada
    method nota() =notaMateria  
}