import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bl_inshort/features/discover/providers.dart';

class DiscoverNotificationsList extends ConsumerWidget {
  const DiscoverNotificationsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(discoverNotificationsProvider);
    final colors = Theme.of(context).colorScheme;

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              // Header row: "Notifications" + VIEW ALL
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      'Notifications',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // later: navigate to full notifications page
                      },
                      child: const Text(
                        'VIEW ALL',
                        style: TextStyle(letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // List of rectangular notification rows
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _NotificationRow(item: item, colors: colors);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationRow extends StatelessWidget {
  final DiscoverNotificationItem item;
  final ColorScheme colors;

  const _NotificationRow({
    required this.item,
    required this.colors,
  });

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // later: open story detail
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl!,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    width: 56,
                    height: 56,
                    color: Colors.grey.shade300,
                  ),
                  errorWidget: (_, __, ___) => Icon(Icons.image_not_supported),
                ),
              )
            else
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.notifications_none),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _timeAgo(item.createdAt),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          // ignore: deprecated_member_use
                          color: colors.onSurface.withOpacity(0.6),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
