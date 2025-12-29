import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Color(0xFF1B1B1B): theme.scaffoldBackgroundColor,
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
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xFF2A2A2A) : colors.surfaceVariant,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(Icons.arrow_back_ios_new,
                          color: colors.onSurfaceVariant, size: 16),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Feedback',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            const Spacer(),

            // 🔹 Empty Message
            const Text(
              'Use the New Feedback button to create your\nfirst feedback.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB0B0B0),
                fontSize: 15,
                height: 1.4,
              ),
            ),

            const Spacer(),

            // 🔹 Bottom Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/new-feedback');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A84FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'New Feedback',
                    style: TextStyle(
                      color: Colors.white,
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
