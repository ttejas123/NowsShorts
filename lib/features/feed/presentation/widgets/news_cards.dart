// lib/features/feed/presentation/widgets/news_cards.dart

import 'package:flutter/material.dart';
import 'package:bl_inshort/data/models/news_item_entity.dart';

class NewsCard extends StatelessWidget {
  final NewsItemEntity item;

  const NewsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    switch (item.layoutType) {
      case NewsLayoutType.photoDominant:
        return _PhotoDominantCard(item: item);
      case NewsLayoutType.textDominant:
        return _TextDominantCard(item: item);
      case NewsLayoutType.gallery:
        return _GalleryCard(item: item);
      case NewsLayoutType.story:
        return _StoryCard(item: item);
    }
  }
}

// 1) Photo-dominant layout (big image, text overlay/under)
class _PhotoDominantCard extends StatelessWidget {
  final NewsItemEntity item;

  const _PhotoDominantCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (item.imageUrl != null)
            Image.network(
              item.imageUrl!,
              fit: BoxFit.cover,
            ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.source.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      item.subtitle!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 2) Text-dominant layout (more like Inshorts)
class _TextDominantCard extends StatelessWidget {
  final NewsItemEntity item;

  const _TextDominantCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    item.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (item.subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                item.subtitle!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 12),
            if (item.body != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    item.body!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '• ${item.source}',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3) Gallery layout (horizontal slider)
class _GalleryCard extends StatelessWidget {
  final NewsItemEntity item;

  const _GalleryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final images = item.galleryUrls;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                final url = images[index];
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.source.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 4) Story-style layout (full bleed image, center text)
class _StoryCard extends StatelessWidget {
  final NewsItemEntity item;

  const _StoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (item.imageUrl != null)
            Image.network(
              item.imageUrl!,
              fit: BoxFit.cover,
            ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    item.source.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white70),
                  ),
                ),
                const Spacer(),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (item.subtitle != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    item.subtitle!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white70),
                  )
                ],
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
