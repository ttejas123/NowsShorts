import 'package:bl_inshort/data/models/feeds/feed_entity.dart';
import 'package:flutter/widgets.dart';
import '../ads_runtime.dart';
import 'ad_fallback_widget.dart';
import 'ad_card_shell.dart';

class AdSlotWidget extends StatefulWidget {
  final FeedEntity meta;
  final AdsRuntime runtime;
  final Widget fallback;

  const AdSlotWidget({
    super.key,
    required this.meta,
    required this.runtime,
    required this.fallback,
  });

  @override
  State<AdSlotWidget> createState() => _AdSlotWidgetState();
}

class _AdSlotWidgetState extends State<AdSlotWidget> {
  bool _failed = false;

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return AdFallbackWidget(fallback: widget.fallback);
    }

    final provider = widget.runtime.resolveProvider(widget.meta);

    return AdCardShell(
      child: provider.buildAd(
        meta: widget.meta,
        onLoaded: () {},
        onFailed: () {
          setState(() => _failed = true);
        },
      ),
    );
  }
}
