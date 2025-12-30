import 'package:bl_inshort/core/deeplink/deeplink.dart';
import 'package:bl_inshort/core/deeplink/deeplink_resolver.dart';

typedef IntentResolver = NavigationIntent? Function(DeepLink);

class DeepLinkRegistry {
  static final List<IntentResolver> _resolvers = [];

  static void register(IntentResolver resolver) {
    _resolvers.add(resolver);
  }

  static NavigationIntent resolve(DeepLink link) {
    for (final resolver in _resolvers) {
      final intent = resolver(link);
      if (intent != null) return intent;
    }
    return UnknownIntent();
  }
}
