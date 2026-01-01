import 'package:bl_inshort/data/repositories/settings_repository.dart';
import 'package:bl_inshort/features/settings/controllers/settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SharedPrefsSettingsRepository(),
);

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
      final repo = ref.read(settingsRepositoryProvider);
      return SettingsController(repo);
    });
