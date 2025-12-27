/*
    Rules:

    Provider never touches FeedEntity
    Provider never handles fallback
    Provider never decides placement
    Provider only renders ad
    This is exactly like OAuth providers.

    🔒 Rules enforced:

    Providers render UI
    Providers report state
    Providers know nothing else
*/

import 'package:bl_inshort/data/models/feeds/feed_entity.dart';
import 'package:flutter/widgets.dart';
import '../ads_types.dart';

abstract class AdProvider {
  AdProviderType get type;

  Widget buildAd({
    required FeedEntity meta,
    required VoidCallback onLoaded,
    required VoidCallback onFailed,
  });
}
