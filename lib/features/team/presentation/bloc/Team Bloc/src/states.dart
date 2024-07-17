import 'package:equatable/equatable.dart';

abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];
}

class TeamLoading extends TeamState {}

class TeamLoaded extends TeamState {
  @override
  List<Object> get props => [];
}

class TeamError extends TeamState {
  final String message;

  const TeamError(this.message);

  @override
  List<Object> get props => [message];
}
