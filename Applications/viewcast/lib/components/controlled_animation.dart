// Classe volée honteusement à M.Felix Blaschke
// Mais, en réalité, ce code est sous license MIT
// Donc on peut l'utiliser et il ne nous en voudra pas de l'avoir adapter à nos besoins.

// Merci Felix !!

import 'package:flutter/widgets.dart';

/// Playback tell the controller of the animation what to do.
enum Playback {
  /// Animation stands still.
  pause,

  /// Animation plays forwards and stops at the end.
  playForward,

  /// Animation plays backwards and stops at the beginning.
  playReverse,

  /// Animation will reset to the beginning and start playing forward.
  startOverForward,

  /// Animation will reset to the end and start play backward.
  startOverReverse,

  /// Animation will play forwards and start over at the beginning when it
  /// reaches the end.
  loop,

  /// Animation will play forward until the end and will reverse playing until
  /// it reaches the beginning. Then it starts over playing forward. And so on.
  mirror
}

class ControlledAnimation<T> extends StatefulWidget {
  final Playback playback;
  final Animatable<T> tween;
  final Curve curve;
  final Duration duration;
  final Widget Function(BuildContext buildContext, T animatedValue) builder;
  final double startPosition;

  const ControlledAnimation({
    Key? key,
    this.playback = Playback.playForward,
    required this.tween,
    this.curve = Curves.linear,
    required this.duration,
    required this.builder,
    this.startPosition = 0.0,
  }) : super(key: key);

  @override
  _ControlledAnimationState<T> createState() => _ControlledAnimationState<T>();
}

class _ControlledAnimationState<T> extends State<ControlledAnimation<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<T> _animation;
  bool _isDisposed = false;
  bool _waitForDelay = true;
  bool _isCurrentlyMirroring = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        setState(() {});
      })
      ..value = widget.startPosition;

    _animation = widget.tween
        .chain(CurveTween(curve: widget.curve))
        .animate(_controller);

    initialize();
    super.initState();
  }

  void initialize() async {
    _waitForDelay = false;
    executeInstruction();
  }

  @override
  void didUpdateWidget(ControlledAnimation<T> oldWidget) {
    _controller.duration = widget.duration;
    executeInstruction();
    super.didUpdateWidget(oldWidget);
  }

  void executeInstruction() async {
    if (_isDisposed || _waitForDelay) {
      return;
    }

    if (widget.playback == Playback.pause) {
      _controller.stop();
    }
    if (widget.playback == Playback.playForward) {
      _controller.forward();
    }
    if (widget.playback == Playback.playReverse) {
      _controller.reverse();
    }
    if (widget.playback == Playback.startOverForward) {
      _controller.forward(from: 0.0);
    }
    if (widget.playback == Playback.startOverReverse) {
      _controller.reverse(from: 1.0);
    }
    if (widget.playback == Playback.loop) {
      _controller.repeat();
    }
    if (widget.playback == Playback.mirror && !_isCurrentlyMirroring) {
      _isCurrentlyMirroring = true;
      _controller.repeat(reverse: true);
    }

    if (widget.playback != Playback.mirror) {
      _isCurrentlyMirroring = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _animation.value);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }
}
