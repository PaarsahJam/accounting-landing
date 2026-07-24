import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/shared/extensions/responsive_breakpoint.dart';

Widget buildWithSize(Size size, Widget child) {
  return MediaQuery(
    data: MediaQueryData(size: size),
    child: child,
  );
}

void main() {
  group('ResponsiveBreakpoint on BuildContext', () {
    testWidgets('detects phone size', (tester) async {
      await tester.pumpWidget(
        buildWithSize(
          const Size(360, 800),
          Builder(builder: (context) {
            expect(context.screenSize, ScreenSize.phone);
            expect(context.isPhone, isTrue);
            expect(context.isTablet, isFalse);
            expect(context.isDesktop, isFalse);
            expect(context.useNavigationRail, isFalse);
            return const SizedBox();
          }),
        ),
      );
    });

    testWidgets('detects tablet size', (tester) async {
      await tester.pumpWidget(
        buildWithSize(
          const Size(768, 1024),
          Builder(builder: (context) {
            expect(context.screenSize, ScreenSize.tablet);
            expect(context.isTablet, isTrue);
            expect(context.isPhone, isFalse);
            expect(context.isDesktop, isFalse);
            expect(context.useNavigationRail, isFalse);
            return const SizedBox();
          }),
        ),
      );
    });

    testWidgets('detects desktop size', (tester) async {
      await tester.pumpWidget(
        buildWithSize(
          const Size(1280, 800),
          Builder(builder: (context) {
            expect(context.screenSize, ScreenSize.desktop);
            expect(context.isDesktop, isTrue);
            expect(context.isPhone, isFalse);
            expect(context.isTablet, isFalse);
            expect(context.useNavigationRail, isTrue);
            return const SizedBox();
          }),
        ),
      );
    });

    testWidgets('pagePadding is smaller on phone', (tester) async {
      await tester.pumpWidget(
        buildWithSize(
          const Size(360, 800),
          Builder(builder: (context) {
            expect(context.pagePadding, const EdgeInsets.all(12));
            return const SizedBox();
          }),
        ),
      );
    });

    testWidgets('pagePadding is larger on desktop', (tester) async {
      await tester.pumpWidget(
        buildWithSize(
          const Size(1280, 800),
          Builder(builder: (context) {
            expect(context.pagePadding, const EdgeInsets.all(16));
            return const SizedBox();
          }),
        ),
      );
    });
  });
}
