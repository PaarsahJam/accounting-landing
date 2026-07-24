import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/shared/widgets/page_transition.dart';

Widget Function(BuildContext, Animation<double>, Animation<double>, Widget) _transitionsBuilder(
  String type,
) {
  switch (type) {
    case 'fade':
      return PageTransition.fadeTransition;
    case 'slide':
      return PageTransition.slideUpTransition;
    case 'scale':
      return PageTransition.scaleTransition;
  }
  return PageTransition.fadeTransition;
}

void main() {
  group('PageTransition transition builders', () {
    testWidgets('fadeTransition produces a FadeTransition', (tester) async {
      await tester.pumpWidget(
        _TransitionTestWidget(transitionType: 'fade'),
      );
      expect(find.byType(FadeTransition), findsOneWidget);
    });

    testWidgets('slideUpTransition produces a SlideTransition', (tester) async {
      await tester.pumpWidget(
        _TransitionTestWidget(transitionType: 'slide'),
      );
      expect(find.byType(SlideTransition), findsOneWidget);
    });

    testWidgets('scaleTransition produces a ScaleTransition', (tester) async {
      await tester.pumpWidget(
        _TransitionTestWidget(transitionType: 'scale'),
      );
      expect(find.byType(ScaleTransition), findsOneWidget);
    });
  });
}

class _TransitionTestWidget extends StatefulWidget {
  const _TransitionTestWidget({required this.transitionType});

  final String transitionType;

  @override
  State<_TransitionTestWidget> createState() => _TransitionTestWidgetState();
}

class _TransitionTestWidgetState extends State<_TransitionTestWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration.zero,
    )..value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _transitionsBuilder(widget.transitionType)(
      context,
      _controller,
      _controller,
      const SizedBox(key: ValueKey('child')),
    );
  }
}
