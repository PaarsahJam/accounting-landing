// lib/features/document_numbering/widgets/approval_timeline.dart

import 'package:flutter/material.dart';

import '../document_status.dart';

/// Horizontal step-indicator showing the document's progress through the
/// approval lifecycle.  [cancelled] is displayed as a separate indicator
/// outside the normal flow.
class ApprovalTimeline extends StatelessWidget {
  const ApprovalTimeline({super.key, required this.currentStatus});

  final DocumentStatus currentStatus;

  @override
  Widget build(BuildContext context) {
    if (currentStatus == DocumentStatus.cancelled) {
      return _CancelledIndicator();
    }

    final steps = StatusTransition.timeline;
    return Row(
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          _StepNode(
            status: steps[i],
            isCurrent: steps[i] == currentStatus,
            isPast: steps.indexOf(currentStatus) > i,
          ),
          if (i < steps.length - 1)
            _StepConnector(filled: steps.indexOf(currentStatus) > i),
        ],
      ],
    );
  }
}

class _StepNode extends StatelessWidget {
  const _StepNode({
    required this.status,
    required this.isCurrent,
    required this.isPast,
  });

  final DocumentStatus status;
  final bool isCurrent;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    final Color color;
    if (isCurrent) {
      color = Theme.of(context).colorScheme.primary;
    } else if (isPast) {
      color = Colors.green;
    } else {
      color = Colors.grey.shade300;
    }

    return Tooltip(
      message: status.label,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPast || isCurrent ? color : Colors.transparent,
              border: Border.all(color: color, width: 2),
            ),
            child: isPast
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : isCurrent
                ? const SizedBox.shrink()
                : null,
          ),
          const SizedBox(height: 4),
          Text(
            status.label,
            style: TextStyle(
              fontSize: 9,
              color: isCurrent
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepConnector extends StatelessWidget {
  const _StepConnector({required this.filled});

  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        color: filled ? Colors.green : Colors.grey.shade300,
        margin: const EdgeInsets.only(bottom: 18),
      ),
    );
  }
}

class _CancelledIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.cancel_outlined, color: Colors.grey, size: 20),
        const SizedBox(width: 6),
        Text(
          DocumentStatus.cancelled.label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
