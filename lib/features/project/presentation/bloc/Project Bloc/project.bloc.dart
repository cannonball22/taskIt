import 'package:bloc/bloc.dart';
import 'package:task_it/features/project/presentation/bloc/Project%20Bloc/src/events.dart';
import 'package:task_it/features/project/presentation/bloc/Project%20Bloc/src/states.dart';

import '../../../../../Data/Model/Project/project.model.dart';
import '../../../../../Data/Repositories/project.repo.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final List<String> projectIds;

  ProjectBloc({required this.projectIds}) : super(ProjectLoading()) {
    on<LoadProjects>((event, emit) async {
      List<Project?>? projects = [];
      emit(ProjectLoading());
      print("event.projectIds: ${event.projectIds}");
      try {
        if (event.projectIds.isNotEmpty) {
          for (String? projectId in event.projectIds) {
            if (projectId != null) {
              projects.add(await ProjectRepo().readSingle(projectId));
            }
          }
        }
        emit(ProjectLoaded(projects));
      } catch (e) {
        emit(ProjectError(e.toString()));
      }
    });
  }
}
