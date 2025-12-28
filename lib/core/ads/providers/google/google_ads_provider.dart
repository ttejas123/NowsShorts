// import 'package:flutter/widgets.dart';
// import '../../ads_types.dart';
// import '../ad_provider.dart';

// class GoogleAdsProvider implements AdProvider {
//   @override
//   AdProviderType get type => AdProviderType.google;

//   @override
//   Widget buildAd({
//     required AdMeta meta,
//     required VoidCallback onLoaded,
//     required VoidCallback onFailed,
//   }) {
//     // TODO: Replace with Google Native Ad SDK
//     Future.microtask(onLoaded);

//     return Container(
//       height: 120,
//       alignment: Alignment.center,
//       child: const Text('Google Ad'),
//     );
//   }
// }

import 'package:bl_inshort/data/models/feeds/feed_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../ads_types.dart';
import '../ad_provider.dart';

class _GoogleNativeAdWidgetState extends State<_GoogleNativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    debugPrint('🧪 Loading Google Native Ad');
    debugPrint('🧪 adUnitId = ${widget.adUnitId}');
    _nativeAd = NativeAd(
      adUnitId: widget.adUnitId,
      factoryId: 'feedNativeAd', // IMPORTANT
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('🟢 Google Native Ad loaded');
          setState(() => _isLoaded = true);
          widget.onLoaded();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('🔴 Google Native Ad failed to load: $error');
          widget.onFailed();
        },
      ),
      request: const AdRequest(),
    );

    _nativeAd!.load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      // Keep height to avoid jump
      return const SizedBox(height: 120);
    }

    return SizedBox(height: 120, child: AdWidget(ad: _nativeAd!));
  }
}

class _GoogleNativeAdWidget extends StatefulWidget {
  final String adUnitId;
  final VoidCallback onLoaded;
  final VoidCallback onFailed;

  const _GoogleNativeAdWidget({
    required this.adUnitId,
    required this.onLoaded,
    required this.onFailed,
  });

  @override
  State<_GoogleNativeAdWidget> createState() => _GoogleNativeAdWidgetState();
}

class GoogleAdsProvider implements AdProvider {
  @override
  AdProviderType get type => AdProviderType.google;

  @override
  Widget buildAd({
    required FeedEntity meta,
    required VoidCallback onLoaded,
    required VoidCallback onFailed,
  }) {
    return _GoogleNativeAdWidget(
      adUnitId: meta.provider.id,
      onLoaded: onLoaded,
      onFailed: onFailed,
    );
  }
}
