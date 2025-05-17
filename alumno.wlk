class Alumno {
var nombre =""
var carreras=[]
var materiasAprobadas = []
var materiasInscripto = []


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
  return  carreras.map({carrera => carrera.materia()}).flatten()
}

method puedeInscribirseAMateria(materia) = self.condicionDeInscripcion(materia)

method condicionDeInscripcion(materia) {
  return    self.perteneceMateriaACarrera(materia)
       and  not self.estaAprobadaMateria(materia)
       and  not self.estaInscriptoEn(materia)
       and  self.cumpleRequisitosDe(materia)

}

method perteneceMateriaACarrera(materia) =self.materiasDeCarreras().contains(materia)

method estaInscriptoEn(materia)=materiasInscripto.contains(materia)

method cumpleRequisitosDe(materia)=
materia.requisitos().all({requisito => self.estaAprobadaMateria(requisito)})

//Inscribir estudiante
method inscribirA(materia){
  self.validarInscripcionMateria(materia)
  materiasInscripto.add(materia)
  materia.inscribirEstudiante(self)
}

method validarInscripcionMateria(materia) {
  if(not self.cumpleCondiciones(materia)){
    self.error ("No te podes inscribir")
  }
}
method cumpleCondiciones(materia){
  return
}

}



class MateriaAprobada{
    const materiaAprobada 
    const notaMateria 

    method materia() =materiaAprobada
    method nota() =notaMateria  
}