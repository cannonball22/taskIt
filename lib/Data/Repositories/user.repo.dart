import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/Member/member.model.dart';

class MemberRepo extends FirestoreRepo<Member> {
  MemberRepo()
      : super(
          'Users',
        );

  @override
  Member? toModel(Map<String, dynamic>? item) => Member.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Member? item) => item?.toMap() ?? {};
}
