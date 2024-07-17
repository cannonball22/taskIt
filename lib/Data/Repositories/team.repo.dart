import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/Team/team.model.dart';

class TeamRepo extends FirestoreRepo<Team> {
  TeamRepo()
      : super(
          'Teams',
        );

  @override
  Team? toModel(Map<String, dynamic>? item) => Team.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Team? item) => item?.toMap() ?? {};
}
