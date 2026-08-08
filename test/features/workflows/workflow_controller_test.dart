import 'package:accounting_app/features/workflows/domain/workflow_controller.dart';
import 'package:accounting_app/features/workflows/domain/workflow_task.dart';
import 'package:flutter_test/flutter_test.dart';

WorkflowTask _task({int stepCount = 3}) => WorkflowTask(
      id: 'task',
      title: 'Task',
      description: 'Description',
      steps: List.generate(
        stepCount,
        (i) => WorkflowStep(
          id: 'step-$i',
          title: 'Title $i',
          body: 'Body $i',
          route: i.isEven ? '/alpha' : '/beta',
        ),
      ),
    );

void main() {
  group('WorkflowController', () {
    test('start makes the first step visible', () {
      final controller = WorkflowController();
      addTearDown(controller.dispose);

      controller.start(_task());

      expect(controller.isVisible, isTrue);
      expect(controller.task?.id, 'task');
      expect(controller.currentIndex, 0);
      expect(controller.currentStep?.id, 'step-0');
      expect(controller.stepNumber, 1);
      expect(controller.totalSteps, 3);
      expect(controller.isLast, isFalse);
    });

    test('start clamps a resume index into range', () {
      final controller = WorkflowController();
      addTearDown(controller.dispose);

      controller.start(_task(), fromIndex: 7);

      expect(controller.currentIndex, 2);
      expect(controller.currentStep?.id, 'step-2');
      expect(controller.isLast, isTrue);
    });

    test('start is a no-op for an empty task', () {
      final controller = WorkflowController();
      addTearDown(controller.dispose);

      controller.start(_task(stepCount: 0));

      expect(controller.isVisible, isFalse);
      expect(controller.currentStep, isNull);
    });

    test('next advances to the following step', () {
      final controller = WorkflowController();
      addTearDown(controller.dispose);
      controller.start(_task());

      controller.next();

      expect(controller.currentIndex, 1);
      expect(controller.currentStep?.id, 'step-1');
      expect(controller.isVisible, isTrue);
    });

    test('next on the last step hides the overlay', () {
      final controller = WorkflowController();
      addTearDown(controller.dispose);
      controller.start(_task(), fromIndex: 2);

      controller.next();

      expect(controller.isVisible, isFalse);
      expect(controller.currentStep, isNull);
      expect(controller.task, isNull);
    });

    test('nextStep exposes the step after the current one', () {
      final controller = WorkflowController();
      addTearDown(controller.dispose);
      controller.start(_task());

      expect(controller.nextStep?.id, 'step-1');
    });

    test('stop hides the overlay and clears the task', () {
      final controller = WorkflowController();
      addTearDown(controller.dispose);
      controller.start(_task());

      controller.stop();

      expect(controller.isVisible, isFalse);
      expect(controller.task, isNull);
      expect(controller.currentStep, isNull);
    });

    test('notifies listeners on state changes', () {
      final controller = WorkflowController();
      addTearDown(controller.dispose);

      var notified = 0;
      controller.addListener(() => notified++);

      controller.start(_task());
      controller.next();
      controller.stop();

      expect(notified, 3);
    });
  });
}
