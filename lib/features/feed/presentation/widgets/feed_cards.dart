// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:bl_inshort/data/dto/feed/feed_dto.dart';
import 'package:bl_inshort/data/models/feeds/feed_entity.dart';
import 'package:bl_inshort/data/models/feeds/resource_entity.dart';
import 'package:bl_inshort/features/webview/presentation/webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  final FeedEntity item;

  const FeedCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    switch (item.layout) {
      case FeedLayoutType.photoDominant:
        return _PhotoDominantCard(item: item);
      case FeedLayoutType.textDominant:
        return _TextDominantCard(item: item);
      case FeedLayoutType.gallery:
        return _GalleryCard(item: item);
      case FeedLayoutType.story:
        return _StoryCard(item: item);
      case FeedLayoutType.htmlViewCard:
        return _HTMLViewCard(item: item);
      case FeedLayoutType.browserCard:
        return _BrowserViewCard(item: item);
      case FeedLayoutType.standardCard:
        return StandardVisualCard(item: item);
    }
  }
}

// 1) Photo-dominant layout (big image, text overlay/under)
class _PhotoDominantCard extends StatelessWidget {
  final FeedEntity item;

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
          if (item.resources.isNotEmpty)
            CachedNetworkImage(
              imageUrl: item.resources[0].url,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: size.width,
                height: size.height,
                color: Colors.grey.shade300,
              ),
              errorWidget: (_, __, ___) => Icon(Icons.image_not_supported),
            ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.7),
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.source.name.toUpperCase(),
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                  ),
                  if (item.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      item.subtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
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
  final FeedEntity item;

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
            if (item.resources.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: item.resources[0].url,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.grey.shade300,
                    ),
                    errorWidget: (_, __, ___) =>
                        Icon(Icons.image_not_supported),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
            ...[
              const SizedBox(height: 8),
              Text(
                item.subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '• ${item.source}',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3) Gallery layout (horizontal slider)
class _GalleryCard extends StatefulWidget {
  final FeedEntity item;

  const _GalleryCard({required this.item});

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  late final PageController _pageController;
  int _currentIndex = 0;

  List<String> get _images => widget.item.resources
      .where((res) => res.contentType.name == 'image')
      .map((res) => res.url)
      .toList();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final images = _images;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black,
      child: Stack(
        children: [
          // main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final url = images[index];
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            width: size.width,
                            height: size.height,
                            color: Colors.grey.shade300,
                          ),
                          errorWidget: (_, __, ___) =>
                              Icon(Icons.image_not_supported),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.source.name.toUpperCase(),
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item.title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32), // space for indicator overlay
              // 👇 bottom indicator (dots + "line"-style active)
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // dot + line indicator
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(images.length, (index) {
                        final isActive = index == _currentIndex;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          height: 6,
                          width: isActive ? 16 : 6, // line vs dot
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              isActive ? 0.95 : 0.5,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 4) Story-style layout (full bleed image, center text)
class _StoryCard extends StatelessWidget {
  final FeedEntity item;

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
          if (item.resources.isNotEmpty)
            CachedNetworkImage(
              imageUrl: item.resources.first.url,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: size.width,
                height: size.height,
                color: Colors.grey.shade300,
              ),
              errorWidget: (_, __, ___) => Icon(Icons.image_not_supported),
            ),
          Container(color: Colors.black.withOpacity(0.4)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    item.source.name.toUpperCase(),
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: Colors.white70),
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
                if (item.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    item.subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
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

// 5) html-style layout (full bleed image, center text)
class _HTMLViewCard extends StatelessWidget {
  final FeedEntity item;

  const _HTMLViewCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black,
      child: AdvancedWebView(
        initialHtml: item.html,
        title: item.title,
        enableJavaScript: true,
        showAppBar: false,
        backgroundColor: Colors.white,
        allowInlineMediaPlayback: true,
      ),
    );
  }
}

// 6) Webview-style layout
class _BrowserViewCard extends StatelessWidget {
  final FeedEntity item;

  const _BrowserViewCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black,
      child: AdvancedWebView(
        initialUrl: item.webUrl,
        title: item.title,
        enableJavaScript: true,
        showAppBar: false,
        backgroundColor: Colors.white,
        allowInlineMediaPlayback: true,
      ),
    );
  }
}

class RelatedImagesRow extends StatelessWidget {
  final List<ResourceEntity> resources;
  const RelatedImagesRow({super.key, required this.resources});

  @override
  Widget build(BuildContext context) {
    final visibleCount = resources.length.clamp(1, 3);
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      margin: const EdgeInsets.only(left: 10, right: 20, top: 0, bottom: 8),
      height: 64,
      child: Stack(
        clipBehavior: Clip.none, // 🔥 allow overflow
        children: [
          // 🔹 Main pill
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.only(
                left: 18,
                right: 16, // ❌ no arrow space reserved
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFD3D5D9),
                    Color(0xFFB4B7BD),
                    Color(0xFF8D9198),
                  ],
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Messi Kolkata Event Row",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF2E2E2E),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // 🔹 Overlapping images
                  SizedBox(
                    width: 44 + (visibleCount - 1) * 22,
                    height: 44,
                    child: Stack(
                      children: [
                        ...resources
                            .take(visibleCount)
                            .toList()
                            .asMap()
                            .entries
                            .map((entry) {
                              final idx = entry.key;
                              final resource = entry.value;
                              return _imageCircle(
                                left: idx * 22,
                                imageUrl: resource.url,
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Arrow button (HALF OUTSIDE – EXACT MATCH)
          Positioned(
            right: -18, // 🔥 critical: pushes it outside
            top: 12,
            bottom: 12,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (_) => RelatedImagesGallery(resources: resources),
                  ),
                );
              },
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF2F80ED),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _imageCircle({required double left, required String imageUrl}) {
    return Positioned(
      left: left,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // shape: BoxShape.circle,
          // border: Border.all(color: Colors.white, width: 2),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class RelatedImagesGallery extends StatefulWidget {
  final List<ResourceEntity> resources;

  const RelatedImagesGallery({super.key, required this.resources});

  @override
  State<RelatedImagesGallery> createState() => _RelatedImagesGalleryState();
}

class _RelatedImagesGalleryState extends State<RelatedImagesGallery> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _controlsVisible = true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // ===============================
            // MAIN IMAGE SLIDER
            // ===============================
            GestureDetector(
              onTap: _toggleControls,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.resources.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.resources[index].url,
                        fit: BoxFit.contain,
                        progressIndicatorBuilder: (context, child, progress) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            // ===============================
            // TOP BAR CONTROLS
            // ===============================
            AnimatedOpacity(
              opacity: _controlsVisible ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        // TODO: integrate share logic
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ===============================
            // PAGE INDICATOR
            // ===============================
            AnimatedOpacity(
              opacity: _controlsVisible ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / ${widget.resources.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
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

class StandardVisualCard extends StatelessWidget {
  final FeedEntity item;

  const StandardVisualCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      height: 560,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Colors.black,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // IMAGE + CONTENT
          Expanded(
            child: Stack(
              children: [
                // Images (2 split)
                Row(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: item.resources.isNotEmpty
                            ? item.resources[0].url
                            : "",
                        fit: BoxFit.cover,
                        height: 400,
                        placeholder: (_, __) => Container(
                          width: 400,
                          height: 400,
                          color: Colors.grey.shade300,
                        ),
                        errorWidget: (_, __, ___) =>
                            Icon(Icons.image_not_supported),
                      ),
                    ),
                  ],
                ),

                // Dark gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ),

                // Content
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 360,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    color: Colors.black, // 🔥 SOLID BLACK BACKGROUND
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 🔹 Top row: badges
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.fiber_new_sharp,
                                    size: 12,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "yalla news",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.bookmark_border,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 12),
                                  Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // 🔹 Title
                        Text(
                          item.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // 🔹 Body
                        Text(
                          item.description,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14.5,
                            height: 1.45,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // 🔹 Meta
                        Text(
                          "${item.publishedAt.toUtc().toLocal().toString().split(' ')[0]} | ${item.source.name} | ${item.author.name}",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom CTA strip
          Column(
            children: [
              // const SizedBox(height: 8),
              item.resources.isNotEmpty && item.resources.length > 1
                  ? RelatedImagesRow(resources: item.resources)
                  : Container(
                      height: 56,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 40, 33, 48),
                            Color(0xFF2E3440),
                            Color(0xFF1B1F27),
                          ],
                        ),
                      ),
                      child: const Text(
                        "People called the robbery 'brazen'\nTap to know what more they said",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
