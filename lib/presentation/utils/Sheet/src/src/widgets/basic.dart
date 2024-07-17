import 'package:flutter/material.dart';

import '../enums/location.enum.dart';

@immutable
class BasicSheet extends StatefulWidget {
  final SheetLocation location;
  final Color backgroundColor;
  final double backgroundOpacity;
  final Widget child;
  final Duration animationDuration;
  final Curve animationCurve;
  const BasicSheet(
      {required this.child,
      required this.location,
      required this.backgroundColor,
      this.backgroundOpacity = 0.7,
      this.animationDuration = const Duration(milliseconds: 250),
      this.animationCurve = Curves.easeOut,
      Key? key})
      : super(key: key);

  @override
  State<BasicSheet> createState() => _BasicSheetState();

  static Future<T?> show<T extends Object>({
    required BuildContext context,
    required Widget child,
    location = SheetLocation.bottom,
    backgroundColor = const Color(0xb3212121),
    double backgroundOpacity = 0.7,
    Duration animationDuration = const Duration(milliseconds: 250),
    Curve animationCurve = Curves.easeOut,
  }) {
    return Navigator.push<T>(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return BasicSheet(
            location: location,
            backgroundColor: backgroundColor,
            backgroundOpacity: backgroundOpacity,
            animationDuration: animationDuration,
            animationCurve: animationCurve,
            child: Container(
              color: Colors.transparent,
              child: SafeArea(
                child: child,
              ),
            ),
          );
        },
        opaque: false,
      ),
    );
  }
}

class _BasicSheetState extends State<BasicSheet> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late AnimationController _animationController;

  final _childKey = GlobalKey();

  double get _childHeight {
    return _childKey.currentContext!.size!.height;
  }

  bool get _dismissUnderway =>
      _animationController.status == AnimationStatus.reverse;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(begin: _isDirectionTop ? -1 : 1, end: 0).animate(
        CurvedAnimation(
            parent: _animationController, curve: widget.animationCurve));

    _opacityAnimation = Tween<double>(begin: 0, end: widget.backgroundOpacity)
        .animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) Navigator.pop(context);
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_dismissUnderway) return;

    double change = details.primaryDelta! / (_childHeight);
    if (_isDirectionTop) {
      _animationController.value += change;
    } else {
      _animationController.value -= change;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dismissUnderway) return;

    if (details.velocity.pixelsPerSecond.dy > 0 && _isDirectionTop) return;
    if (details.velocity.pixelsPerSecond.dy < 0 && !_isDirectionTop) return;

    if (details.velocity.pixelsPerSecond.dy > 700) {
      final double flingVelocity =
          -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (_animationController.value > 0.0) {
        _animationController.fling(velocity: flingVelocity);
      }
    } else if (_animationController.value < 0.5) {
      if (_animationController.value > 0.0) {
        _animationController.fling(velocity: -1.0);
      }
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: onBackPressed,
      child: GestureDetector(
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
        excludeFromSemantics: true,
        child: AnimatedBuilder(
          animation: _opacityAnimation,
          builder: (context, child) {
            return Scaffold(
              backgroundColor:
                  widget.backgroundColor.withOpacity(_opacityAnimation.value),
              body: Column(
                key: _childKey,
                children: <Widget>[
                  _isDirectionTop ? Container() : const Spacer(),
                  AnimatedBuilder(
                      animation: _animation,
                      builder: (context, _) {
                        return Transform(
                          transform: Matrix4.translationValues(
                              0.0, width * _animation.value, 0.0),
                          child: SizedBox(
                            width: width,
                            child: widget.child,
                          ),
                        );
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool get _isDirectionTop {
    return widget.location == SheetLocation.top;
  }

  Future<bool> onBackPressed() {
    _animationController.reverse();
    return Future<bool>.value(false);
  }
}
