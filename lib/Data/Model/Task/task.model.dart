import 'dart:convert';

import '../Shared/priority.enum.dart';
import '../Shared/status.enum.dart';

class Task {
  String id;
  String title;
  String? projectName;
  List<String?>? actionItemsIds;
  String? projectId; // project task
  String? assigneeId;
  String? assigneeName;
  String? assigneePictureUrl;

  //
  Status? status;

  //
  String? deadline;

  //
  Priority? priority;

  //

  Task({
    required this.id,
    this.projectId,
    this.assigneeId,
    this.assigneeName,
    this.assigneePictureUrl,
    required this.title,
    this.projectName,
    this.status,
    this.deadline,
    this.actionItemsIds,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      "projectName": projectName,
      'status': status?.index,
      'deadline': deadline,
      "priority": priority?.index,
      "projectId": projectId,
      "assigneeId": assigneeId,
      "assigneeName": assigneeName,
      "assigneePictureUrl": assigneePictureUrl,
      "actionItemsIds": actionItemsIds,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'],
      projectName: map["projectName"],
      status: map['status'] != null ? Status.values[map['status']] : null,
      deadline: map['deadline'],
      priority:
          map['priority'] != null ? Priority.values[map['priority']] : null,
      projectId: map['projectId'],
      assigneeId: map['assigneeId'],
      assigneeName: map['assigneeName'] != null ? map['assigneeName'] : null,
      assigneePictureUrl:
          map['assigneePictureUrl'] != null ? map['assigneePictureUrl'] : null,
      actionItemsIds: map['actionItemsIds'] != null
          ? List<String?>.from(map['actionItemsIds'] as List<dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);
}
