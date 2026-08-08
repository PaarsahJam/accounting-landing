import 'package:accounting_app/features/guidance/domain/contextual_tip.dart';
import 'package:accounting_app/features/guidance/domain/contextual_tip_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('start shows the first tip and marks visibility', () {
    final controller = ContextualTipController();
    final target = GlobalKey();

    controller.start([
      ContextualTip(id: 'invoice', title: 'A', body: 'Body A', targetKey: target),
      const ContextualTip(id: 'profit', title: 'B', body: 'Body B'),
    ]);

    expect(controller.isVisible, isTrue);
    expect(controller.currentIndex, 0);
    expect(controller.currentTip?.id, 'invoice');
    expect(controller.currentTip?.title, 'A');
    expect(controller.isLast, isFalse);
  });

  test('start with no tips stays hidden', () {
    final controller = ContextualTipController();
    controller.start(const []);
    expect(controller.isVisible, isFalse);
    expect(controller.currentTip, isNull);
  });

  test('next advances and hides after the last tip', () {
    final controller = ContextualTipController();
    controller.start(const [
      ContextualTip(id: 'invoice', title: 'A', body: 'Body A'),
      ContextualTip(id: 'profit', title: 'B', body: 'Body B'),
    ]);

    controller.next();
    expect(controller.currentIndex, 1);
    expect(controller.currentTip?.id, 'profit');
    expect(controller.isLast, isTrue);

    controller.next();
    expect(controller.isVisible, isFalse);
    expect(controller.currentTip, isNull);
  });

  test('stop hides the tips and resets state', () {
    final controller = ContextualTipController();
    controller.start(const [ContextualTip(id: 'invoice', title: 'A', body: 'B')]);
    expect(controller.isVisible, isTrue);

    controller.stop();
    expect(controller.isVisible, isFalse);
    expect(controller.currentTip, isNull);
    expect(controller.queue, isEmpty);
  });

  test('notifies listeners on start, next and stop', () {
    final controller = ContextualTipController();
    var notifications = 0;
    controller.addListener(() => notifications++);

    controller.start(const [ContextualTip(id: 'invoice', title: 'A', body: 'B')]);
    controller.next();
    controller.stop();

    expect(notifications, 3);
  });
}
