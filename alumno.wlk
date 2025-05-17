class Alumno {
var nombre =""
var carreras=[]
var materiasAprobadas = []
//var promedio = 0
var cantMateriasAprobadas = 0


method registrarMateria(materia,nota) {
  self.validarMateriaAprobada(materia,nota)
  materiasAprobadas.add(new MateriaAprobada(materiaAprobada = materia,notaMateria = nota))
}

method validarMateriaAprobada(materia,nota) {
   if (self.estaAprobadaMateria(materia)|| self.noEsNotaSuficiente(nota)){
            self.error ("No es posible registrar la materia")
        }
}

method estaAprobadaMateria(materia) =materiasAprobadas.any({aprobada => aprobada.materia() == materia})

method noEsNotaSuficiente(nota) = nota < 7


method cantidadMateriasAprobadas() {
  cantMateriasAprobadas = materiasAprobadas.size()
}

method promedio() {
    self.calculoPromedio()
}

method validarPromedio(){
    if(cantMateriasAprobadas == 0){
    self.error("No tenes ninguna materia aprobada")
    }
} 

method calculoPromedio(){
    self.validarPromedio()
    return self.sumaDeNotas()/ cantMateriasAprobadas
}
method sumaDeNotas() {
  return materiasAprobadas.sum({materia=> materia.nota()})
}

}
/*
Ver si eliminar algunas variables
*/

class MateriaAprobada{
    const materiaAprobada 
    const notaMateria 

    method materia() =materiaAprobada
    method nota() =notaMateria  
}