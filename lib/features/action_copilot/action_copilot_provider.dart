import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/action_copilot_controller.dart';
import 'domain/action_copilot_draft.dart';

/// The action copilot controller: owns the current draft and its lifecycle.
///
/// Reads `null` when no draft is in progress.
final actionCopilotControllerProvider =
    NotifierProvider<ActionCopilotController, ActionCopilotDraft?>(
  ActionCopilotController.new,
);
