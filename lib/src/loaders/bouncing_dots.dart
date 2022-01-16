import 'package:flutter/material.dart';

/// Creates a loading animation having three dots which bounce in a wave pattern.
class BouncingDots extends StatefulWidget {
  /// [duration] to complete a loop
  /// used to increase/decrease the speed of animation.
  ///
  /// default [duration] is 1000 milliseconds.
  final Duration duration;

  /// specify the [size] of the animation.
  ///
  /// default size is [30].
  final double size;

  /// specify the [colors] used in the animation.
  ///
  /// default [colors] are [Colors.blue], [Colors.red], [Colors.yellow].
  final List<Color> colors;

  const BouncingDots({
    Key? key,
    this.size = 30,
    this.duration = const Duration(milliseconds: 1000),
    this.colors = const [Colors.blue, Colors.red, Colors.yellow],
  }) : super(key: key);

  @override
  _BouncingDotsState createState() => _BouncingDotsState();
}

class _BouncingDotsState extends State<BouncingDots> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _dots1Animation;
  late Animation<Alignment> _dots2Animation;
  late Animation<Alignment> _dots3Animation;

  int index = 0;

  _animate() async {
    await _controller.forward();
    _controller.reset();

    setState(() {
      if (index == widget.colors.length - 1) {
        index = 0;
      } else {
        ++index;
      }
    });

    _animate();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animate();
  }

  @override
  Widget build(BuildContext context) {
    _dots1Animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, 0),
          end: const Alignment(-1, -1),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, -1),
          end: const Alignment(-1, 0),
        ),
        weight: 1,
      )
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
        parent: _controller,
      ),
    );

    _dots2Animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, 0),
          end: const Alignment(-1, -1),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, -1),
          end: const Alignment(-1, 0),
        ),
        weight: 1,
      )
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.1, 0.8, curve: Curves.easeOut),
        parent: _controller,
      ),
    );

    _dots3Animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, 0),
          end: const Alignment(-1, -1),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, -1),
          end: const Alignment(-1, 0),
        ),
        weight: 1,
      )
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
        parent: _controller,
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: SizedBox(
            height: widget.size,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dot(dotsAnimation: _dots1Animation),
                dot(dotsAnimation: _dots2Animation),
                dot(dotsAnimation: _dots3Animation),
              ],
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

  Widget dot({required Animation<Alignment> dotsAnimation}) {
    return Align(
      alignment: dotsAnimation.value,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.size * 0.05),
        child: AnimatedContainer(
          duration: widget.duration,
          height: widget.size * 0.3,
          width: widget.size * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.colors[index],
          ),
        ),
      ),
    );
  }
}
