import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/settings/settings_providers.dart';
import 'core/settings/settings_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Appearance settings are read once, before the first frame, so the theme
  // never flashes the wrong colours on start-up (Annexe D.1).
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: <Override>[
        settingsRepositoryProvider.overrideWithValue(
          SharedPreferencesSettingsRepository(preferences),
        ),
      ],
      child: const TaskFlowApp(),
    ),
  );
}
