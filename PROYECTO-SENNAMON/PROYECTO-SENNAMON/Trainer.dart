import 'dart:io';
import 'WorldSenamones.dart';
import 'Senamon.dart';
import 'functionsMain.dart';

class Trainer {
  String _name;
  String _email;
  DateTime _birthDate;
  int _experienceLevel;
  int _battleWins;
  List<Senamon> _globalSenamons = globalSenamons();
  List<Senamon> _senamons;

  Trainer(
    this._name,
    this._email,
    this._birthDate,
    this._experienceLevel,
    this._battleWins,
    this._senamons
  );

  // Set y get de _name
  String getName() => _name;
  void setName(String newName) => _name = newName;

  // Set y get de _email
  String getEmail() => _email;
  void setEmail(String newEmail) => _email = newEmail;

  // Set y get de _birthDate
  DateTime getBirthDate() => _birthDate;
  void setBirthDate(DateTime newBirthDate) => _birthDate = newBirthDate;

  // Set y get de _experienceLevel
  int getExperienceLevel() => _experienceLevel;
  void setExperienceLevel(int newExperienceLevel) => _experienceLevel += newExperienceLevel;

  // Set y get de _battleWins
  int getBattleWins() => _battleWins;
  void setBattleWins() => _battleWins++;
  
  //set y get de _globalSenamons
  List<Senamon> getGobalSenamons() => _globalSenamons;
  void setGlobalSenamons(Senamon senamon) => _globalSenamons.add(senamon);

  //set y get de _senamons
  List<Senamon> getSenamons() => _senamons;
  void setSenamons(Senamon senamon) => _senamons.add(senamon);

  //Métodos de trainer
  void deleteGlobalSenamon(int index) => _globalSenamons.removeAt(index);

  void selectSenamons(){
    print("""\n
++++++++++++++++++++++++++++++++
Seleccion del entrenador $_name   
    """);
    for (var i = 0; i < 5; i++) {
      print("");
      print("*"*30);
      showGlobalSenamons();
      print("\nIngrese la pocisión del senamon que desea seleccionar");
      int indexSenamon = indexValidation(_globalSenamons);
      setSenamons(_globalSenamons[indexSenamon]);
      deleteGlobalSenamon(indexSenamon);
    }
    print("++++++++++++++++++++++++++++++++");
  }

  void showGlobalSenamons(){
    print("""
-------------------------------------
        Senamones globales

""");
    for (var i = 0; i < _globalSenamons.length; i++) {
      print("${i + 1}. ${_globalSenamons[i].getName()}");
    }
    print("""

-------------------------------------
""");
  }

  void showInfo(){
    print("""
----------------------------------------------
        INFORMACIÓN DE $_name

        Nombre: $_name
        Email: $_email
        Edad: ${calculateAge()}
        Nivel de experiencia: $_experienceLevel
        Batallas ganadas: $_battleWins
----------------------------------------------
""");
  }

  int calculateAge(){
    DateTime now = DateTime.now();
    return now.year - _birthDate.year;
  }

  void showSelectedSenamons(){
    print("""
-------------------------------------
        Senamones elegidos

""");
    for (var i = 0; i < _senamons.length; i++) {
      print("${i + 1}. ${_senamons[i].getName()}");
    }
    print("""

-------------------------------------
""");
  }

  void trainSenamon(){
    showSelectedSenamons();
    print("Ingresa al Senamon que deseas entrenar");
    int indexSenamon;
    bool finish = false;
    do {
      indexSenamon = indexValidation(_senamons);
      print("""
  -----------------------------------------
            Entrenamiento Senamones

            1. Agregar 20 de vida
            2. Agregar 20 de daño
  ----------------------------------------
    """);
      int option = int.parse(stdin.readLineSync()!);
      switch(option){
        case 1:
          _senamons[indexSenamon].setHealthPoints(_senamons[indexSenamon].getHealthPoints() + 20);
          print("El senamon: ${_senamons[indexSenamon].getName()} ha quedado con una vida de: ${_senamons[indexSenamon].getHealthPoints()}");
          _experienceLevel -= 20;
          print("Has quedado con una experiencia de: $_experienceLevel");
          finish = true;
          break;

        case 2:
          _senamons[indexSenamon].setAttackPower(_senamons[indexSenamon].getAttackPower() + 20);
          print("El senamon: ${_senamons[indexSenamon].getName()} ha quedado con un daño de: ${_senamons[indexSenamon].getAttackPower()}");
          _experienceLevel -= 20;
          print("Has quedado con una experiencia de: $_experienceLevel");
          finish = true;
          break;

        default:
          print("Ingresa una opción válida");
          break;
      }
    } while (!finish);
  }

  void selectGlobalSenamon(){
    print("""\n
----------------------------------------
           Reemplazar Senamon
----------------------------------------
""");
  showGlobalSenamons();
  print("Ingresa el Senamon que deseas seleccionar");
  int indexSenamonSelect = indexValidation(_globalSenamons);
  showSelectedSenamons();
  print("Ingresa el Senamon que desas quitar");
  int indexSenamonDeleted = indexValidation(_senamons);
  Senamon temporalSenamon = _senamons[indexSenamonDeleted];
  _senamons[indexSenamonDeleted] = _globalSenamons[indexSenamonSelect];
  _globalSenamons[indexSenamonSelect] = temporalSenamon;

  print("\nLos senamones elegidos quedaron de la siguiente manera");

  showSelectedSenamons();
  }
}
