import 'package:bl_inshort/features/onboarding/presentation/region_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../../../theme/app_colors.dart';

class SelectedLanguageScreen extends StatelessWidget {
  final String language;

  const SelectedLanguageScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final label = language == 'en' ? 'English' : 'العربية';
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// ───── Back ─────
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: AppColors.danger,
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const Spacer(),

            /// ───── Card ─────
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 140,
                  height: 160,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.article, size: 48, color: Colors.white),
                      const SizedBox(height: 12),
                      Text(label, style: textTheme.labelLarge),
                    ],
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            /// ───── Text ─────
            Text('News on the go.', style: textTheme.titleLarge),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'We summarize and curate news\n'
                'focused on your interests so you can\n'
                'read more quickly.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: colors.primary),
              ),
            ),

            const Spacer(),

            /// ───── Button ─────
            SizedBox(
              width: 220,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  _goNext(context);
                },
                child: const Text('Next'),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _goNext(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RegionSelectionScreen()),
    );
  }
}
