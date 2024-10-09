import 'Trainer.dart';
import 'functionsMain.dart';

void main(List<String> args) {
  print("""
  //////////////////////////////////
 ///      Mundo Senamon         ///
//////////////////////////////////
""");
  print("Antes de empezar es necesario asignar dos entrenadores al juego");

  //Crear y elegir a los dos entrenadores
  List<Trainer> trainers = createTrainers();

  //Mostrar los entrenadores para jugar
  print("\nEstos son los entrenadores con los que se jugará");
  showTrainers(trainers);

  //Elegir los senamones de cada entrenador
  print("\nPara poder empezar cada entrenador deberá deberá de elegir sus senamones");
  selectSenamons(trainers);

  //Menú del mundo senamon
  mainSenamon(trainers);
}