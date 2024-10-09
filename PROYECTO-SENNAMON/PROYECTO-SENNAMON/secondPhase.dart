import 'Trainer.dart';
import 'tournament.dart';

void main(List<String> args) {
  print("""
  //////////////////////////////////
 ///      Segunda fase          ///
//////////////////////////////////
""");

  List<Trainer> participants = assignParticipants();
  List<List<Trainer>> trainersTournament = assignTrainersTournament(participants);

  showAssignTrainersTournament(trainersTournament);

  tournament(trainersTournament, participants,);
}