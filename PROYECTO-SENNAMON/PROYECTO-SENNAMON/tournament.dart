import 'dart:io';
import 'dart:math';

import 'Trainer.dart';
import 'batlleSimulator.dart';
import 'functionsMain.dart';

List<Trainer> assignParticipants(){
  List<Trainer> trainers = [
    Trainer('Ash Ketchum', 'ash.ketchum@pokemon.com', DateTime(1987, 5, 1), 0, 0, []),
    Trainer('Misty', 'misty@ceruleangym.com', DateTime(1988, 8, 15), 0, 0, []),
    Trainer('Brock', 'brock@pewtergym.com', DateTime(1989, 4, 10), 0, 0, []),
    Trainer('May', 'may@hoenn.com', DateTime(1992, 5, 27), 0, 0, []),
    Trainer('Dawn', 'dawn@sinnoh.com', DateTime(1993, 1, 1), 0, 0, []),
    Trainer('Serena', 'serena@kalos.com', DateTime(1996, 6, 15), 0, 0, []),
    Trainer('Cynthia', 'cynthia@pokemonleague.com', DateTime(1985, 7, 24), 0, 0, []),
    Trainer('Gary Oak', 'gary.oak@palettotown.com', DateTime(1987, 6, 5), 0, 0, []),
    Trainer('Tracey Sketchit', 'tracey@orangeislands.com', DateTime(1988, 3, 12), 0, 0, []),
    Trainer('Iris', 'iris@unova.com', DateTime(1996, 12, 16), 0, 0, []),
    Trainer('Clemont', 'clemont@lumiose.com', DateTime(1995, 2, 18), 0, 0, []),
    Trainer('Lillie', 'lillie@alola.com', DateTime(1999, 3, 10), 0, 0, []),
    Trainer('Hop', 'hop@galar.com', DateTime(2000, 4, 3), 0, 0, []),
    Trainer('Chloe', 'chloe@galar.com', DateTime(2001, 8, 22), 0, 0, []),
    Trainer('Korrina', 'korrina@shaalowcity.com', DateTime(1997, 11, 19), 0, 0, []),
  ];
  List<Trainer> participants = [];
  while (true) {  
    print("""\n
  ------------------------------------
          Asignar Entrenadores

      1. Crear Entrenador
      2. Ingresar entrenador al torneo
      3. retirar entrenador del torneo
      4. Salir
  ------------------------------------

  Ingrese la opción que desea hacer
  """);
  int option = int.parse(stdin.readLineSync()!);
    switch(option){
      case 1:
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

      case 2:
        print("""
  -------------------------------
        Lista de Entrenadores


  """);
        for (var i = 0; i < trainers.length; i++) {
          print("${i + 1}. ${trainers[i].getName()}");
        }
        print("\nSeleccione el entrenador que desa ingresar");
        int indexTrainer = indexValidation(trainers);
        print("\nPara poderlo ingresar debe de elegir sus senamones");
        trainers[indexTrainer].selectSenamons();
        participants.add(trainers[indexTrainer]);
        trainers.removeAt(indexTrainer);
        print("Los participantes seleccionados por el momento son los siguientes");
        showParticipants(participants);
        break;

      case 3:
        print("""
    -------------------------------
          Lista de Participantes


    """);
          for (var i = 0; i < participants.length; i++) {
            print("${i + 1}. ${participants[i].getName()}");
          }
          print("\nSeleccione el entrenador que desa retirar");
          int indexTrainer = indexValidation(trainers);
          trainers.add(participants[indexTrainer]);
          participants.removeAt(indexTrainer);
          print("Los participantes seleccionados por el momento son los siguientes");
          showParticipants(participants);
        break;

      case 4:
        break;

      default:
        print("Opción inválida, ingresa una correcta");
        break;
    }
    if (option == 4) {
      if (participantsValidation(participants)) {
        print("Los participantes han sido ingresados correctamente");
        return participants;
      }else{
        print("La cantidad de integrantes del torneo es incorrecta, ingrese o elimine entrenadores y vuelva a intentarlo");
      }
    }
  }
}

void showParticipants(List<Trainer> participants){
  print("""\n
---------------------------------
          Participantes

""");
  for (var i = 0; i < participants.length; i++) {
    print("${i + 1}. ${participants[i].getName()}");
  }
  print("---------------------------------");
}

bool participantsValidation(List<Trainer> participants){
  if (participants.length == 0) {
    return false;
  }else if(participants.length == 1){
    return false;
  }if (participants.length == 2) {
    return true;
  }else{
    int exponent = 2;
    while (true) {
      if (participants.length == pow(2, exponent).toInt()) {
        return true;
      }else if(participants.length < pow(2, exponent).toInt()){
        return false;
      }else{
        exponent++;
      }
    }
  }
}

List<List<Trainer>> assignTrainersTournament(List<Trainer> trainers){
  List<List<Trainer>> trainersTournament = [];
  List<Trainer> trainersRound = [];
  for (var trainer in trainers) {
    if (trainersRound.length == 0 || trainersRound.length == 1) {
      trainersRound.add(trainer);
    }else{
      trainersTournament.add(trainersRound);
      trainersRound = [trainer];
    }
  }
  trainersTournament.add(trainersRound);

  return trainersTournament;
}

void showAssignTrainersTournament(List<List<Trainer>> trainers){
  print("""
--------------------------------------
        Formación del torneo

""");
  for (var trainer in trainers) {
    print("${trainer[0].getName()} vs ${trainer[1].getName()}\n");
  }
  print("--------------------------------------");
}

void tournament(List<List<Trainer>> trainersTournament, List<Trainer> participants){
  bool proceed = true;
  while (proceed) {
    for (var i = 0; i < trainersTournament.length; i++) {
      print("""
********************************************
        Batalla #${i + 1}

${trainersTournament[i][0].getName()} vs ${trainersTournament[i][1].getName()}
********************************************
""");
    startBattle(trainersTournament[i], true);
    loser(participants);
    }
    if (participants.length == 1) {
      print("""\n
-----------------------------------
          FIN DEL TORNEO      

      GANADOR: ${participants[0].getName()}
-----------------------------------
""");
      break;
    }else{
      newRound(trainersTournament, participants);
    }
  }
}

void loser(List<Trainer> participants){
  int indexTrainer = 0;
  for (var i = 0; i < participants.length; i++) {
   if (participants[i].getBattleWins() == 0) {
      indexTrainer = i;
    }
  }

  participants.removeAt(indexTrainer);
}

void newRound(List<List<Trainer>> trainersTournament, List<Trainer> participants){
  trainersTournament = [];
  assignTrainersTournament(participants);
  showAssignTrainersTournament(trainersTournament);
}