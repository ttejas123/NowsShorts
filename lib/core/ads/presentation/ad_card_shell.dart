import 'package:flutter/widgets.dart';

class AdCardShell extends StatelessWidget {
  final Widget child;

  const AdCardShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: child,
    );
  }
}
