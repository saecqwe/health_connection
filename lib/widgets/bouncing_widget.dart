import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
  final Widget widgetToBounce;
  final double? tweenBegin;
  final double? tweenEnd;
  final Curve? curve;
  final Duration? animationDuration;
  const BouncingWidget(
      {super.key,
      required this.widgetToBounce,
      this.curve,
      this.tweenBegin,
      this.tweenEnd,
      this.animationDuration});

  @override
  _BouncingWidgetState createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _animation =
        Tween<double>(begin: widget.tweenBegin ?? 1, end: widget.tweenEnd ?? .8)
            .animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: widget.curve ?? Curves.elasticOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation!.value,
          child: child,
        );
      },
      child: widget.widgetToBounce,
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}
