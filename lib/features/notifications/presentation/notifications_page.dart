import 'package:bl_inshort/features/discover/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(discoverNotificationsProvider);

    // sort newest first
    final sorted = [...items]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final sections = _groupByTime(sorted);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          color: Colors.black,
        ),
        title: const Text('Notifications'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          if (section.items.isEmpty) return const SizedBox.shrink();

          return _NotificationSectionWidget(section: section);
        },
      ),
    );
  }
}

// ---- grouping logic ----

class _NotificationSection {
  final String title;
  final List<DiscoverNotificationItem> items;

  _NotificationSection({required this.title, required this.items});
}

List<_NotificationSection> _groupByTime(
  List<DiscoverNotificationItem> items,
) {
  final now = DateTime.now();

  final yesterday = <DiscoverNotificationItem>[];
  final last7 = <DiscoverNotificationItem>[];
  final last30 = <DiscoverNotificationItem>[];
  final older = <DiscoverNotificationItem>[];

  for (final item in items) {
    final diff = now.difference(item.createdAt);
    final days = diff.inDays;

    // simple bucket rules:
    // 0–1 days -> Yesterday
    // 2–7 days -> Last 7 days
    // 8–30 days -> Last 30 days
    // >30 days -> Older
    if (days <= 1) {
      yesterday.add(item);
    } else if (days <= 7) {
      last7.add(item);
    } else if (days <= 30) {
      last30.add(item);
    } else {
      older.add(item);
    }
  }

  return [
    _NotificationSection(title: 'Yesterday', items: yesterday),
    _NotificationSection(title: 'Last 7 days', items: last7),
    _NotificationSection(title: 'Last 30 days', items: last30),
    _NotificationSection(title: 'Older', items: older),
  ];
}

// ---- UI widgets ----

class _NotificationSectionWidget extends StatelessWidget {
  final _NotificationSection section;

  const _NotificationSectionWidget({required this.section});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.items.isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                section.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.onSurface.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ...section.items.map(
            (item) => _NotificationTile(item: item),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final DiscoverNotificationItem item;

  const _NotificationTile({required this.item});

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: null, // nothing actionable for now
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl!,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.notifications_none,
                  color: colors.onSurface.withOpacity(0.6),
                ),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _timeAgo(item.createdAt),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
