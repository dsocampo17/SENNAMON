enum SenamonType { fire, water, boil, fly, electric }

class Senamon {
  String _name;
  int _level;
  SenamonType _type;
  double _weight;
  int _healthPoints;
  int _attackPower;
  int _phase;
  int _energyLevel;
  String _description;

  Senamon(
    this._name,
    this._level,
    this._type,
    this._weight,
    this._healthPoints,
    this._attackPower,
    this._phase,
    this._energyLevel,
    this._description,
  );

  //Set y get de _name
  String getName() => _name;
  void setName(String newName) => _name = newName;

  // Set y get de _level
  int getLevel() => _level;
  void setLevel(int newLevel) => _level = newLevel;

  // Set y get de _type
  SenamonType getType() => _type;
  void setType(SenamonType newType) => _type = newType;

  // Set y get de _weight
  double getWeight() => _weight;
  void setWeight(double newWeight) => _weight = newWeight;

  // Set y get de _healthPoints
  int getHealthPoints() => _healthPoints;
  void setHealthPoints(int newHealthPoints) => _healthPoints = newHealthPoints;

  // Set y get de _attackPower
  int getAttackPower() => _attackPower;
  void setAttackPower(int newAttackPower) => _attackPower = newAttackPower;

  // Set y get de _phase
  int getPhase() => _phase;
  void setPhase(int newPhase) => _phase = newPhase;

  // Set y get de _energyLevel
  int getEnergyLevel() => _energyLevel;
  void setEnergyLevel(int newEnergyLevel) => _energyLevel = newEnergyLevel;

  // Set y get de _description
  String getDescription() => _description;
  void setDescription(String newDescription) => _description = newDescription;

  //Atacar
  void attack(bool segundaFase, Senamon enemy){
    if (!segundaFase) {
      print("|  Daño recibido: ${_attackPower}                       |");
      enemy.setHealthPoints(enemy.getHealthPoints() - _attackPower);
    }else{
      enemy.setHealthPoints(enemy.getHealthPoints() - (_attackPower*getPercentage(enemy)).toInt());
    }
  }

  //Comprobar muerte
  bool dead() => _healthPoints == 0;

  //Mostrar información del Senamon
  void showInfo(){
    print("""\n
-----------------------------------------
        Información Senamon

nombre: $_name
Nivel: $_level
Tipo: ${_type.name}
Peso: $_weight
Salud: $_healthPoints
Ataque: $_attackPower
Fase: $_phase
Energía: $_energyLevel
Descripción:
$_description
-----------------------------------------
""");
  }

  double getPercentage(Senamon enemy){
    double percentage;
    List<List<String>> typeAttacks = [
          ["poco efectivo", "poco efectivo", "efectivo", "normal", "super efectivo"],
          ["super efectivo", "poco efectivo", "poco efectivo", "efectivo", "normal"],
          ["normal", "super efectivo", "poco efectivo", "poco efectivo", "efectivo"],
          ["normal", "efectivo", "super efectivo", "poco efectivo", "poco efectivo"],
          ["poco efectivo", "normal", "efectivo", "super efectivo", "poco efectivo"]
        ];

    List<String> typeSenamons = [];
    for (var type in SenamonType.values) {
      typeSenamons.add(type.name);
    }

    int indexSenamon = 0;
    for (var i = 0; i < typeSenamons.length; i++) {
      if (_type.name == typeSenamons[i]) {
        indexSenamon = i;
      }
    }
    int indexEnemy = 0;
    for (var i = 0; i < typeSenamons.length; i++) {
      if (enemy.getType().name == typeSenamons[i]) {
        indexEnemy = i;
      }
    }


    if(typeAttacks[indexSenamon][indexEnemy] == "poco efectivo"){
      percentage = 1.1;
    }else if(typeAttacks[indexSenamon][indexEnemy] == "efectivo"){
      percentage = 1.4;
    }else if(typeAttacks[indexSenamon][indexEnemy] == "super efectivo"){
      percentage = 2;
    }else{
      percentage = 1;
    }
    print("Ataque ${typeAttacks[indexSenamon][indexEnemy]}");
    print("Ataque de tipo ${_type.name} a tipo ${enemy.getType().name}");
    print("|  Daño recibido: ${_attackPower*percentage}                       |");
    return percentage;
  }
}
