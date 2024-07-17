import 'package:equatable/equatable.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class LoadProjects extends ProjectEvent {
  final List<String?> projectIds;

  const LoadProjects(this.projectIds);

  @override
  List<Object> get props => [projectIds ?? []];
}
