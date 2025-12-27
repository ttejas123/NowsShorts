import 'package:flutter/widgets.dart';

class AdFallbackWidget extends StatelessWidget {
  final Widget fallback;

  const AdFallbackWidget({super.key, required this.fallback});

  @override
  Widget build(BuildContext context) {
    return fallback;
  }
}
