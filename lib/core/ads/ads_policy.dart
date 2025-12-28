/*
  Very important and often missed.

  Handles:

  Frequency caps

  First-item rule

  User-based rules
  Region / language rules (later)
  Backend says where
  Policy decides whether
*/

import 'package:bl_inshort/core/ads/ads_types.dart';

class AdsPolicy {
  bool shouldRenderAd(AdMeta meta) {
    // Later: frequency cap, experiments, user tier
    return true;
  }
}
