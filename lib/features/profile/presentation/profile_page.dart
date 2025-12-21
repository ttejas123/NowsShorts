import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Feedback pill
                  GestureDetector(
                      onTap: () {
                        context.push('/feedback');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHigh.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Feedback',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ),
                  
                  const SizedBox(width: 12),

                  GestureDetector(
                      onTap: () {
                        context.push('/settings');
                      },
                      child: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Sign-in Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
                  ),
                ),
                child: Column(
                  children: [
                    _FeatureRow(
                      icon: Icons.person,
                      text: 'Get personalized feed on any device',
                    ),
                    const SizedBox(height: 12),
                    _FeatureRow(
                      icon: Icons.bookmark,
                      text: 'Access Bookmarks on any device',
                    ),
                    const SizedBox(height: 16),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF243447),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Sign In Now',
                          style: TextStyle(
                            color: Color(0xFF4EA3FF),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Saved Tab
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: [
                      Icon(
                        Icons.bookmark_outline,
                        color: Colors.blueAccent,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Saved',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 2,
                    width: 56,
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.2),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 🔹 Empty State
            Column(
              children: const [
                Text(
                  'Its Empty Here',
                  style: TextStyle(
                    color: Color(0xFFB0B0B0),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Tap on the title to bookmark a story',
                  style: TextStyle(
                    color: Color(0xFF6F6F6F),
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// 🔹 Feature Row Widget
class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF4EA3FF),
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

