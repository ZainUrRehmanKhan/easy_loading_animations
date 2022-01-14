import 'package:flutter/material.dart';

class SpinningSquare extends StatefulWidget {
  final Duration duration;
  final double size;
  final Color color;

  const SpinningSquare({
    Key? key,
    this.duration = const Duration(milliseconds: 3000),
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  _SpinningSquareState createState() => _SpinningSquareState();
}

class _SpinningSquareState extends State<SpinningSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

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
        tween: Tween(begin: 0.0, end: widget.size * 0.4),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: widget.size * 0.4, end: 0.0),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
        parent: _controller,
      ),
    );

    _rotationAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 360.0), weight: 33),
      TweenSequenceItem(tween: Tween(begin: 360.0, end: 0.0), weight: 33),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 360.0), weight: 33),
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
        parent: _controller,
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Transform.rotate(
            angle: _rotationAnimation.value * 0.0174533,
            child: SizedBox(
              height: widget.size + _scaleAnimation.value,
              width: widget.size + _scaleAnimation.value,
              child: Stack(
                children: [
                  Align(
                    alignment: const Alignment(0, -1),
                    child: dot(),
                  ),
                  Align(
                    alignment: const Alignment(-1, 0),
                    child: dot(),
                  ),
                  Align(
                    alignment: const Alignment(1, 0),
                    child: dot(),
                  ),
                  Align(
                    alignment: const Alignment(0, 1),
                    child: dot(),
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

  Widget dot() {
    return Container(
      height: widget.size * 0.3,
      width: widget.size * 0.3,
      decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
    );
  }
}
