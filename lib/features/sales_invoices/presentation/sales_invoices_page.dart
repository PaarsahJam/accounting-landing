import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../customers/domain/customer.dart';
import '../data/sales_invoices_repository_provider.dart';
import '../domain/sales_invoice.dart';
import '../domain/sales_invoice_line.dart';
import '../domain/sales_invoice_status.dart';
import '../domain/sales_invoices_controller.dart';

class SalesInvoicesPage extends ConsumerStatefulWidget {
  const SalesInvoicesPage({super.key});

  @override
  ConsumerState<SalesInvoicesPage> createState() => _SalesInvoicesPageState();
}

class _SalesInvoicesPageState extends ConsumerState<SalesInvoicesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _statusId = 'draft';
  String _search = '';
  String? _selectedCustomerId;
  final List<_InvoiceLineEditor> _lineEditors = [];

  @override
  void dispose() {
    _referenceController.dispose();
    _titleController.dispose();
    _notesController.dispose();
    _customerController.dispose();
    _dueDateController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  SalesInvoiceStatus _statusForSelection(String id) {
    switch (id) {
      case 'sent':
        return const SalesInvoiceStatus(
          id: 'sent',
          label: 'Sent',
          color: 'blue',
        );
      case 'partial':
        return const SalesInvoiceStatus(
          id: 'partial',
          label: 'Partially Paid',
          color: 'amber',
        );
      case 'paid':
        return const SalesInvoiceStatus(
          id: 'paid',
          label: 'Paid',
          color: 'green',
        );
      case 'overdue':
        return const SalesInvoiceStatus(
          id: 'overdue',
          label: 'Overdue',
          color: 'red',
        );
      case 'draft':
      default:
        return const SalesInvoiceStatus(
          id: 'draft',
          label: 'Draft',
          color: 'grey',
        );
    }
  }

  void _addLineEditor() {
    setState(() {
      _lineEditors.add(_InvoiceLineEditor());
    });
  }

  SalesInvoice _buildInvoice({SalesInvoice? existingInvoice}) {
    final lines = _lineEditors
        .map(
          (editor) => SalesInvoiceLine(
            id: 'SIL-${DateTime.now().millisecondsSinceEpoch + editor.hashCode}',
            description: editor.descriptionController.text.trim(),
            quantity:
                double.tryParse(editor.quantityController.text.trim()) ?? 0,
            unitPrice:
                double.tryParse(editor.unitPriceController.text.trim()) ?? 0,
          ),
        )
        .where((line) => line.description.isNotEmpty)
        .toList();

    final subtotal = lines.fold<double>(
      0,
      (sum, line) => sum + (line.quantity * line.unitPrice),
    );
    final tax = subtotal * 0.1;
    final total = subtotal + tax;

    final customer = _selectedCustomerId != null
        ? _selectedCustomerId!
        : _customerController.text.trim();

    return (existingInvoice ??
            SalesInvoice(
              id: '',
              customerId: '',
              customerName: '',
              reference: '',
              title: '',
              notes: '',
              invoiceDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 14)),
              status: const SalesInvoiceStatus(
                id: 'draft',
                label: 'Draft',
                color: 'grey',
              ),
              lines: const [],
              subtotal: 0,
              tax: 0,
              total: 0,
            ))
        .copyWith(
          id:
              existingInvoice?.id ??
              'INV-${DateTime.now().millisecondsSinceEpoch}',
          customerId: customer,
          customerName: customer,
          reference: _referenceController.text.trim(),
          title: _titleController.text.trim(),
          notes: _notesController.text.trim(),
          dueDate:
              DateTime.tryParse(_dueDateController.text.trim()) ??
              DateTime.now().add(const Duration(days: 14)),
          status: _statusForSelection(_statusId),
          lines: lines,
          subtotal: subtotal,
          tax: tax,
          total: total,
        );
  }

  Future<void> _submitInvoice({SalesInvoice? existingInvoice}) async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(salesInvoicesControllerProvider.notifier);
    final invoice = _buildInvoice(existingInvoice: existingInvoice);

    if (existingInvoice == null) {
      await controller.createSalesInvoice(invoice);
    } else {
      await controller.updateSalesInvoice(invoice);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _showInvoiceDialog({SalesInvoice? invoice}) async {
    final l10n = AppLocalizations.of(context)!;
    final repository = ref.read(salesInvoicesRepositoryProvider);
    final customersResult = await repository.fetchCustomers();
    final customers = customersResult.isSuccess
        ? customersResult.data ?? const <Customer>[]
        : const <Customer>[];

    if (invoice != null) {
      _referenceController.text = invoice.reference;
      _titleController.text = invoice.title;
      _notesController.text = invoice.notes;
      _customerController.text = invoice.customerName;
      _selectedCustomerId = invoice.customerId;
      _dueDateController.text = invoice.dueDate
          .toIso8601String()
          .split('T')
          .first;
      _statusId = invoice.status.id;
      _lineEditors
        ..clear()
        ..addAll(
          invoice.lines.map((line) => _InvoiceLineEditor.fromLine(line)),
        );
    } else {
      _referenceController.clear();
      _titleController.clear();
      _notesController.clear();
      _customerController.clear();
      _dueDateController.text = DateTime.now()
          .add(const Duration(days: 14))
          .toIso8601String()
          .split('T')
          .first;
      _selectedCustomerId = null;
      _statusId = 'draft';
      _lineEditors.clear();
      _addLineEditor();
    }

    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            invoice == null
                ? l10n.salesInvoiceAddTitle
                : l10n.salesInvoiceEditTitle,
          ),
          content: SizedBox(
            width: 560,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _referenceController,
                      decoration: InputDecoration(
                        labelText: l10n.salesInvoiceReference,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: l10n.salesInvoiceTitle,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCustomerId,
                      decoration: InputDecoration(
                        labelText: l10n.salesInvoiceCustomer,
                      ),
                      items: customers
                          .map(
                            (customer) => DropdownMenuItem<String>(
                              value: customer.id,
                              child: Text(
                                '${customer.name} (${customer.company})',
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _selectedCustomerId = value),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _dueDateController,
                      decoration: InputDecoration(
                        labelText: l10n.salesInvoiceDueDate,
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _statusId,
                      decoration: InputDecoration(
                        labelText: l10n.salesInvoiceStatus,
                      ),
                      items: const [
                        DropdownMenuItem(value: 'draft', child: Text('Draft')),
                        DropdownMenuItem(value: 'sent', child: Text('Sent')),
                        DropdownMenuItem(
                          value: 'partial',
                          child: Text('Partially Paid'),
                        ),
                        DropdownMenuItem(value: 'paid', child: Text('Paid')),
                        DropdownMenuItem(
                          value: 'overdue',
                          child: Text('Overdue'),
                        ),
                      ],
                      onChanged: (value) =>
                          setState(() => _statusId = value ?? 'draft'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: l10n.salesInvoiceNotes,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          l10n.salesInvoiceLinesLabel,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: _addLineEditor,
                          icon: const Icon(Icons.add),
                          label: Text(l10n.salesInvoiceAddLine),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ..._lineEditors.map((editor) => _buildLineEditor(editor)),
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
                invoice == null
                    ? l10n.salesInvoiceCreate
                    : l10n.salesInvoiceSave,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLineEditor(_InvoiceLineEditor editor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          TextFormField(
            controller: editor.descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: editor.quantityController,
                  decoration: const InputDecoration(labelText: 'Qty'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: editor.unitPriceController,
                  decoration: const InputDecoration(labelText: 'Unit price'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final invoicesAsync = ref.watch(salesInvoicesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.salesInvoicesPageTitle),
        actions: [
          IconButton(
            onPressed: () => _showInvoiceDialog(),
            icon: const Icon(Icons.add_circle_outline),
            tooltip: l10n.salesInvoiceAddTitle,
          ),
        ],
      ),
      body: invoicesAsync.when(
        loading: () => const AppLoadingState(message: 'Loading sales invoices'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.salesInvoicesLoadError} $error'),
        data: (invoices) {
          final filtered = invoices.where((invoice) {
            final query = _search.toLowerCase();
            return query.isEmpty ||
                invoice.reference.toLowerCase().contains(query) ||
                invoice.title.toLowerCase().contains(query);
          }).toList();

          if (filtered.isEmpty) {
            return AppEmptyState(
              title: l10n.salesInvoicesEmptyTitle,
              message: l10n.salesInvoicesEmptyMessage,
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: l10n.salesInvoiceSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _search = value),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final invoice = filtered[index];
                    return Card(
                      child: ListTile(
                        title: Text('${invoice.reference} • ${invoice.title}'),
                        subtitle: Text(
                          '${invoice.customerName} • ${invoice.total.toStringAsFixed(0)}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Chip(label: Text(invoice.status.label)),
                            IconButton(
                              onPressed: () => context.push(
                                '/sales-invoices/${invoice.id}',
                                extra: invoice,
                              ),
                              icon: const Icon(Icons.visibility),
                              tooltip: l10n.salesInvoiceDetailTitle,
                            ),
                            IconButton(
                              onPressed: () =>
                                  _showInvoiceDialog(invoice: invoice),
                              icon: const Icon(Icons.edit),
                              tooltip: l10n.salesInvoiceEditTitle,
                            ),
                            IconButton(
                              onPressed: () async => ref
                                  .read(
                                    salesInvoicesControllerProvider.notifier,
                                  )
                                  .deleteSalesInvoice(invoice.id),
                              icon: const Icon(Icons.delete),
                              tooltip: l10n.salesInvoiceDeleteTitle,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InvoiceLineEditor {
  _InvoiceLineEditor({SalesInvoiceLine? line}) {
    descriptionController = TextEditingController(
      text: line?.description ?? '',
    );
    quantityController = TextEditingController(
      text: line?.quantity.toString() ?? '',
    );
    unitPriceController = TextEditingController(
      text: line?.unitPrice.toString() ?? '',
    );
  }

  late final TextEditingController descriptionController;
  late final TextEditingController quantityController;
  late final TextEditingController unitPriceController;

  factory _InvoiceLineEditor.fromLine(SalesInvoiceLine line) =>
      _InvoiceLineEditor(line: line);
}
