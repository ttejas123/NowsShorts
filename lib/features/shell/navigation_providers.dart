import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// 0 = Discover, 1 = Feed, 2 = Search, 3 = Profile
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
