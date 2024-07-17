// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../enums/location.enum.dart';

class FlutterSheetConfiguration {
  final SheetLocation? location;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final bool? dismissOnBack;
  final bool? dismissOnInteraction;
  final bool? safeAreaAware;

  const FlutterSheetConfiguration({
    this.location = SheetLocation.bottom,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.ease,
    this.dismissOnBack = false,
    this.dismissOnInteraction = true,
    this.safeAreaAware = true,
  });
}
