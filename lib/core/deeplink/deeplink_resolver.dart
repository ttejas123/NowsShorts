// Here we have different types of intents so that we can be sure if user is trying to navigate to a feed or some other screen and if it's allowed not than fallback to home screen
abstract class NavigationIntent {
  String toRoute();
}

class FeedIntent extends NavigationIntent {
  final String feedId;

  FeedIntent(this.feedId);

  @override
  String toRoute() => '/home-shell/feed/$feedId';
}

class UnknownIntent extends NavigationIntent {
  @override
  String toRoute() => '/';
}

class DeepLinkResolver {
  static String resolve(NavigationIntent intent) {
    if (intent is FeedIntent) {
      return '/feed/${intent.feedId}';
    }
    return '/';
  }
}

class StoryIntent extends NavigationIntent {
  final String id;

  StoryIntent(this.id);

  @override
  String toRoute() => '/story/$id';
}
