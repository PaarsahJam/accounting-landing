import '../registration/document_workflow.dart';
import '../registration/invoice_workflow.dart';
import '../registration/payment_workflow.dart';
import '../registration/vendor_bill_workflow.dart';
import 'workflow_registry.dart';

void registerAllWorkflows(WorkflowRegistry registry) {
  registry.registerAll([
    createInvoiceWorkflow(),
    createVendorBillWorkflow(),
    createPaymentWorkflow(),
    createDocumentWorkflow(),
  ]);
}
