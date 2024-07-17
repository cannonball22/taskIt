import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_it/features/task/presentation/bloc/Task%20Bloc/src/events.dart';
import 'package:task_it/features/task/presentation/bloc/Task%20Bloc/src/states.dart';

import '../../../../../Data/Model/Task/task.model.dart';
import '../../../../../Data/Repositories/tasks.repo.dart';
import '../../../../../core/Providers/src/condition_model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepo taskRepo;

  TaskBloc({required this.taskRepo}) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) async {
      List<Task> tasks = [];
      emit(TaskLoading());
      try {
        if (event.projectIds != null) {
          for (String? projectId in event.projectIds!) {
            if (projectId != null) {
              List<Task?>? projectTasks = await taskRepo.readAllWhere([
                QueryCondition.equals(field: "projectId", value: projectId)
              ]);
              if (projectTasks != null) {
                tasks.addAll(
                    projectTasks.where((task) => task != null).cast<Task>());
              }
            }
          }
        }
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
  }
}
