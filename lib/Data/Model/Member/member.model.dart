import 'dart:convert';

class Member {
  String id;
  String email;
  String? fcmToken;
  String fullName;
  String? pictureURL;
  String? teamId;

  //
  //
  Member({
    required this.id,
    required this.fullName,
    required this.email,
    this.pictureURL,
    this.fcmToken,
    this.teamId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullName': fullName,
      'pictureURL': pictureURL,
      "fcmToken": fcmToken,
      "teamId": teamId,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'] as String,
      email: map['email'],
      fullName: map['fullName'],
      pictureURL:
          map['pictureURL'] != null ? map['pictureURL'] as String : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      teamId: map['teamId'] != null ? map['teamId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) =>
      Member.fromMap(json.decode(source) as Map<String, dynamic>);
}
