import 'package:flutter/material.dart';

/// Creates a loading animation having bars which move like a wave.
class BarcodeLoader extends StatefulWidget {
  /// [duration] to complete a loop
  /// used to increase/decrease the speed of animation.
  ///
  /// default [duration] is 1000 milliseconds.
  final Duration duration;

  /// specify the [height] of the animation.
  ///
  /// default height is [30]
  final double height;

  /// specify the [color] of the animation
  ///
  /// default [color] is [Colors.lightBlue]
  final Color color;

  const BarcodeLoader({
    Key? key,
    this.duration = const Duration(milliseconds: 1000),
    this.height = 30,
    this.color = Colors.lightBlue,
  }) : super(key: key);

  @override
  _BarcodeLoaderState createState() => _BarcodeLoaderState();
}

class _BarcodeLoaderState extends State<BarcodeLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleFirstBarAnimation;
  late Animation<double> _scaleSecondBarAnimation;
  late Animation<double> _scaleThirdBarAnimation;
  late Animation<double> _scaleFourthBarAnimation;
  late Animation<double> _scaleFifthBarAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    _scaleFirstBarAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 2.0), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 2.0, end: 1.0), weight: 0.5)
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        parent: _controller,
      ),
    );
    _scaleSecondBarAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 2.0), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 2.0, end: 1.0), weight: 0.5)
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.1, 0.6, curve: Curves.easeOut),
        parent: _controller,
      ),
    );
    _scaleThirdBarAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 2.0), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 2.0, end: 1.0), weight: 0.5)
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
        parent: _controller,
      ),
    );
    _scaleFourthBarAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 2.0), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 2.0, end: 1.0), weight: 0.5)
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
        parent: _controller,
      ),
    );
    _scaleFifthBarAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 2.0), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 2.0, end: 1.0), weight: 0.5)
    ]).animate(
      CurvedAnimation(
        curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
        parent: _controller,
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customContainer(scaleAnimation: _scaleFirstBarAnimation),
              customContainer(scaleAnimation: _scaleSecondBarAnimation),
              customContainer(scaleAnimation: _scaleThirdBarAnimation),
              customContainer(scaleAnimation: _scaleFourthBarAnimation),
              customContainer(scaleAnimation: _scaleFifthBarAnimation)
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

  Widget customContainer({required Animation<double> scaleAnimation}) {
    return Padding(
      padding: EdgeInsets.only(right: (widget.height * 0.2) / 2),
      child: Container(
        color: widget.color,
        height: widget.height * scaleAnimation.value,
        width: widget.height * 0.3,
      ),
    );
  }
}
