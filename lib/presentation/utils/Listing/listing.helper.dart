import 'package:flutter/material.dart';

//t2 Core Packages Imports
import 'package:auto_animated_list/auto_animated_list.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class Listing<T> extends StatefulWidget {
  //SECTION - Widget Arguments
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? separator;
  final double? separatingSpace;
  final int Function(T a, T b)? sort;
  final List<bool> Function(T)? filters;
  final Widget? emptyWidget;
  //
  final Axis? scrollDirection;
  final bool? reverse;
  final bool? primary;
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  //!SECTION
  //
  const Listing(
    this.items,
    this.itemBuilder, {
    Key? key,
    this.separator,
    this.separatingSpace,
    this.sort,
    this.filters,
    this.emptyWidget,
    //
    this.scrollDirection,
    this.physics,
    this.primary,
    this.reverse,
    this.shrinkWrap,
    this.controller,
  }) : super(
          key: key,
        );

  @override
  State<Listing<T>> createState() => _ListingState<T>();
}

class _ListingState<T> extends State<Listing<T>>
    with AutomaticKeepAliveClientMixin {
  //
  //SECTION - State Variables
  //t2 --Controllers
  //t2 --Controllers
  //
  //t2 --State
  late List<T> finalItems;
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
    //t2 --Controllers & Listeners
    //
    //t2 --State
    finalItems = widget.items;
    //t2 --State
    //!SECTION
  }

  //SECTION - Stateless functions
  //!SECTION

  //SECTION - Action Callbacks
  //!SECTION

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //SECTION - Build Setup
    //t2 -Values
    double w = MediaQuery.of(context).size.width;
    //
    // filter
    if (widget.filters != null) {
      finalItems = widget.items
          .where((e) => !widget.filters!(e).contains(false))
          .toList();
    }
    if (widget.sort != null) {
      finalItems.sort((a, b) => widget.sort!(a, b));
    }
    //t2 -Values
    //
    //t2 -Widgets
    Widget defaultEmptyWidget = const Center(
      child: Text("No data with the given filters!"),
    );
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return finalItems.isNotEmpty
        ? AutoAnimatedList<T>(
            items: finalItems,
            itemBuilder: (context, item, index, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizedBox(
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      index != 0 && widget.separator != null
                          ? widget.separator!
                          : SizedBox(
                              height:
                                  index != 0 && widget.separatingSpace != null
                                      ? widget.separatingSpace!
                                      : 0,
                            ),
                      widget.itemBuilder(context, item),
                    ],
                  ),
                ),
              );
            },
            scrollDirection: widget.scrollDirection ?? Axis.vertical,
            primary: widget.primary,
            shrinkWrap: widget.shrinkWrap ?? false,
            physics: widget.physics,
            reverse: widget.reverse ?? false,
            controller: widget.controller,
            padding: EdgeInsets.zero,
          )
        : widget.emptyWidget ?? defaultEmptyWidget;
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
