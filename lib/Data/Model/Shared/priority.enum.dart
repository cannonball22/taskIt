import 'package:flutter/material.dart';

enum Priority { urgent, high, normal, low }

extension PriorityExtension on Priority {
  static final Map<Priority, Map<String, dynamic>> _priorityValues = {
    Priority.urgent: {
      'color': const Color(0xffFF244D),
      'label': 'Urgent priority'
    },
    Priority.high: {'color': const Color(0xffFFC905), 'label': 'High priority'},
    Priority.normal: {
      'color': const Color(0xff0070FF),
      'label': 'Normal priority'
    },
    Priority.low: {'color': const Color(0xff4F4F4F), 'label': 'Low priority'},
  };

  Map<String, dynamic> get values => _priorityValues[this]!;
}
