//t2 Core Packages Imports
import 'package:flutter/material.dart';

import 'package:form_controller/form_controller.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import 'src/enums/exports.dart';
import 'src/models/exports.dart';
import 'src/widgets/exports.dart';

export 'src/enums/exports.dart';
export 'src/models/exports.dart';

//t2 Dependancies Imports
//t3 Services
//t3 Models
//t1 Exports

class FlutterSheetPlus {
  //t2 FelxSheet
  static Future<void> showFlex(
    BuildContext context, {
    Widget? headSection,
    required Widget contentSection,
    FlutterSheetConfiguration? configuration =
        const FlutterSheetConfiguration(),
    FlutterSheetStyle? style = const FlutterSheetStyle(),
    VoidCallback? onClose,
  }) async {
    return BasicSheet.show(
      backgroundColor: style!.maskColor,
      backgroundOpacity: style.maskColor?.opacity ?? 0.7,
      location: configuration!.location,
      context: context,
      animationDuration:
          configuration.animationDuration ?? const Duration(milliseconds: 250),
      animationCurve: configuration.animationCurve ?? Curves.easeOut,
      child: BaseSheetWidget(
        sheetType: SheetType.flex,
        sheetConfiguration: configuration,
        sheetStyle: style,
        headSection: headSection,
        contentSection: contentSection,
      ),
    ).then((value) {
      if (onClose != null) {
        onClose.call();
      }
    });
  }

  //t2 -----------------------------------------------------------------------
  //
  //t2 FormSheet
  static Future<void> showForm(
    BuildContext context, {
    Widget Function(FormController)? headSectionBuilder,
    required Widget Function(FormController) contentSectionBuilder,
    FlutterSheetConfiguration? configuration =
        const FlutterSheetConfiguration(),
    FlutterSheetStyle? style = const FlutterSheetStyle(),
    VoidCallback? onClose,
  }) async {
    return BasicSheet.show(
      backgroundColor: style!.maskColor,
      backgroundOpacity: style.maskColor?.opacity ?? 0.7,
      location: configuration!.location,
      context: context,
      animationDuration:
          configuration.animationDuration ?? const Duration(milliseconds: 250),
      animationCurve: configuration.animationCurve ?? Curves.easeOut,
      child: BaseSheetWidget(
        sheetType: SheetType.form,
        sheetConfiguration: configuration,
        sheetStyle: style,
        headSectionFormBuilder: headSectionBuilder,
        contentSectionFormBuilder: contentSectionBuilder,
      ),
    ).then((value) {
      if (onClose != null) {
        onClose.call();
      }
    });
  }

  //t2 -----------------------------------------------------------------------
  //t2 ScrollerSheet
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
  }) async {
    StopperSheet.show(
      context: context,
      barrierColor: style!.maskColor,
      stops: expandedHeightFactor != null &&
              (expandedHeightFactor > initialHeightFactor)
          ? [initialHeightFactor, expandedHeightFactor]
              .map((s) => configuration!.safeAreaAware!
                  ? (s * MediaQuery.of(context).size.height) -
                      MediaQuery.of(context).viewPadding.top
                  : (s * MediaQuery.of(context).size.height))
              .toList()
          : [
              initialHeightFactor,
            ]
              .map((s) => configuration!.safeAreaAware!
                  ? (s * MediaQuery.of(context).size.height) -
                      MediaQuery.of(context).viewPadding.top
                  : (s * MediaQuery.of(context).size.height))
              .toList(),
      initialStop: 0,
      builder: (context, scrollController, scrollPhysics, stop) {
        return BaseSheetWidget(
          sheetType: SheetType.scroller,
          sheetConfiguration:
              configuration ?? const FlutterSheetConfiguration(),
          sheetStyle: style,
          headSection: headSection,
          contentSectionScrollBuilder: contentSectionBuilder,
          scrollController: scrollController,
          scrollPhysics: scrollPhysics,
        );
      },
    ).then((value) {
      if (onClose != null) {
        onClose.call();
      }
    });
  }

  //t2 -----------------------------------------------------------------------
  //
  //t2 PersistentSheet
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
  }) {
    return !enabled
        ? null
        : BaseSheetWidget(
            sheetType: SheetType.persistent,
            persistentExpandedHeightFactor: expandedHeightFactor,
            persistentHeadHeight: headerHeight,
            headSectionPersistentBuilder: headerBuilder,
            expandedHeadSectionPersistentBuilder: expandedHeaderBuilder,
            contentSectionPersistentBuilder: contentBuilder,
            sheetConfiguration: configuration!,
            sheetStyle: style!,
          );
  }
  //t2 -----------------------------------------------------------------------
}
