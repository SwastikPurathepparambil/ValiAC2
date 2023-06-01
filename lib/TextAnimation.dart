import 'package:flutter/material.dart';

class TextAnimationWidget extends StatefulWidget {
  final String text;

  final Duration animationDuration;

  const TextAnimationWidget({
    Key? key,
    required this.text,

    required this.animationDuration,
  }) : super(key: key);

  @override
  _TextAnimationWidgetState createState() => _TextAnimationWidgetState();
}

class _TextAnimationWidgetState extends State<TextAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String _animatedText;
  int _currentLength = 0;

  @override
  void initState() {
    super.initState();

    _animatedText = '';
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: widget.text.length.toDouble())
        .animate(_controller)
      ..addListener(() {
        setState(() {
          _currentLength = _animation.value.toInt();
          _animatedText = widget.text.substring(0, _currentLength);
        });
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
    return Text(
      _animatedText,
    );
  }
}
