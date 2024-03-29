import 'package:flutter/material.dart';

/// Creates a loading animation having two circles which bounce and looks like pulse.
class CircularPulse extends StatefulWidget {
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
  /// default [color] is [Colors.lightBlue]
  final Color color;

  const CircularPulse({
    Key? key,
    this.duration = const Duration(milliseconds: 1000),
    this.size = 30,
    this.color = Colors.lightBlue,
  }) : super(key: key);

  @override
  _CircularPulseState createState() => _CircularPulseState();
}

class _CircularPulseState extends State<CircularPulse> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: widget.size + (widget.size * 0.1)),
          weight: 1),
      TweenSequenceItem(
          tween:
              Tween(begin: widget.size + (widget.size * 0.1), end: widget.size),
          weight: 0.2)
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.0, 0.7, curve: Curves.linear),
        parent: _controller,
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: _scaleAnimation.value,
                  width: _scaleAnimation.value,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: (widget.size / 8) * _controller.value,
                      color: widget.color,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: widget.size,
                  width: widget.size,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: widget.size / 8,
                      color: widget.color,
                    ),
                  ),
                ),
              )
            ],
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
}
