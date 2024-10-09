import 'dart:io';
import 'BatlleSimulator.dart';
import 'Senamon.dart';
import 'Trainer.dart';

List<Trainer> createTrainers(){
  List<Trainer> trainers = [];
  print("""\n
--------------------------------------------
        CREAR ENTRENADORES
1. Jugar con entrenadores predeterminados
2. Crear nuevos entrenadores
--------------------------------------------
""");
  int option;
  do {
    option = int.parse(stdin.readLineSync()!);
    switch(option){
      case 1:
      print("------------------------------------------------------");
        print("Se han elegido los entrenadores predeterminados");
        trainers = [
          Trainer('Ash Ketchum', 'ash.ketchum@pokemon.com', DateTime(1987, 5, 1), 0, 0, []),
          Trainer('Misty', 'misty@ceruleangym.com', DateTime(1988, 8, 15), 0, 0, [])
        ];

        break;
      
      case 2:
        print("""
------------------------------------------------------
          CREACIÓN DE LOS ENTRENADORES
""");
        for (var i = 0; i < 2; i++) {
          print("++++++++++++++++++++++++++++++++");
          print("Entrenador #${i + 1}");
          print("++++++++++++++++++++++++++++++++");

          print("1. Ingrese el nombre del entrenador");
          String name = stdin.readLineSync()!;

          print("2. Ingrese el email de $name");
          String email = stdin.readLineSync()!;


          print("3. Ingrese el día de nacimiento de $name");
          int day = int.parse(stdin.readLineSync()!);

          print("4. Ingrese el número de mes de nacimiento de $name");
          int month = int.parse(stdin.readLineSync()!);

          print("5. Ingrese el año de nacimiento de $name");
          int year = int.parse(stdin.readLineSync()!);

          DateTime birthDate = DateTime(year, month, day);


          Trainer trainer = Trainer(name, email, birthDate, 0, 0, []);

          print("Se ha creado el entrenador: $name");

          trainers.add(trainer);
        }

        break;

      default:
        print("\nIngrese una opción válida");
        break;
    }
    
  } while (option != 2 && option != 1);

  print("------------------------------------------------------");

  return trainers;

}

void showTrainers(List<Trainer> trainers){
  print("""\n
_________________________________
       Entrenadores en juego
  """);
  for (var i = 0; i < trainers.length; i++) {
    print("${i + 1}. ${trainers[i].getName()}");
  }
  print("_________________________________");
}

void selectSenamons(List<Trainer> trainers){
  print("""
-----------------------------------------------
          SELECCIÓN DE SENAMONES
""");
  for (var i = 0; i < trainers.length; i++) {
    trainers[i].selectSenamons();
  }
  print("-----------------------------------------------");
}

int indexValidation(List<dynamic> list){
  int index = int.parse(stdin.readLineSync()!) - 1;
  do {
    if (index < 0 || index >= list.length) {
      print("Posición inválida, ingrese una posición correcta");
      index = int.parse(stdin.readLineSync()!);
    }
  } while (index < 0 || index >= list.length);

  return index;
}

/*
------------------------------------------------------------------
MENÚ SENAMON
-----------------------------------------------------------------
*/

void mainSenamon(List<Trainer> trainers){
  int option;
  do {

    print("Ingrese el entrenador que desea seleccionar");
    showTrainers(trainers);
    int indexTrainer = indexValidation(trainers);

    print("""\n
---------------------------------------------------
              MENÚ MUNDO SENAMON

            1. Menú entrenadores
            2. Menú Senamones
            3. Salir
----------------------------------------------------

seleccione una opción
""");

    option = int.parse(stdin.readLineSync()!);

    switch(option){
      case 1:
        mainTrainer(trainers, indexTrainer);
        break;

      case 2:
        mainSenamons(trainers, indexTrainer);
        break;

      case 3:
        print("-"*100);
        break;

      default:
        print("\nIngrese una opción válida");
        break;
    }

  } while (option != 3);
}

