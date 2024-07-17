import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import 'src/flutter_sheet_plus.dart';

export 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

export 'src/flutter_sheet_plus.dart';

class SheetHelper {
  static Future<void> showFlex(
    BuildContext context, {
    Widget? headSection,
    required Widget contentSection,
    FlutterSheetConfiguration? configuration =
        const FlutterSheetConfiguration(),
    FlutterSheetStyle? style = const FlutterSheetStyle(),
    VoidCallback? onClose,
  }) async =>
      FlutterSheetPlus.showFlex(
        context,
        contentSection: contentSection,
        headSection: headSection,
        configuration: configuration,
        onClose: onClose,
        style: style,
      );

  static Future<void> showForm(
    BuildContext context, {
    Widget Function(FormController)? headSectionBuilder,
    required Widget Function(FormController) contentSectionBuilder,
    FlutterSheetConfiguration? configuration =
        const FlutterSheetConfiguration(),
    FlutterSheetStyle? style = const FlutterSheetStyle(),
    VoidCallback? onClose,
  }) async =>
      FlutterSheetPlus.showForm(
        context,
        contentSectionBuilder: contentSectionBuilder,
        headSectionBuilder: headSectionBuilder,
        configuration: configuration,
        style: style,
        onClose: onClose,
      );

  static Future<void> showScroller(
    BuildContext context, {
    Widget? headSection,
    required Widget Function(ScrollController, ScrollPhysics)
        contentSectionBuilder,
    //
    required double initialHeightFactor,
    double? expandedHeightFactor,
    //
    FlutterSheetConfiguration? configuration =
        const FlutterSheetConfiguration(),
    FlutterSheetStyle? style = const FlutterSheetStyle(),
    VoidCallback? onClose,
  }) async =>
      FlutterSheetPlus.showScroller(
        context,
        contentSectionBuilder: contentSectionBuilder,
        initialHeightFactor: initialHeightFactor,
        headSection: headSection,
        expandedHeightFactor: expandedHeightFactor,
        configuration: configuration,
        style: style,
        onClose: onClose,
      );

  static Widget? persistent({
    required Widget Function(SolidController controller) headerBuilder,
    required Widget Function(SolidController controller) expandedHeaderBuilder,
    required Widget Function(SolidController controller) contentBuilder,
    double? headerHeight = 10,
    double? expandedHeightFactor = 1,
    bool enabled = true,
    //
    FlutterSheetConfiguration? configuration =
        const FlutterSheetConfiguration(),
    FlutterSheetStyle? style = const FlutterSheetStyle(),
  }) =>
      FlutterSheetPlus.persistent(
        headerBuilder: headerBuilder,
        expandedHeaderBuilder: expandedHeaderBuilder,
        contentBuilder: contentBuilder,
        headerHeight: headerHeight,
        expandedHeightFactor: expandedHeightFactor,
        enabled: enabled,
        configuration: configuration,
        style: style,
      );
}
