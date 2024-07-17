import 'dart:convert';

import '../Shared/status.enum.dart';

class Project {
  String id;
  String projectOwnerId;
  String title;

  String? description;
  String? deadline;

  //
  List<String?>? tasksId;
  List<String?>? assigneePictureUrl;

  //
  Status status;

  Project({
    required this.id,
    required this.title,
    required this.projectOwnerId,
    this.assigneePictureUrl,
    this.description,
    this.status = Status.toDo,
    this.deadline,
    this.tasksId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      "projectOwnerId": projectOwnerId,
      'title': title,
      "description": description,
      'status': status.index,
      'deadline': deadline,
      "tasksId": tasksId,
      "assigneePictureUrl": assigneePictureUrl,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as String,
      title: map['title'],
      projectOwnerId: map["projectOwnerId"],
      description: map["description"],
      status:
          map['status'] != null ? Status.values[map['status']] : Status.toDo,
      deadline: map['deadline'],
      tasksId: map['tasksId'] != null
          ? List<String?>.from(map['tasksId'] as List<dynamic>)
          : null,
      assigneePictureUrl: map['assigneePictureUrl'] != null
          ? List<String?>.from(map['assigneePictureUrl'] as List<dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);
}
