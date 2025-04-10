import 'package:flutter/material.dart';

class FadingTextAnimation extends StatefulWidget {
  final List<String> texts; // Texts to animate
  final Duration duration; // Duration for the animation
  final Curve curve; // Curve for the animation
  final TextStyle textStyle; // Text style customization
  final Duration transitionDelay; // Delay between transitions

  const FadingTextAnimation({
    super.key,
    required this.texts,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.textStyle = const TextStyle(fontSize: 18, color: Color(0xFF7D818C)),
    this.transitionDelay = const Duration(milliseconds: 1000),
  });

  @override
  FadingTextAnimationState createState() => FadingTextAnimationState();
}

class FadingTextAnimationState extends State<FadingTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationCycle();
  }

  // Initializes the animation controller and defines opacity and slide animations
  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.25), // Fade in during the first 25%
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.60),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.5), // Slide up during 25% - 50%
      ),
    );
  }

  // Starts the animation cycle with a status listener
  void _startAnimationCycle() {
    _slideAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.transitionDelay, () {
          if (mounted) {
            _controller.reverse();
          }
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.texts.length;
        });
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TickerMode(
        enabled: _controller.isAnimating,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Text(
              widget.texts[_currentIndex],
              style: widget.textStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
