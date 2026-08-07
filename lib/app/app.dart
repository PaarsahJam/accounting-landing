import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/l10n/locale_setting_provider.dart';
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
    final locale = ref.watch(localeSettingProvider);

    return MaterialApp.router(
      title: l10n?.appTitle ?? 'Accounting',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: LocaleSetting.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      scaffoldMessengerKey: _scaffoldMessengerKey,
    );
  }

  static final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
}
