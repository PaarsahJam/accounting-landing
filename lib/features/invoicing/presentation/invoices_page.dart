import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/invoice_card.dart';
import '../../../shared/widgets/invoice_empty_state.dart';
import '../domain/invoice.dart';
import '../domain/invoices_controller.dart';

class InvoicesPage extends ConsumerStatefulWidget {
  const InvoicesPage({super.key});

  @override
  ConsumerState<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends ConsumerState<InvoicesPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _customerController;
  late final TextEditingController _amountController;
  late final TextEditingController _statusController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _customerController = TextEditingController();
    _amountController = TextEditingController();
    _statusController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _customerController.dispose();
    _amountController.dispose();
    _statusController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitInvoice({Invoice? existingInvoice}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    final controller = ref.read(invoicesControllerProvider.notifier);
    final invoice =
        (existingInvoice ??
                const Invoice(
                  id: '',
                  customer: '',
                  amount: 0,
                  status: '',
                  description: '',
                ))
            .copyWith(
              id:
                  existingInvoice?.id ??
                  'INV-${DateTime.now().millisecondsSinceEpoch}',
              customer: _customerController.text.trim(),
              amount: double.tryParse(_amountController.text.trim()) ?? 0,
              status: _statusController.text.trim().isEmpty
                  ? l10n.invoiceStatusPending
                  : _statusController.text.trim(),
              description: _descriptionController.text.trim(),
            );

    if (existingInvoice == null) {
      await controller.createInvoice(invoice);
    } else {
      await controller.updateInvoice(invoice);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _deleteInvoice(String id) async {
    final controller = ref.read(invoicesControllerProvider.notifier);
    await controller.deleteInvoice(id);
    if (!mounted) return;
  }

  Future<void> _showInvoiceDialog({Invoice? invoice}) async {
    final l10n = AppLocalizations.of(context)!;

    if (invoice != null) {
      _customerController.text = invoice.customer;
      _amountController.text = invoice.amount.toString();
      _statusController.text = invoice.status;
      _descriptionController.text = invoice.description;
    } else {
      _customerController.clear();
      _amountController.clear();
      _statusController.text = l10n.invoiceStatusPending;
      _descriptionController.clear();
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            invoice == null ? l10n.invoiceAddTitle : l10n.invoiceEditTitle,
          ),
          content: SizedBox(
            width: 480,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _customerController,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: l10n.invoiceCustomer,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.invoiceRequiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: l10n.invoiceAmount,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.invoiceRequiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _statusController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.invoiceStatus,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: l10n.invoiceDescription,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () => _submitInvoice(existingInvoice: invoice),
              child: Text(
                invoice == null ? l10n.invoiceCreate : l10n.invoiceSave,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final invoicesAsync = ref.watch(invoicesControllerProvider);
    final isWide = MediaQuery.of(context).size.width >= 900;

    return Shortcuts(
      shortcuts: {
        const SingleActivator(LogicalKeyboardKey.keyN, control: true):
            const _NewInvoiceIntent(),
      },
      child: Actions(
        actions: {
          _NewInvoiceIntent: CallbackAction<_NewInvoiceIntent>(
            onInvoke: (_) {
              _showInvoiceDialog();
              return null;
            },
          ),
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.invoicePageTitle),
            actions: [
              IconButton(
                onPressed: () => _showInvoiceDialog(),
                icon: const Icon(Icons.add),
                tooltip: l10n.invoiceAddTitle,
              ),
            ],
          ),
          body: invoicesAsync.when(
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) =>
                AppErrorState(message: '${l10n.invoiceLoadError} $error'),
            data: (invoices) {
              if (invoices.isEmpty) {
                return InvoiceEmptyState(
                  title: l10n.invoiceEmptyTitle,
                  message: l10n.invoiceEmptyMessage,
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = isWide ? 2 : 1;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isWide ? 1.35 : 1.6,
                    ),
                    itemCount: invoices.length,
                    itemBuilder: (context, index) {
                      final invoice = invoices[index];
                      return InvoiceCard(
                        invoice: invoice,
                        onEdit: () => _showInvoiceDialog(invoice: invoice),
                        onDelete: () => _deleteInvoice(invoice.id),
                        editTooltip: l10n.invoiceEditAction,
                        deleteTooltip: l10n.invoiceDeleteAction,
                        currencyLabel: l10n.invoiceCurrencyUnit,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NewInvoiceIntent extends Intent {
  const _NewInvoiceIntent();
}
