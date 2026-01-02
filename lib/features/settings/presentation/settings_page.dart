import 'package:bl_inshort/core/logging/Console.dart';
import 'package:bl_inshort/features/settings/presentation/widgets/language_selector_sheet.dart';
import 'package:bl_inshort/features/settings/presentation/widgets/settings_page_header.dart';
import 'package:bl_inshort/features/settings/presentation/widgets/settings_page_toggle_row.dart';
import 'package:bl_inshort/features/settings/presentation/widgets/settings_pags_Row.dart';
import 'package:bl_inshort/features/settings/provider.dart';
import 'package:bl_inshort/features/shell/navigation_providers.dart';
import 'package:bl_inshort/features/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final selectedLanguage = settings.selectedLanguage;
    final hdImagesEnabled = settings.hdImagesEnabled;
    final autoplayEnabled = settings.autoplayEnabled;
    final themeController = ref.watch(themeControllerProvider);
    final bottomNavigationController = ref.read(bottomNavIndexProvider.notifier);
    final isNightMode = themeController.mode == AppThemeMode.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Top Bar
            SettingsPageAppHeader(title: "Settings", onBack: () {
              if (bottomNavigationController.state != 1) bottomNavigationController.state = 1;
            }),
            

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
                    child: SettingsPageRow(
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
                    child: SettingsPageRow(
                      icon: Icons.notifications_none,
                      title: 'Notifications',
                    ),
                  ),

                  _Divider(),

                  GestureDetector(
                    onTap: () {
                      context.push('/preferences');
                    },
                    child: SettingsPageRow(
                      icon: Icons.tune,
                      title: 'Personalize Your Feed',
                    ),
                  ),
                  _Divider(),

                  SettingsToggleRow(
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

                  SettingsToggleRow(
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

                  SettingsToggleRow(
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
