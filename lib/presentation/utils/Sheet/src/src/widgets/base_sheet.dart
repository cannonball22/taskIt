//t2 Core Packages Imports
import 'package:flutter/material.dart';

import 'package:form_controller/form_controller.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../enums/exports.dart';
//t2 Dependancies Imports
//t3 Services
//t3 Models
import '../models/exports.dart';

//t1 Exports
class BaseSheetWidget extends StatefulWidget {
  //SECTION - Widget Arguments
  final SheetType sheetType;
  //
  final FlutterSheetConfiguration sheetConfiguration;
  final FlutterSheetStyle sheetStyle;
  //
  final Widget? headSection;
  final Widget? contentSection;
  //
  final Widget Function(FormController)? headSectionFormBuilder;
  final Widget Function(FormController)? contentSectionFormBuilder;
  //
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Widget Function(ScrollController, ScrollPhysics)?
      contentSectionScrollBuilder;
  //
  final Function(SolidController)? headSectionPersistentBuilder;
  final double? persistentHeadHeight;
  final double? persistentExpandedHeightFactor;
  final Function(SolidController)? expandedHeadSectionPersistentBuilder;
  final Widget Function(SolidController)? contentSectionPersistentBuilder;
  //
  //!SECTION
  //
  const BaseSheetWidget({
    Key? key,
    this.sheetType = SheetType.flex,
    this.sheetConfiguration = const FlutterSheetConfiguration(),
    this.sheetStyle = const FlutterSheetStyle(),
    this.headSection,
    this.contentSection,
    this.contentSectionFormBuilder,
    this.contentSectionScrollBuilder,
    this.scrollController,
    this.scrollPhysics,
    this.headSectionFormBuilder,
    this.headSectionPersistentBuilder,
    this.persistentHeadHeight = 120,
    this.persistentExpandedHeightFactor = 1.0,
    this.contentSectionPersistentBuilder,
    this.expandedHeadSectionPersistentBuilder,
  })  : assert(sheetType != SheetType.form ||
            (sheetType == SheetType.form && contentSectionFormBuilder != null)),
        assert(sheetType != SheetType.scroller ||
            (sheetType == SheetType.scroller &&
                contentSectionScrollBuilder != null &&
                scrollController != null &&
                scrollPhysics != null)),
        assert(sheetType != SheetType.persistent ||
            (sheetType == SheetType.persistent &&
                headSectionPersistentBuilder != null &&
                contentSectionPersistentBuilder != null)),
        super(
          key: key,
        );

  @override
  State<BaseSheetWidget> createState() => _BaseSheetWidgetState();
}

