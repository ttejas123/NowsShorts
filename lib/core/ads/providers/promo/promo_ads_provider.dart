import 'package:bl_inshort/data/models/feeds/feed_entity.dart';
import 'package:flutter/widgets.dart';
import '../../ads_types.dart';
import '../ad_provider.dart';

class PromoAdsProvider implements AdProvider {
  @override
  AdProviderType get type => AdProviderType.promo;

  @override
  Widget buildAd({
    required FeedEntity meta,
    required VoidCallback onLoaded,
    required VoidCallback onFailed,
  }) {
    Future.microtask(onLoaded);

    return Container(
      height: 120,
      alignment: Alignment.center,
      child: const Text('Promo Ad'),
    );
  }
}
