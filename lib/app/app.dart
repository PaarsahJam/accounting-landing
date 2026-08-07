import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/router/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_mode_provider.dart';
import '../l10n/app_localizations.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeSettingProvider);

    return MaterialApp.router(
      title: l10n?.appTitle ?? 'Accounting',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa'),
      supportedLocales: const [Locale('fa'), Locale('en')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.lightTheme(GoogleFonts.vazirmatnTextTheme()),
      darkTheme: AppTheme.darkTheme(GoogleFonts.vazirmatnTextTheme()),
      themeMode: themeMode,
      scaffoldMessengerKey: _scaffoldMessengerKey,
    );
  }

  static final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
}
