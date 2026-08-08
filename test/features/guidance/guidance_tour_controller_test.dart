import 'package:accounting_app/features/guidance/domain/guidance_tour.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('starts with the first step visible', () {
    final controller = GuidanceTourController();
    final target = GlobalKey();

    controller.start([
      GuidanceTourStep(title: 'A', body: 'Body A', targetKey: target),
      GuidanceTourStep(title: 'B', body: 'Body B'),
    ]);

    expect(controller.isVisible, isTrue);
    expect(controller.currentIndex, 0);
    expect(controller.currentStep?.title, 'A');
    expect(controller.isLast, isFalse);
  });

  test('next advances through steps and marks the last one', () {
    final controller = GuidanceTourController();
    controller.start([
      GuidanceTourStep(title: 'A', body: 'Body A'),
      GuidanceTourStep(title: 'B', body: 'Body B'),
    ]);

    controller.next();
    expect(controller.currentIndex, 1);
    expect(controller.currentStep?.title, 'B');
    expect(controller.isLast, isTrue);

    controller.next();
    expect(controller.currentIndex, 1);
    expect(controller.currentStep?.title, 'B');
  });

  test('stop hides the tour and resets state', () {
    final controller = GuidanceTourController();
    controller.start([GuidanceTourStep(title: 'A', body: 'Body A')]);
    expect(controller.isVisible, isTrue);

    controller.stop();

    expect(controller.isVisible, isFalse);
    expect(controller.currentStep, isNull);
    expect(controller.steps, isEmpty);
  });

  test('notifies listeners on start, next and stop', () {
    final controller = GuidanceTourController();
    var notifications = 0;
    controller.addListener(() => notifications++);

    controller.start([
      GuidanceTourStep(title: 'A', body: 'Body A'),
      GuidanceTourStep(title: 'B', body: 'Body B'),
    ]);
    controller.next();
    controller.stop();

    expect(notifications, 3);
  });
}
