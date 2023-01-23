import 'package:bingnuos_admin_panel/providers/app_theme_provider.dart';
import 'package:bingnuos_admin_panel/services/app_router.dart';
import 'package:bingnuos_admin_panel/services/firebase/auth_service.dart';
import 'package:bingnuos_admin_panel/services/hive_service.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bingnuos_admin_panel/utils/stream_extensions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // if (kDebugMode) {
  //   try {
  //     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   } catch (e) {
  //     Logger.e("Firebase emulator Error", e);
  //   }
  // }

  await HiveService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppThemeProvider(),
        ),
        Provider(
          create: (_) => AuthService(),
        ),
        Provider(
          create: (_) => HiveService(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ValueListenable<User?> userChanges;

  @override
  void initState() {
    final authService = context.read<AuthService>();
    authService.initialize();
    userChanges =
        authService.authStateChanges.toValueNotifier(authService.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(userChanges).router;

    return Consumer<AppThemeProvider>(
      builder: (context, themeProvider, _) {
        return ValueListenableBuilder<Box<String>>(
          valueListenable:
              Provider.of<HiveService>(context).languageBoxListenable,
          builder: (context, box, child) {
            final locale = box.get(HiveService.LANGUAGE_BOX_KEY) ?? 'en';
            return MaterialApp.router(
              locale: Locale.fromSubtags(languageCode: locale),
              theme: themeProvider.selectedTheme,
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              debugShowCheckedModeBanner: false,
              title: AppLocale(context).appName,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('uk', ''),
                Locale('ru', ''),
              ],
              scrollBehavior: AppScrollBehavior(),
            );
          },
        );
      },
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
