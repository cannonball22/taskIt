// ignore_for_file: public_member_api_docs, sort_constructors_first
//t2 Core Packages Imports
import 'package:flutter/material.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports
class FlutterSheetStyle {
  final EdgeInsets? headSectionPadding;
  final EdgeInsets? contentSectionPadding;
  final double? radius;
  //
  final Color? maskColor;
  final Color? headSectionColor;
  final Color? contentSectionColor;
  const FlutterSheetStyle({
    this.headSectionPadding =
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
    this.contentSectionPadding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
    this.radius = 24,
    this.maskColor = Colors.black38,
    this.headSectionColor = Colors.white,
    this.contentSectionColor = Colors.white,
  });
}
