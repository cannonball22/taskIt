import 'package:equatable/equatable.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class LoadTeam extends TeamEvent {
  final String teamId;

  const LoadTeam(this.teamId);

  @override
  List<Object> get props => [teamId];
}
