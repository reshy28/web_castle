import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FadeImageBanner extends StatefulWidget {
  final List<String> images;

  const FadeImageBanner({super.key, required this.images});

  @override
  State<FadeImageBanner> createState() => _FadeImageBannerState();
}

class _FadeImageBannerState extends State<FadeImageBanner> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.images.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.images[_currentIndex];

    return SizedBox(
      width: double.infinity,
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 2),
        child: ClipRRect(
          key: ValueKey(imageUrl),
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image),
          ),
        ),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }
}
