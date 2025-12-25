import 'package:bl_inshort/data/models/notifications/notification_entity.dart';
import 'package:bl_inshort/features/notifications/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationControllerProvider.notifier).loadInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(notificationControllerProvider).items;
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
  final List<NotificationEntity> items;

  _NotificationSection({required this.title, required this.items});
}

List<_NotificationSection> _groupByTime(List<NotificationEntity> items) {
  final now = DateTime.now();

  final yesterday = <NotificationEntity>[];
  final last7 = <NotificationEntity>[];
  final last30 = <NotificationEntity>[];
  final older = <NotificationEntity>[];

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                section.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  // ignore: deprecated_member_use
                  color: colors.onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ...section.items.map((item) => _NotificationTile(item: item)),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationEntity item;

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.presentation != null &&
                item.presentation!.resources != null &&
                item.presentation!.resources!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: item.presentation!.resources!.first.url,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    width: 48,
                    height: 48,
                    color: Colors.grey.shade300,
                  ),
                  errorWidget: (_, __, ___) => Icon(Icons.image_not_supported),
                ),
              )
            else
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.notifications_none,
                  // ignore: deprecated_member_use
                  color: colors.onSurface.withOpacity(0.6),
                ),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.presentation?.title ?? 'No Title',
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
