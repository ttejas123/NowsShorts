import 'package:bl_inshort/features/settings/presentation/widgets/language_selector_sheet.dart';
import 'package:bl_inshort/features/settings/provider.dart';
import 'package:bl_inshort/features/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final selectedLanguage = settings.selectedLanguage;
    final hdImagesEnabled = settings.hdImagesEnabled;
    final autoplayEnabled = settings.autoplayEnabled;
    final themeController = ref.watch(themeControllerProvider);
    final isNightMode = themeController.mode == AppThemeMode.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Settings List
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        // ignore: deprecated_member_use
                        barrierColor: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                        builder: (_) => const LanguageSelectorSheet(),
                      );
                    },
                    child: _SettingsRow(
                      icon: Icons.text_fields,
                      title: 'Language',
                      trailing: Text(
                        '${selectedLanguage?.name ?? 'English'} ▼',
                        style: TextStyle(color: Color(0xFF4EA3FF)),
                      ),
                    ),
                  ),

                  _Divider(),

                  GestureDetector(
                    onTap: () {
                      context.push('/notifications');
                    },
                    child: _SettingsRow(
                      icon: Icons.notifications_none,
                      title: 'Notifications',
                    ),
                  ),

                  _Divider(),

                  GestureDetector(
                    onTap: () {
                      context.push('/preferences');
                    },
                    child: _SettingsRow(
                      icon: Icons.tune,
                      title: 'Personalize Your Feed',
                    ),
                  ),
                  _Divider(),

                  _SettingsToggleRow(
                    icon: Icons.change_history,
                    title: 'HD Image',
                    value: hdImagesEnabled,
                    onChanged: (value) {
                      ref
                          .read(settingsControllerProvider.notifier)
                          .setHdImages(value);
                    },
                  ),
                  _Divider(),

                  _SettingsToggleRow(
                    icon: Icons.nightlight_outlined,
                    title: 'Night Mode',
                    subtitle: 'For better readability at night',
                    value: isNightMode,
                    onChanged: (value) {
                      ref
                          .read(themeControllerProvider)
                          .setTheme(
                            value ? AppThemeMode.dark : AppThemeMode.light,
                          );
                    },
                  ),
                  _Divider(),

                  _SettingsToggleRow(
                    icon: Icons.play_arrow,
                    title: 'Autoplay',
                    value: autoplayEnabled,
                    onChanged: (value) {
                      ref
                          .read(settingsControllerProvider.notifier)
                          .setAutoplay(value);
                    },
                  ),
                  _Divider(),

                  const SizedBox(height: 24),

                  _PlainRow(title: 'Share app'),
                  _PlainRow(title: 'Rate app'),
                  GestureDetector(
                    onTap: () => context.push('/notifications'),
                    child: _PlainRow(title: 'Notifications'),
                  ),
                  _PlainRow(title: 'Terms & Conditions'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;

  const _SettingsRow({required this.icon, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4EA3FF), size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _SettingsToggleRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggleRow({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4EA3FF), size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF4EA3FF),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFF3A3A3A),
          ),
        ],
      ),
    );
  }
}

class _PlainRow extends StatelessWidget {
  final String title;

  const _PlainRow({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Text(
        title,
        style: const TextStyle(color: Color(0xFFB0B0B0), fontSize: 14),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).dividerTheme.color,
      thickness: 1,
    );
  }
}
