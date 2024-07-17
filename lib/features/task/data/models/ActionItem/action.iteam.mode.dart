import 'dart:convert';

class ActionItem {
  String id;
  String title;
  bool? status;

  //
  //
  ActionItem({
    required this.id,
    required this.title,
    this.status = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'status': status,
    };
  }

  factory ActionItem.fromMap(Map<String, dynamic> map) {
    return ActionItem(
      id: map['id'] as String,
      title: map['title'],
      status: map["status"],
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionItem.fromJson(String source) =>
      ActionItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
