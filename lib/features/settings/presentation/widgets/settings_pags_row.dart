
import 'package:flutter/material.dart';

class SettingsPageRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;

  const SettingsPageRow({required this.icon, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4EA3FF), size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
