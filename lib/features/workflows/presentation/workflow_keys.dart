import 'package:flutter/widgets.dart';

/// Global keys for the widgets the workflow copilot points at that are not
/// already tour targets (see GuidanceTourKeys).
class WorkflowKeys {
  WorkflowKeys._();

  static final salesInvoicesAddButton = GlobalKey();
  static final customerPaymentsAddButton = GlobalKey();
  static final financialReportsHeader = GlobalKey();
}
