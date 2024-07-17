import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/Project/project.model.dart';

class ProjectRepo extends FirestoreRepo<Project> {
  ProjectRepo()
      : super(
          'Projects',
        );

  @override
  Project? toModel(Map<String, dynamic>? item) => Project.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Project? item) => item?.toMap() ?? {};
}
