import 'package:flutter/material.dart';

/// It is a star like simple animation have four lines which grows and shrink.
class FancyPlus extends StatefulWidget {
  /// specify the [color] of the animation
  ///
  /// default [color] is [Colors.blueGrey]
  final Color color;

  /// [duration] to complete a loop
  /// used to increase/decrease the speed of animation.
  ///
  /// default [duration] is 1000 milliseconds.
  final Duration duration;

  /// specify the [size] of the animation.
  ///
  /// default size is [30].
  final double size;

  /// [lineHeight] to change the height of line.
  ///
  /// default size is [15].
  final double lineHeight;

  /// [lineWidth] to change the width of line.
  ///
  /// default size is [3].
  final double lineWidth;

  /// [scalingCurve] change the way of animation transformation.
  ///
  /// default is [Curves.easeOut].
  final Cubic scalingCurve;

  /// [lineBorderRadius] changes the border radius of the line.
  ///
  /// default [lineBorderRadius] is [20] for all sides.
  final BorderRadius lineBorderRadius;

  const FancyPlus({
    Key? key,
    this.color = Colors.blueGrey,
    this.size = 30,
    this.lineHeight = 15,
    this.lineWidth = 3,
    this.scalingCurve = Curves.easeOut,
    this.duration = const Duration(milliseconds: 1000),
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
