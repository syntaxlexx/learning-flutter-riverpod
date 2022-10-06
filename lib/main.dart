import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app_routes.dart';
import 'src/common_widgets/error_screen.dart';
import 'src/features/settings/data/providers/theme_provider.dart';
import 'src/utils/contants.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  await Hive.openBox(Constants.settingsStorageKey); // settings
  await Hive.openBox(Constants.authStorageKey); // auth

  // api getters
  // now hide splash screen
  FlutterNativeSplash.remove();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: appRoutes,
      onGenerateRoute: (settings) => appGeneratedRoutes(settings),
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => ErrorScreen(
          name: settings.name,
        ),
      ),
      theme: FlexThemeData.light(scheme: theme.scheme).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      darkTheme: FlexThemeData.dark(scheme: theme.scheme).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      themeMode: theme.mode,
    );
  }
}