void mainTrainer(List<Trainer> trainers, int indexTrainer){
  int option;
  do {
    print("""\n
---------------------------------------------------
                MENÚ ENTRENADORES

              1. Ver info entrenador
              2. Batalla
              3. Salir
----------------------------------------------------

seleccione una opción
""");

    option = int.parse(stdin.readLineSync()!);

    switch(option){
      case 1:
        showTrainer(trainers[indexTrainer]);
        break;

      case 2:
        battle(trainers);
        break;

      case 3:
        print("-"*100);
        break;

      default:
        print("\nIngrese una opción válida");
        break;
    }

  } while (option != 3);
}
//////////////////////////
void mainSenamons(List<Trainer> trainers, int indexTrainer){
  int option;
  do {
    print("""\n
---------------------------------------------------
                MENÚ SENAMONES

              1. Crear Senamon
              2. Ver Senamones
              3. Entrenar Senamon
              4. Seleccionar Senamon
              5. Salir
----------------------------------------------------

seleccione una opción
""");

    option = int.parse(stdin.readLineSync()!);

    switch(option){
      case 1:
        createSenamon(trainers[indexTrainer]);
        break;

      case 2:
        showSenamon(trainers[indexTrainer]);
        break;

      case 3:
        trainSenamon(trainers[indexTrainer]);
        break;

      case 4:
        selectSenamon(trainers[indexTrainer]);
        break;

      case 5:
        print("-"*100);
        break;

      default:
        print("\nIngrese una opción válida");
        break;
    }

  } while (option != 5);
}

void showTrainer(Trainer trainer){
  print("");
  trainer.showInfo();
}

void battle(List<Trainer> trainers){
  print("""\n
-----------------------------------------
            BATALLA

${trainers[0].getName()} vs ${trainers[1].getName()}
-----------------------------------------
""");
  startBattle(trainers, false);
}

void createSenamon(Trainer trainer){
  print("""
----------------------------------------
        CREACIÓN SENAMON

""");
  print("1. Ingresa el nombre del Senamon");
  String name = stdin.readLineSync()!;
  print("2. Ingresa el Nivel del Senamon");
  int level = int.parse(stdin.readLineSync()!);
  print("3. Ingresa el nombre del tipo del Senamon");
  SenamonType type = selectType();
  print("4. Ingresa el peso del Senamon");
  double weight = double.parse(stdin.readLineSync()!);
  print("5. Ingresa la cantidad de vidas que tendrá el Senamon, máximo de vidas 100");
  int health = givePoints(100);
  print("6. Ingresa la cantidad de daño que hará el Senamon");
  int attack = givePoints(100);
  print("7. Ingresa la fase en la que se encuentra el senamon");
  int phase = int.parse(stdin.readLineSync()!);
  print("8. Ingresa la enegría que tiene el Senamon");
  int energy = int.parse(stdin.readLineSync()!);
  print("Ingresa la descripción del Senamon");
  String description = stdin.readLineSync()!;

  Senamon senamon = Senamon(name, level, type, weight, health, attack, phase, energy, description);

  trainer.setGlobalSenamons(senamon);

  print("----------------------------------------");
  print("\nSe ha creado el Senamon con las siguientes características");
  senamon.showInfo();
}

void showSenamon(Trainer trainer){
  print("""
---------------------------------------
    1. Ver Senamones seleccionados
    2. Ver Senamones globales
---------------------------------------
""");
  int option = int.parse(stdin.readLineSync()!);
  switch(option){
    case 1:
      trainer.showSelectedSenamons();
      print("Ingrese el senamon que desea ver su información");
      int indexSenamon = indexValidation(trainer.getSenamons());
      trainer.getSenamons()[indexSenamon].showInfo();
      break;

    case 2:
      trainer.showGlobalSenamons();
      print("Ingrese el senamon que desea ver su información");
      int indexSenamon = indexValidation(trainer.getGobalSenamons());
      trainer.getGobalSenamons()[indexSenamon].showInfo();
      break;

    default:
      print("Ingrese una opción válida");
      break;
  }
}

void trainSenamon(Trainer trainer){
  print("");
  if (trainer.getExperienceLevel() >= 200) {
    trainer.trainSenamon();
  }else{
    print("No se puede entrenar un senamon, necesitas por lo menos 200 de experiencia");
  }
}

void selectSenamon(Trainer trainer){
  trainer.selectGlobalSenamon();
}

SenamonType selectType(){
  bool correct = false;
  for(var type in SenamonType.values){
    print("${type.name}");
  }
  String typeName = stdin.readLineSync()!;
  while (true) {
    for (var type in SenamonType.values) {
      if (typeName.toLowerCase() == type.name){
        correct = true;
        return type;
      }
    }
    if (!correct) {
      print("Ingrese un tipo de Senamon correcto");
      typeName = stdin.readLineSync()!;
    }
  }
}

int givePoints(int maxPoints){
  int points = int.parse(stdin.readLineSync()!);
  do {
    if (points > maxPoints || points < 1) {
      print("Ingrese un valor válido");
      points = int.parse(stdin.readLineSync()!);
    }
  } while (points > maxPoints || points < 1);
  return points;
}

