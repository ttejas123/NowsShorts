import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final List<String> insightImages = [
  "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
  "https://images.unsplash.com/photo-1526045612212-70caf35c14df",
  "https://images.unsplash.com/photo-1544025162-d76694265947",
  "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
  "https://images.unsplash.com/photo-1526045612212-70caf35c14df",
  "https://images.unsplash.com/photo-1544025162-d76694265947",
];

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // already on Discover
              },
              child: Text(
                'Discover',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                context.push('/feed');
              },
              child: Text(
                'My Feed',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      // ignore: deprecated_member_use
                      color: colors.onSurface.withOpacity(0.5),
                    ),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
              onTap: () {
                context.push('/notifications');
              },
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.notifications_outlined),
              ),
          ),
          
        ],
      ),
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _navigated = false;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                final metrics = notification.metrics;

                if (!_navigated &&
                    metrics.pixels <= 0 &&
                    notification.scrollDelta! < -30) {
                  _navigated = true;
                  context.push('/search');
                  Future.delayed(const Duration(milliseconds: 500), () {
                    _navigated = false;
                  });
                }
              }
              return false;
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _SearchBar(),
                SizedBox(height: 14),
                _PromoBanner(),
                SizedBox(height: 22),
                _CategoryRow(),
                SizedBox(height: 26),
                _Notifications(),
                SizedBox(height: 26),
                _Insights(),
                SizedBox(height: 90),
                InsightsSection(),
                SizedBox(height: 26),
                TopicsSection(),
                SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          context.push('/search');
        },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            SizedBox(width: 16),
            Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface, size: 20),
            SizedBox(width: 12),
            Text(
              "Search for News, Topics",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      )


    );
  }
}


class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}


class _CategoryRow extends ConsumerWidget {
  const _CategoryRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _CategoryItem(Icons.feed, "My Feed"),
          _CategoryItem(Icons.article, "All News"),
          _CategoryItem(Icons.star, "Top Stories"),
          _CategoryItem(Icons.local_fire_department, "Trending"),
        ],
      ),
    );
  }
}

class _CategoryItem extends ConsumerWidget {
  final IconData icon;
  final String label;

  const _CategoryItem(this.icon, this.label);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Icon(icon, size: 34, color: Colors.blue),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 13,
          ),
        )
      ],
    );
  }
}


class _Notifications extends StatelessWidget {
  const _Notifications();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
                    onTap: () => context.push('/notifications'),
                    child: _SectionHeader("Notifications"),
        ),
        const SizedBox(height: 14),
        const _NotificationTile(
          title: "Actor Akhil Vishwanath dies by suicide aged 30",
          image: "https://images.pexels.com/photos/1257860/pexels-photo-1257860.jpeg",
        ),
        const _NotificationTile(
          title:
              "She has lost 5 kg, is constantly crying: Husband of Goa club dancer after fire killed 25",
          image: "https://images.pexels.com/photos/1257860/pexels-photo-1257860.jpeg",
        ),
        const _NotificationTile(
          title:
              "Police lathi charge fans protesting against mismanagement during Messi's event in Kolkata",
          image: "https://images.pexels.com/photos/1257860/pexels-photo-1257860.jpeg",
        ),
      ],
    );
  }
}


class _NotificationTile extends StatelessWidget {
  final String title;
  final String image;

  const _NotificationTile({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.3),
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              image,
              height: 46,
              width: 46,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}


class _Insights extends StatelessWidget {
  const _Insights();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader("Insights"),
        const SizedBox(height: 14),
        SizedBox(
          height: 120,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://images.pexels.com/photos/1434608/pexels-photo-1434608.jpeg",
                width: 220,
                fit: BoxFit.cover,
              ),
            ),
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 2,
                width: 28,
                color: Color(0xFF1E88E5),
              ),
            ],
          ),
          const Text(
            "VIEW ALL",
            style: TextStyle(
              color: Color(0xFF1E88E5),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class InsightsSection extends StatelessWidget {
  const InsightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader("Insights"),
        const SizedBox(height: 14),
        SizedBox(
          height: 220, // exact visual height
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: insightImages.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return _InsightCard(imageUrl: insightImages[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String imageUrl;

  const _InsightCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 150,
        height: 220,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TopicsSection extends StatelessWidget {
  const TopicsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const _SectionHeader("Topics"),
        const SizedBox(height: 20),
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: topics.length,
            separatorBuilder: (_, _) => const SizedBox(width: 18),
            itemBuilder: (context, index) {
              final topic = topics[index];
              return _TopicItem(
                imageUrl: topic.image,
                title: topic.title,
                isActive: topic.isActive,
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: const Color(0xFF1E88E5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}

class _TopicItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isActive;

  const _TopicItem({
    required this.imageUrl,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: isActive ? 72 : 56,
          width: isActive ? 72 : 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isActive ? 16 : 12),
            border: isActive
                ? Border.all(color: const Color(0xFF1E88E5), width: 2)
                : null,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFF1E88E5) : Colors.grey,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class TopicModel {
  final String title;
  final String image;
  final bool isActive;

  TopicModel({
    required this.title,
    required this.image,
    this.isActive = false,
  });
}

final List<TopicModel> topics = [
  TopicModel(
    title: "Israel-Hamas War",
    image: "https://images.unsplash.com/photo-1509099836639-18ba1795216d",
  ),
  TopicModel(
    title: "Finance",
    image: "https://images.unsplash.com/photo-1604594849809-dfedbc827105",
    isActive: true,
  ),
  TopicModel(
    title: "Russia-Ukraine",
    image: "https://images.unsplash.com/photo-1644088379091-d574269d422f",
  ),
  TopicModel(
    title: "Israel-Hamas War",
    image: "https://images.unsplash.com/photo-1509099836639-18ba1795216d",
  ),
  TopicModel(
    title: "Finance",
    image: "https://images.unsplash.com/photo-1604594849809-dfedbc827105",
    isActive: true,
  ),
  TopicModel(
    title: "Russia-Ukraine",
    image: "https://images.unsplash.com/photo-1644088379091-d574269d422f",
  ),
];

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // 🔍 Search Bar + Cancel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              style: Theme.of(context).textTheme.bodyMedium,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                hintText: 'Search for News, Topics',
                                hintStyle: Theme.of(context).textTheme.bodyMedium,
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Divider
            Container(
              height: 0.6,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
            ),

            // Recent Searches Row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Searches',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Clear All',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            // Empty State
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 😴 Sleeping Face
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF4DA3FF),
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.face_retouching_natural,
                            size: 40,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const Positioned(
                        right: -4,
                        top: -6,
                        child: Text(
                          'Z\nZ\nZ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF4DA3FF),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'No Recent Searches',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
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
