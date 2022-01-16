import 'package:flutter/material.dart';

/// Two type of circular spiral animation [simple] and [heavy].
enum CircularSpiralType { simple, heavy }

/// Creates a loading animation having circles which move in circular way.
class CircularSpiral extends StatefulWidget {
  /// [duration] to complete a loop
  /// used to increase/decrease the speed of animation.
  ///
  /// default [duration] is 1000 milliseconds.
  final Duration duration;

  /// specify the [size] of the animation.
  ///
  /// default size is [30].
  final double size;

  /// specify the [color] of the animation
  ///
  /// default [color] is [Colors.blueGrey]
  final Color color;

  /// specify the [reverse] boolean to [true], if you want a reverse animation
  ///
  /// default [reverse] is [false]
  final bool reverse;

  /// specify the [type] of the animation
  ///
  /// default [type] is [CircularSpiralType.simple]
  final CircularSpiralType type;

  const CircularSpiral({
    Key? key,
    this.duration = const Duration(milliseconds: 1000),
    this.size = 30,
    this.color = Colors.blueGrey,
    this.reverse = false,
    this.type = CircularSpiralType.simple,
  }) : super(key: key);

  @override
  _CircularSpiralState createState() => _CircularSpiralState();
}

class _CircularSpiralState extends State<CircularSpiral> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: widget.reverse);
  }

  @override
  Widget build(BuildContext context) {
    _scaleAnimation = Tween(end: 1.0, begin: 0.0).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _controller,
      ),
    );
    _rotateAnimation = Tween(begin: 0.0, end: 360.0).animate(
      CurvedAnimation(
        curve: Curves.linear,
        parent: _controller,
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: SizedBox(
            height: widget.size,
            width: widget.size,
            child: Transform.rotate(
              angle: _rotateAnimation.value * 0.0174533,
              child: Stack(
                children: [
                  Positioned(
                    top: 0.0,
                    child: customCircle(
                      scaleAnimationValue: 1.0 - _scaleAnimation.value,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: customCircle(
                      scaleAnimationValue: _scaleAnimation.value,
                    ),
                  ),
                  if (widget.type == CircularSpiralType.heavy)
                    Positioned(
                      left: 0.0,
                      child: customCircle(
                        scaleAnimationValue: 1.0 - _scaleAnimation.value,
                      ),
                    ),
                  if (widget.type == CircularSpiralType.heavy)
                    Positioned(
                      right: 0.0,
                      child: customCircle(
                        scaleAnimationValue: _scaleAnimation.value,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget customCircle({required double scaleAnimationValue}) {
    return Container(
      height: widget.size * scaleAnimationValue,
      width: widget.size * scaleAnimationValue,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
    );
  }
}
