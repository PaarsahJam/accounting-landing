import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/secure_storage.dart';

final localeSettingProvider =
    NotifierProvider<LocaleSetting, Locale>(LocaleSetting.new);

class LocaleSetting extends Notifier<Locale> {
  static const _key = 'app_locale';

  static const supportedLocales = [
    Locale('en'),
    Locale('fa'),
    Locale('hy'),
  ];

  @override
  Locale build() {
    _load();
    return const Locale('fa');
  }

  Future<void> _load() async {
    final storage = SecureStorage.instance;
    final value = await storage.read(_key);
    if (value != null) {
      state = Locale(value);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final storage = SecureStorage.instance;
    await storage.write(_key, locale.languageCode);
  }
}
