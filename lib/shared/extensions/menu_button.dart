import 'package:flutter/material.dart';

import '../widgets/app_shell.dart';
import 'responsive_breakpoint.dart';

extension MenuButtonExtension on BuildContext {
  Widget? get menuButton {
    if (!isPhone) return null;
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () => AppShell.openDrawer(this),
      tooltip: 'Menu',
    );
  }
}
