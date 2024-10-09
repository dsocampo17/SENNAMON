import 'dart:io';
import 'dart:math';

import 'Senamon.dart';
import 'Trainer.dart';
import 'functionsMain.dart';

List<Trainer> assignTrainers(List<Trainer> trainers){
  List<Trainer> trainersBattle = [];

  for (var i = 0; i < trainers.length; i++) {

    String name = trainers[i].getName();
    String email = trainers[i].getEmail();
    DateTime birthDate = trainers[i].getBirthDate();
    int experienceLevel = trainers[i].getExperienceLevel();
    int battleWins = trainers[i].getBattleWins();
    List<Senamon> senamons = trainers[i].getSenamons();

    trainersBattle.add(Trainer(name, email, birthDate, experienceLevel, battleWins, senamons));
  }

  return trainersBattle;
}

bool coin(){
  Random random = Random();
  return random.nextBool();
}

void startBattle(List<Trainer> trainers, bool segundaFase){
  int indexTrainer = coin() ? 0:1;
  int indexTrainerEnemy = (indexTrainer == 0) ? 1:0;
  List<Trainer> trainersBattle = assignTrainers(trainers);

  print("""\n
+-------------------------+
|       Cara o cruz       |
+-------------------------+
|                         |
| Ha salido: ${coin() ? "Cara" : "Cruz"}         |
+-------------------------+

Iniciará: ${trainersBattle[indexTrainer].getName()}
""");

  print("\nAntes de iniciar se eligirá el Senamon de cada Entrenador con el cuál se iniciará la batalla");
  List<Senamon> chosenSenamons = choseSenamons(trainersBattle);
  indexTrainer = mainBattle(trainersBattle, chosenSenamons, indexTrainer, indexTrainerEnemy, segundaFase);
  print("""
-------------------------------------------
          FIN DE LA BATALLA

Ha ganado el entrenador: ${trainers[indexTrainer].getName()}
-------------------------------------------
""");
  trainers[indexTrainer].setBattleWins();
  trainers[indexTrainer].setExperienceLevel(100);
}

List<Senamon> choseSenamons(List<Trainer> trainers){
  List<Senamon> chosenSenamons = [];
  print("""
-----------------------------------------
          Elección de Senamones
                en batalla
""");
  for (var i = 0; i < trainers.length; i++) {
    print("\n${trainers[i].getName()}");
    trainers[i].showSelectedSenamons();
    print("\nSelecciona un Senamon");
    int indexSenamon = indexValidation(trainers[i].getSenamons());
    chosenSenamons.add(trainers[i].getSenamons()[indexSenamon]);
  }
  print("""

-----------------------------------------
""");
  return chosenSenamons;
}

int mainBattle(List<Trainer> trainers, List<Senamon> chosenSenamons, int indexTrainer, int indexTrainerEnemy, bool segundaFase){
  bool finish = false;
  int counter = indexTrainer;


  do{
    indexTrainer = counter % 2;
    indexTrainerEnemy = (counter+1)%2;
    //Comprobar si está muerto el Senamon elegido
    if (chosenSenamons[indexTrainer].dead()) {
      changeDeadSenamon(trainers[indexTrainer], indexTrainer, chosenSenamons);
    }
    print("""
****************************************************
              MENÚ BATALLA ${trainers[indexTrainer].getName()}
            1. Atacar
            2. Cambiar Senamon
****************************************************

Selecciona una opción...
""");
    int option = int.parse(stdin.readLineSync()!);
    switch(option){
      case 1:
        stdout.write("""\n
+------------------------------------------+
| Vida que tenía el senamon: ${chosenSenamons[indexTrainerEnemy].getHealthPoints()}${chosenSenamons[indexTrainerEnemy].getHealthPoints().toString().length == 3 ? "           |":"            |"}
""");
        chosenSenamons[indexTrainer].attack(segundaFase, chosenSenamons[indexTrainerEnemy]);
        if(chosenSenamons[indexTrainerEnemy].getHealthPoints() < 0){
          chosenSenamons[indexTrainerEnemy].setHealthPoints(0);
        }
        stdout.write("""
|  Vida que tiene ahora: ${chosenSenamons[indexTrainerEnemy].getHealthPoints()}${chosenSenamons[indexTrainerEnemy].getHealthPoints().toString().length == 2 ? "                |":"                 |"}
+------------------------------------------+
""");
        if(chosenSenamons[indexTrainerEnemy].dead()){
          if (verifyDefeat(trainers[indexTrainerEnemy].getSenamons())) {
            finish = true;
          }else{
            counter++;
          }
        }else{
          counter++;
        }
        break;

      case 2:
        changeSenamon(trainers[indexTrainer], chosenSenamons, indexTrainer);
        break;
      
      default:
        print("Seleccione una opción válida");
        break;
    }
  }while(!finish);

  return indexTrainer;
}

void changeDeadSenamon(Trainer trainer, int indexTrainer, List<Senamon> senamons){
  print("\nTu senamon está muerto, deberás de cambiarlo");
  changeSenamon(trainer, senamons, indexTrainer);
}

void changeSenamon(Trainer trainer, List<Senamon> senamons, int indexTrainer){
  trainer.showSelectedSenamons();
  print("Seleccione un senamon");
  int indexSenamon = indexValidation(trainer.getSenamons());
  do {
    if (trainer.getSenamons()[indexSenamon].dead()) {
      print("\nEste senamon está muerto, elija otro");
      indexSenamon = indexValidation(trainer.getSenamons());
    }
  } while (trainer.getSenamons()[indexSenamon].dead());
  senamons[indexTrainer] = trainer.getSenamons()[indexSenamon];
}

bool verifyDefeat(List<Senamon> senamons){
  int counter = 0;
  for (var i = 0; i < senamons.length; i++) {
    if (senamons[i].dead()) {
      counter++;
    }
  }
  return counter == 3;
}