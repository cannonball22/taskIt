import 'dart:math';

import 'package:flutter/material.dart';

/// A builder function to be passed to [StopperSheet].
typedef StopperBuilder = Widget Function(

    /// A build context
    BuildContext context,

    /// A scroll controller to be passed to a scrollable widget
    ScrollController controller,
    // A scroll physics to be passed to a scrollable widget
    ScrollPhysics physics,

    /// The current stop value.
    int stop);

/// A widget that changes its height to one of the predefined values based on user-initiated dragging.
/// Designed to be used with [showBottomSheet()] method.
class StopperSheet extends StatefulWidget {
  /// The list of stop heights in logical pixels. The values must be sorted from lowest to highest.
  final List<double>? stops;

  /// This callback function is called when the user triggers a close. If null, the bottom sheet cannot be closed by the user.
  final Function? onClose;

  /// A builder to build the contents of the bottom sheet.
  final StopperBuilder? builder;

  /// The initial stop.
  final int initialStop;

  /// The minimum offset (in logical pixels) necessary to trigger a stop change when dragging.
  final double dragThreshold;

  ///
  final Color? barrierColor;

  /// The constructor.
  StopperSheet({
    Key? key,
    @required this.builder,
    @required this.stops,
    this.initialStop = 0,
    this.onClose,
    this.barrierColor = Colors.black38,
    this.dragThreshold = 25,
  })  : assert(initialStop < stops!.length),
        super(key: key);

  @override
  StopperSheetState createState() => StopperSheetState();

  static Future show(
      {
      /// The key of the [StopperSheet] widget
      Key? key,

      /// The build context
      required BuildContext context,

      /// The builder of the bottom sheet
      @required StopperBuilder? builder,

      /// The list of stop heights as logical pixel values. Use [MediaQuery] to compute the heights relative to screen height.
      /// The order of the stop heights must be from the lowest to the highest.
      @required List<double>? stops,

      /// The initial stop number.
      int initialStop = 0,

      /// If [true] then the user can close the bottom sheet dragging it down from the lowest stop.
      bool userCanClose = true,

      ///
      Color? barrierColor,

      /// The minimum offset (in logical pixels) to trigger a stop change when dragging.
      double dragThreshold = 25}) {
    Future? cont;
    cont = showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor,
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return StopperSheet(
          key: key,
          builder: builder,
          stops: stops,
          initialStop: initialStop,
          dragThreshold: dragThreshold,
          onClose: userCanClose
              ? () {
                  Navigator.pop(context);
                }
              : null,
        );
      },
    );
    return cont;
  }
}

/// The state of [StopperSheet] widget.
class StopperSheetState extends State<StopperSheet>
    with SingleTickerProviderStateMixin {
  List<double>? _stops;
  int? _currentStop;
  int? _targetStop;
  bool _dragging = false;
  bool _closing = false;
  double? _dragOffset;
  double? _closingHeight;
  ScrollController? _scrollController;
  ScrollPhysics? _scrollPhysics;
  Animation<double>? _animation;
  AnimationController? _animationController;
  Tween<double>? _tween;

  ScrollPhysics _getScrollPhysicsForStop(s) {
    if (s == _stops!.length - 1) {
      return const BouncingScrollPhysics();
    } else {
      return const NeverScrollableScrollPhysics();
    }
  }

  @override
  void initState() {
    super.initState();
    _stops = widget.stops;
    _currentStop = widget.initialStop;
    _targetStop = _currentStop;
    _scrollController = ScrollController();
    _scrollPhysics = _getScrollPhysicsForStop(_currentStop);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    final curveAnimation =
        CurvedAnimation(parent: _animationController!, curve: Curves.linear);
    _tween = Tween<double>(
        begin: _stops?[_currentStop!], end: _stops?[_targetStop!]);
    _animation = _tween?.animate(curveAnimation);
    _scrollController?.addListener(() {
      if (_scrollController!.offset < -widget.dragThreshold) {
        if (_currentStop != _targetStop || _dragging) return;
        if (_currentStop! > 0) {
          final h0 = height;
          _targetStop = _currentStop! - 1;
          _animate(h0, _stops![_targetStop!]);
        } else if (!_closing) {
          close();
        }
      }
    });
  }

  @override
  void didUpdateWidget(StopperSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _stops = widget.stops;
    _currentStop = min(_currentStop!, _stops!.length - 1);
    _targetStop = min(_currentStop!, _stops!.length - 1);
  }

  @override
  void dispose() {
    super.dispose();
    try {
      _animationController!.dispose();
      _scrollController!.dispose();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// The current stop value. The value changes after the stop change animation is complete.
  get stop => _currentStop;

  set stop(nextStop) {
    _targetStop = max(0, min(_stops!.length - 1, nextStop));
    _animate(height, nextStop);
  }

  /// Returns true if this [StopperSheet] can be closed by the user.
  bool get canClose {
    return widget.onClose != null;
  }

  /// Closes the bottom sheet. Repeated calls to this method will be ignored.
  void close() {
    if (!_closing && canClose) {
      _closingHeight = height;
      _animationController!.stop(canceled: true);
      _dragging = false;
      _closing = true;
      widget.onClose!();
    }
  }

  // ignore: unused_element
  void _animate(double from, double to, [double? velocity]) {
    _tween!.begin = from;
    _tween!.end = to;
    _animationController!.value = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController != null && _scrollController!.hasClients) {
        if (_scrollController!.offset < 0) {
          _scrollController!.animateTo(0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        }
      }
    });
    _animationController!.fling().then((_) {
      _currentStop = _targetStop;
      setState(() {
        _scrollPhysics = _getScrollPhysicsForStop(_currentStop);
      });
    });
  }

  /// The current height of the bottom sheet.
  get height {
    if (_closing) {
      return _closingHeight;
    } else if (_dragging) {
      return _stops![_currentStop!] + _dragOffset!;
    } else if (_animationController!.isAnimating) {
      return _animation!.value;
    } else {
      return _stops![_currentStop!];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation!,
        child: GestureDetector(
          onVerticalDragStart: (details) {
            if (_currentStop != _targetStop) return;
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (_scrollController != null && _scrollController!.hasClients) {
                _scrollController!.jumpTo(0);
              }
            });
            _dragging = true;
            _dragOffset = 0;
            setState(() {});
          },
          onVerticalDragUpdate: (details) {
            if (_dragging) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (_scrollController != null &&
                    _scrollController!.hasClients) {
                  _scrollController!.jumpTo(0);
                }
              });

              _dragOffset = _dragOffset! - details.delta.dy;
              setState(() {});
            }
          },
          onVerticalDragEnd: (details) {
            if (!_dragging || _closing) return;
            if (_dragOffset! > widget.dragThreshold) {
              _targetStop = min(_currentStop! + 1, _stops!.length - 1);
            } else if (_dragOffset! < -widget.dragThreshold) {
              _targetStop = max(canClose ? -1 : 0, _currentStop! - 1);
            }
            if (_targetStop! < 0) {
              close();
            } else {
              _dragging = false;
              _animate(
                  _stops![_currentStop!] + _dragOffset!, _stops![_targetStop!]);
            }
          },
          child: widget.builder!(
              context, _scrollController!, _scrollPhysics!, _currentStop!),
        ),
        builder: (context, child) {
          return SizedBox(
            height: min(_stops![_stops!.length - 1], max(0, height)),
            child: ClipRRect(
                child: Container(color: Colors.transparent, child: child)),
          );
        });
  }
}
