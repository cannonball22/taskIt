import '../../../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../models/ActionItem/action.iteam.mode.dart';

class ActionItemsRepo extends FirestoreRepo<ActionItem> {
  ActionItemsRepo()
      : super(
          'Action Items',
        );

  @override
  ActionItem? toModel(Map<String, dynamic>? item) =>
      ActionItem.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(ActionItem? item) => item?.toMap() ?? {};
}
