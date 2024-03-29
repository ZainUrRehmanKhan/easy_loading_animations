import 'package:flutter/material.dart';

/// [FutureDots] is a simple animation which waits for a future to complete for its own completion.
/// Can be widely use for network requests.
class FutureDots extends StatefulWidget {
  /// [duration] to complete a loop, used to increase/decrease the speed of animation.
  ///
  /// default [duration] is 1000 milliseconds.
  final Duration duration;

  /// specify the [size] of the animation.
  ///
  /// default size is [50].
  final double size;

  /// Animation will move until the [future] is not completed.
  /// A function can be provided which returns a future just like a network request.
  final Future future;

  /// specify a light [Color] for the animation
  ///
  /// default [loadingColorLight] is [Colors.lightBlue]
  final Color loadingColorLight;

  /// specify a dark [Color] for the animation
  ///
  /// default [loadingColorDark] is [Colors.blueGrey]
  final Color loadingColorDark;

  /// specify a light [Color] for the animation
  ///
  /// default [afterLoadingColorLight] is [Colors.lightBlue]
  final Color afterLoadingColorLight;

  /// specify a dark [Color] for the animation
  ///
  /// default [afterLoadingColorDark] is [Colors.blueGrey]
  final Color afterLoadingColorDark;

  const FutureDots({
    Key? key,
    required this.duration,
    required this.size,
    required this.loadingColorDark,
    required this.loadingColorLight,
    required this.afterLoadingColorDark,
    required this.afterLoadingColorLight,
    required this.future,
  }) : super(key: key);

  @override
  _FutureDotsState createState() => _FutureDotsState();
}

class _FutureDotsState extends State<FutureDots> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _doneController;
  late Animation<Alignment> _dots1Animation;
  late Animation<Alignment> _dots2Animation;
  late Animation<Alignment> _dots3Animation;
  late Animation<double> _scaleAnimation;

  bool isCompleted = false;

  animateDots() async {
    widget.future.then((value) {
      _controller.stop();
      _doneController.forward();
      setState(() {
        isCompleted = true;
      });
    });

    await _controller.forward();
    _controller.reset();

    if (!isCompleted) animateDots();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);
    _doneController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    animateDots();
  }

  @override
  Widget build(BuildContext context) {
    _dots1Animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, 0),
          end: const Alignment(-1, -1),
        ),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, -1),
          end: const Alignment(-1, 0),
        ),
        weight: 0.5,
      ),
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
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, -1),
          end: const Alignment(-1, 0),
        ),
        weight: 0.5,
      ),
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
        parent: _controller,
      ),
    );

    _dots3Animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, 0),
          end: const Alignment(-1, -1),
        ),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Alignment(-1, -1),
          end: const Alignment(-1, 0),
        ),
        weight: 0.5,
      ),
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.35, 0.9, curve: Curves.easeOut),
        parent: _controller,
      ),
    );

    _scaleAnimation = Tween(end: 1.0, begin: 0.0).animate(
      CurvedAnimation(
        curve: Curves.bounceOut,
        parent: _doneController,
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Opacity(
              opacity: .2,
              child: Center(
                child: Container(
                  height: widget.size,
                  width: widget.size,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? widget.afterLoadingColorLight
                        : widget.loadingColorLight,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Center(
              child: isCompleted
                  ? ScaleTransition(
                      scale: _scaleAnimation,
                      child: Icon(
                        Icons.done_rounded,
                        color: widget.afterLoadingColorDark,
                        size: widget.size / 2,
                      ),
                    )
                  : SizedBox(
                      height: widget.size / 3,
                      width: widget.size,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          dot(dotsAnimation: _dots1Animation),
                          dot(dotsAnimation: _dots2Animation),
                          dot(dotsAnimation: _dots3Animation),
                        ],
                      ),
                    ),
            )
          ],
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
        padding: EdgeInsets.symmetric(horizontal: widget.size * 0.025),
        child: Container(
          height: widget.size * 0.1,
          width: widget.size * 0.1,
          decoration: BoxDecoration(
            color: widget.loadingColorDark,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
