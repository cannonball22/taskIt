import 'package:equatable/equatable.dart';

import '../../../../../../Data/Model/Member/member.model.dart';
import '../../../../../../Data/Model/Project/project.model.dart';
import '../../../../../../Data/Model/Task/task.model.dart';
import '../../../../../../Data/Model/Team/team.model.dart';

abstract class HomeState<T> extends Equatable {
  final T? data;

  const HomeState({this.data});

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Project?>? projects;
  final List<Member?>? members;
  final List<Task?>? tasks;
  final Team? team;

  const HomeLoaded(this.projects, this.members, this.tasks, this.team);
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
