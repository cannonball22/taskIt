import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {
  final List<String>? projectIds;

  const LoadTasks(this.projectIds);

  @override
  List<Object> get props => [projectIds ?? []];
}
