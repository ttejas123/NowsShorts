import 'package:bl_inshort/data/models/feeds/feed_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryCard extends StatefulWidget {
  final FeedEntity item;
  final String? ctaUrl; // swipe-up link

  const StoryCard({
    super.key,
    required this.item,
    this.ctaUrl,
  });

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;

  int _currentIndex = 0;
  bool _isPaused = false;

  static const storyDuration = Duration(seconds: 5);

  List<String> get images =>
      widget.item.resources.map((e) => e.url).toList();

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _progressController =
        AnimationController(vsync: this, duration: storyDuration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed && !_isPaused) {
              _nextStory();
            }
          });

    _progressController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  // -------------------- STORY NAV --------------------

  void _nextStory() {
    _progressController.reset();

    if (_currentIndex < images.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0; // infinite loop
    }

    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _progressController.forward();
  }

  void _prevStory() {
    _progressController.reset();

    if (_currentIndex > 0) {
      _currentIndex--;
    } else {
      _currentIndex = images.length - 1;
    }

    _pageController.jumpToPage(_currentIndex);
    _progressController.forward();
  }

  // -------------------- PAUSE / RESUME --------------------

  void _pause() {
    _isPaused = true;
    _progressController.stop();
  }

  void _resume() {
    _isPaused = false;
    _progressController.forward();
  }

  // -------------------- CTA --------------------

  Future<void> _openCta() async {
    if (widget.ctaUrl == null) return;

    final uri = Uri.parse(widget.ctaUrl!);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  // -------------------- UI --------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      // ⏸ LONG PRESS → PAUSE
      onLongPressStart: (_) => _pause(),
      onLongPressEnd: (_) => _resume(),

      // 👆 TAP → NEXT / PREV
      onTapDown: (details) {
        final dx = details.localPosition.dx;
        if (dx < size.width / 2) {
          _prevStory();
        } else {
          _nextStory();
        }
      },

      // ⬆️ SWIPE UP → CTA
      // onVerticalDragEnd: (details) {
      //   if (details.primaryVelocity != null &&
      //       details.primaryVelocity! < -500) {
      //     _openCta();
      //   }
      // },

      child: Container(
        width: size.width,
        height: size.height,
        color: colors.surface,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ---------------- IMAGES ----------------
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: images.length,
              itemBuilder: (_, index) {
                return CachedNetworkImage(
                  imageUrl: images[index],
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: colors.surfaceVariant,
                  ),
                  errorWidget: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                );
              },
            ),

            // ---------------- DARK OVERLAY ----------------
            Container(color: Colors.black.withOpacity(0.4)),

            // ---------------- PROGRESS BAR ----------------
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
                children: List.generate(images.length, (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: AnimatedBuilder(
                        animation: _progressController,
                        builder: (_, __) {
                          double value = 0;
                          if (index < _currentIndex) {
                            value = 1;
                          } else if (index == _currentIndex) {
                            value = _progressController.value;
                          }

                          return LinearProgressIndicator(
                            value: value,
                            backgroundColor: Colors.white24,
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.white),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),

            // ---------------- CONTENT ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.item.source.name.toUpperCase(),
                      style: textTheme.labelSmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.item.title,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.item.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      widget.item.subtitle,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                  const Spacer(),

                  // ---------------- SWIPE UP CTA ----------------
                  if (widget.ctaUrl != null)
                    Column(
                      children: const [
                        Icon(Icons.keyboard_arrow_up,
                            color: Colors.white70, size: 28),
                        SizedBox(height: 4),
                        Text(
                          "Swipe up for more",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
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