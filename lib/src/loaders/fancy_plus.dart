import 'package:flutter/material.dart';

class FancyPlus extends StatefulWidget {
  final Color color;
  final Duration duration;
  final double size;
  final double lineWidth;
  final double lineHeight;
  final Cubic scalingCurve;
  final BorderRadius lineBorderRadius;

  const FancyPlus({
    Key? key,
    required this.color,
    required this.size,
    required this.lineHeight,
    required this.lineWidth,
    this.scalingCurve = Curves.easeOut,
    this.duration = const Duration(milliseconds: 900),
    this.lineBorderRadius = const BorderRadius.all(Radius.circular(20)),
  }) : super(key: key);

  @override
  _FancyPlusState createState() => _FancyPlusState();
}

class _FancyPlusState extends State<FancyPlus>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleController;
  late Animation<double> _lineHeightController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    _scaleController = Tween(end: 1.0, begin: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.scalingCurve),
    );

    _lineHeightController = Tween(end: 0.0, begin: 1.0).animate(_controller);

    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ScaleTransition(
              scale: _scaleController,
              child: Stack(
                children: [
                  lineContainer(
                    alignment: Alignment.topCenter,
                    lineWidth: widget.lineWidth,
                    lineHeight: widget.lineHeight * _lineHeightController.value,
                  ),
                  lineContainer(
                    alignment: Alignment.centerLeft,
                    lineWidth: widget.lineHeight * _lineHeightController.value,
                    lineHeight: widget.lineWidth,
                  ),
                  lineContainer(
                    alignment: Alignment.centerRight,
                    lineWidth: widget.lineHeight * _lineHeightController.value,
                    lineHeight: widget.lineWidth,
                  ),
                  lineContainer(
                    alignment: Alignment.bottomCenter,
                    lineWidth: widget.lineWidth,
                    lineHeight: widget.lineHeight * _lineHeightController.value,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget lineContainer({
    required Alignment alignment,
    required double lineWidth,
    required double lineHeight,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: widget.lineBorderRadius,
        ),
        width: lineWidth,
        height: lineHeight,
      ),
    );
  }
}
