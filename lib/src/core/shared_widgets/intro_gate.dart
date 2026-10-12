import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/extensions/context_extension.dart';
import 'build_stream_splash.dart';

/// Whether the brand splash has already played this session. Persisted in a
/// provider so the splash is not replayed when the app subtree is rebuilt (for
/// example when the language changes and `EasyLocalization` is re-keyed).
final introDoneProvider =
    NotifierProvider<IntroDoneNotifier, bool>(IntroDoneNotifier.new);

class IntroDoneNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void complete() => state = true;
}

/// The "built from code" splash: a laptop streams code down into a phone where
/// it assembles into the app, then the scene fades to reveal the portfolio.
///
/// Runs once per session over a single [AnimationController] (no nested
/// animation widgets, so the motion stays smooth). Tapping or clicking skips
/// straight to the end; when the platform asks for reduced motion the splash is
/// skipped entirely.
class IntroGate extends ConsumerStatefulWidget {
  const IntroGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<IntroGate> createState() => _IntroGateState();
}

class _IntroGateState extends ConsumerState<IntroGate>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 2700);

  late final AnimationController _controller;
  bool _done = false;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    if (ref.read(introDoneProvider)) {
      _controller.value = 1;
      _done = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started || _done) return;
    _started = true;

    // Honour "reduce motion": skip the splash altogether.
    if (MediaQuery.maybeOf(context)?.disableAnimations ?? false) {
      ref.read(introDoneProvider.notifier).complete();
      _done = true; // A build follows this callback, so no setState is needed.
      return;
    }
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _finish();
    });
    _controller.forward();
  }

  void _finish() {
    if (!mounted || _done) return;
    ref.read(introDoneProvider.notifier).complete();
    setState(() => _done = true);
  }

  /// Skips the remainder of the splash instead of restarting it.
  void _skip() {
    if (_done || _controller.isCompleted) return;
    _controller.animateTo(
      1,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return widget.child;
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _skip,
            child: BuildStreamSplash(
              key: const ValueKey('intro_splash'),
              progress: _controller,
              isDark: context.isDarkMode,
            ),
          ),
        ),
      ],
    );
  }
}
