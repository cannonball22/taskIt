import 'package:flutter/material.dart';

enum Status { toDo, inProgress, done }

extension StatusExtension on Status {
  static final Map<Status, Map<String, dynamic>> _statusValues = {
    Status.toDo: {'color': const Color(0xff4F4F4F), 'label': 'To do'},
    Status.inProgress: {
      'color': const Color(0xff0070FF),
      'label': 'In progress'
    },
    Status.done: {'color': const Color(0xff317F45), 'label': 'Done'},
  };

  Map<String, dynamic> get values => _statusValues[this]!;
}
