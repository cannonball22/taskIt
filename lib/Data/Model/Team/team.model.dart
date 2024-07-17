import 'dart:convert';

class Team {
  String id;
  String teamOwnerId;
  List<String?>? projectsIds;
  List<String?>? membersIds;

  //
  //
  Team({
    required this.id,
    required this.teamOwnerId,
    this.projectsIds,
    this.membersIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'teamOwnerId': teamOwnerId,
      'projectsIds': projectsIds,
      "membersIds": membersIds,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as String,
      teamOwnerId: map['teamOwnerId'] as String,
      projectsIds: map['projectsIds'] != null
          ? List<String>.from(map['projectsIds'] as List)
          : null,
      membersIds: map['membersIds'] != null
          ? List<String>.from(map['membersIds'] as List)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) =>
      Team.fromMap(json.decode(source) as Map<String, dynamic>);
}
