import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/Task/task.model.dart';

class TaskRepo extends FirestoreRepo<Task> {
  TaskRepo()
      : super(
          'Tasks',
        );

  @override
  Task? toModel(Map<String, dynamic>? item) => Task.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Task? item) => item?.toMap() ?? {};
}
