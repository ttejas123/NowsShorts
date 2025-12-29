import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewFeedbackPage extends StatelessWidget {
  const NewFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(Icons.arrow_back_ios_new,
                        color: colors.onSurfaceVariant, size: 18),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'New Feedback',
                        style: textTheme.titleMedium?.copyWith(
                          // color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  _SectionTitle('Category'),
                  _ChipWrap(
                    items: [
                      'Bug',
                      'Issue',
                      'Feature Required',
                      'Not able to find',
                      'Hard to use',
                    ],
                  ),

                  SizedBox(height: 24),

                  _SectionTitle('Describe your feedback'),
                  _TextArea(),

                  SizedBox(height: 24),

                  _SectionTitle('Upload Screenshot (optional)'),
                  _UploadBox(),
                ],
              ),
            ),

            // 🔹 Submit Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: null, // disabled (UI only)
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A3A3A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Feedback',
                    style: TextStyle(
                      color: Color(0xFF8A8A8A),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: textTheme.titleMedium?.copyWith(
          // color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ChipWrap extends StatelessWidget {
  final List<String> items;
  const _ChipWrap({required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items
          .map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A2A2A) : const Color.fromARGB(255, 182, 182, 182),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                e,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TextArea extends StatelessWidget {
  const _TextArea();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        maxLines: null,
        expands: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Tell us what you feel...',
          hintStyle: TextStyle(color: Color(0xFF8A8A8A)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _UploadBox extends StatelessWidget {
  const _UploadBox();

  @override
  Widget build(BuildContext context) {
       final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_outlined, color: Color(0xFF8A8A8A), size: 28),
            SizedBox(height: 8),
            Text(
              'Tap to upload image',
              style: TextStyle(color: Color(0xFF8A8A8A), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