class _BaseSheetWidgetState extends State<BaseSheetWidget> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  late FormController _formController;
  late SolidController _solidController;
  //t2 --Controllers
  //
  //t2 --State
  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    _formController = FormController();
    _solidController = SolidController();
    //t2 --Controllers & Listeners
    //
    //t2 --State
    //t2 --State
    //!SECTION
  }

  //SECTION - Stateless functions
  double _heightToOpacity(double currentHeight, double maxHeight) {
    return currentHeight / maxHeight;
  }
  //!SECTION

  //SECTION - Action Callbacks
  //!SECTION

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    // double _w = MediaQuery.of(context).size.width;
    // double _h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    List<Widget> flexChildren = [
      widget.headSection != null
          ? ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                    widget.sheetConfiguration.location == SheetLocation.top
                        ? 0
                        : widget.sheetStyle.radius ?? 24),
                bottom: Radius.circular(
                    widget.sheetConfiguration.location == SheetLocation.bottom
                        ? 0
                        : widget.sheetStyle.radius ?? 24),
              ),
              child: Container(
                  padding: widget.sheetStyle.headSectionPadding ??
                      const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 18.0,
                      ),
                  child: widget.headSection!),
            )
          : Container(),
      Container(
        color: widget.sheetStyle.contentSectionColor ?? Colors.white,
        padding: widget.sheetStyle.contentSectionPadding ??
            const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 18.0,
            ),
        child: widget.contentSection ?? Container(),
      ),
    ];
    //
    //--------
    //
    List<Widget> formChildren = [
      widget.headSectionFormBuilder != null
          ? ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                    widget.sheetConfiguration.location == SheetLocation.top
                        ? 0
                        : widget.sheetStyle.radius ?? 24),
                bottom: Radius.circular(
                    widget.sheetConfiguration.location == SheetLocation.bottom
                        ? 0
                        : widget.sheetStyle.radius ?? 24),
              ),
              child: Container(
                width: double.infinity,
                color: widget.sheetStyle.headSectionColor,
                padding: widget.sheetStyle.headSectionPadding ??
                    const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 18.0,
                    ),
                child: FutureBuilder(
                    future: Future.delayed(
                      const Duration(milliseconds: 250),
                    ),
                    builder: (context, snapshot) {
                      return widget.headSectionFormBuilder!(_formController);
                    }),
              ),
            )
          : Container(),
      Container(
        padding: widget.sheetStyle.contentSectionPadding ??
            const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 18.0,
            ),
        color: widget.sheetStyle.contentSectionColor,
        child: widget.contentSectionFormBuilder != null
            ? widget.contentSectionFormBuilder!(_formController)
            : Container(),
      ),
    ];
    //
    //--------
    //
    List<Widget> scrollerChildren = [
      ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.sheetStyle.radius ?? 24),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: widget.sheetStyle.headSectionColor ?? Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(widget.sheetStyle.radius ?? 24),
            ),
          ),
          padding: widget.sheetStyle.headSectionPadding,
          width: double.infinity,
          child: widget.headSection ?? Container(),
        ),
      ),
      Expanded(
        child: Container(
          padding: widget.sheetStyle.contentSectionPadding,
          width: double.infinity,
          color: widget.sheetStyle.contentSectionColor ?? Colors.white,
          child: widget.contentSectionScrollBuilder != null
              ? widget.contentSectionScrollBuilder!(
                  widget.scrollController!, widget.scrollPhysics!)
              : Container(),
        ),
      ),
    ];
    //--------
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return
        // ------------------------------------- FLEX
        widget.sheetType == SheetType.flex
            ? Container(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.sheetStyle.headSectionColor ?? Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(widget.sheetConfiguration.location ==
                              SheetLocation.top
                          ? 0
                          : widget.sheetStyle.radius ?? 24),
                      bottom: Radius.circular(
                          widget.sheetConfiguration.location ==
                                  SheetLocation.bottom
                              ? 0
                              : widget.sheetStyle.radius ?? 24),
                    ),
                  ),
                  child: Column(
                    children: flexChildren,
                  ),
                ))
            :
            // ------------------------------------- //
            //
            // ------------------------------------- FORM
            widget.sheetType == SheetType.form
                ? Container(
                    color: Colors.transparent,
                    child: Form(
                      key: _formController.key,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                                widget.sheetConfiguration.location ==
                                        SheetLocation.top
                                    ? 0
                                    : widget.sheetStyle.radius ?? 24),
                            bottom: Radius.circular(
                                widget.sheetConfiguration.location ==
                                        SheetLocation.bottom
                                    ? 0
                                    : widget.sheetStyle.radius ?? 24),
                          ),
                        ),
                        child: Column(
                          children: widget.sheetConfiguration.location ==
                                  SheetLocation.top
                              ? formChildren.reversed.toList()
                              : formChildren,
                        ),
                      ),
                    ))
                :
                // ------------------------------------- //
                //
                // ------------------------------------- Scroller
                widget.sheetType == SheetType.scroller
                    ? ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(widget.sheetStyle.radius ?? 24),
                        ),
                        child: Column(
                          children: scrollerChildren,
                        ),
                      )
                    :
                    // ------------------------------------- //
                    //
                    // ------------------------------------- Persistent
                    widget.sheetType == SheetType.persistent
                        ? SolidBottomSheet(
                            showOnAppear: _solidController.isOpened,
                            minHeight: 0,
                            maxHeight: (MediaQuery.of(context).size.height *
                                    widget.persistentExpandedHeightFactor!) -
                                widget.persistentHeadHeight!
                            // -
                            // (widget.sheetConfiguration.safeAreaAware!
                            //     ? MediaQuery.of(context).viewPadding.top
                            //     : 0
                            // )
                            ,
                            draggableBody: true,
                            controller: _solidController,
                            onShow: () {
                              setState(() {});
                            },
                            onHide: () {
                              setState(() {});
                            },
                            headerBar: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                  widget.sheetStyle.radius ?? 24,
                                ),
                              ),
                              child: StreamBuilder<double>(
                                  stream: _solidController.heightStream,
                                  builder: (context, heightStream) {
                                    double height = heightStream.data ?? 0;
                                    double maxHeight = (MediaQuery.of(context)
                                                .size
                                                .height *
                                            widget
                                                .persistentExpandedHeightFactor!) -
                                        widget.persistentHeadHeight!;

                                    return Container(
                                      padding:
                                          widget.sheetStyle.headSectionPadding,
                                      decoration: BoxDecoration(
                                        color: widget
                                                .sheetStyle.headSectionColor ??
                                            Colors.grey[200],
                                      ),
                                      width: double.infinity,
                                      height: widget.persistentHeadHeight!,
                                      child: Stack(
                                        children: [
                                          Opacity(
                                            opacity: 1 -
                                                _heightToOpacity(
                                                    height, maxHeight),
                                            child: widget
                                                .headSectionPersistentBuilder!(
                                              _solidController,
                                            ),
                                          ),
                                          Opacity(
                                            opacity: _heightToOpacity(
                                                height, maxHeight),
                                            child: widget
                                                    .expandedHeadSectionPersistentBuilder!(
                                                _solidController),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            body: Container(
                              padding: widget.sheetStyle.contentSectionPadding,
                              color: widget.sheetStyle.contentSectionColor,
                              width: double.infinity,
                              height: double.infinity,
                              child: widget.contentSectionPersistentBuilder!(
                                _solidController,
                              ),
                            ),
                          )
                        :
                        // ------------------------------------- //
                        Container();
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}
