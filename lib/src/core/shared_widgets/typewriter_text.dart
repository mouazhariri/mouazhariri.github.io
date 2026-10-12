import 'dart:async';

import 'package:flutter/material.dart';

/// Cycles through [words] with a typing/deleting effect and a blinking caret.
class TypewriterText extends StatefulWidget {
  const TypewriterText({
    super.key,
    required this.words,
    required this.style,
    this.typeSpeed = const Duration(milliseconds: 58),
    this.deleteSpeed = const Duration(milliseconds: 32),
    this.pause = const Duration(milliseconds: 1500),
    this.caret = '|',
  });

  final List<String> words;
  final TextStyle style;
  final Duration typeSpeed;
  final Duration deleteSpeed;
  final Duration pause;
  final String caret;

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  Timer? _timer;
  int _wordIndex = 0;
  int _charCount = 0;
  bool _deleting = false;
  bool _caretVisible = true;
  Timer? _caretTimer;

  @override
  void initState() {
    super.initState();
    _tick(animationDelay: const Duration(milliseconds: 400));
    _caretTimer = Timer.periodic(const Duration(milliseconds: 530), (_) {
      if (mounted) setState(() => _caretVisible = !_caretVisible);
    });
  }

  void _tick({required Duration animationDelay}) {
    _timer = Timer(animationDelay, () {
      if (!mounted) return;
      final word = widget.words[_wordIndex % widget.words.length];
      setState(() {
        if (!_deleting) {
          if (_charCount < word.length) {
            _charCount++;
            _timer = null;
            _tick(animationDelay: widget.typeSpeed);
            return;
          }
          _deleting = true;
          _tick(animationDelay: widget.pause);
          return;
        }
        if (_charCount > 0) {
          _charCount--;
          _tick(animationDelay: widget.deleteSpeed);
          return;
        }
        _deleting = false;
        _wordIndex++;
        _tick(animationDelay: widget.typeSpeed * 2);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _caretTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = widget.words[_wordIndex % widget.words.length];
    return Text.rich(
      TextSpan(
        text: word.substring(0, _charCount.clamp(0, word.length)),
        children: [
          TextSpan(
            text: widget.caret,
            style: widget.style.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (!_caretVisible) ...[]
        ],
      ),
      style: widget.style,
      maxLines: 1,
    );
  }
}