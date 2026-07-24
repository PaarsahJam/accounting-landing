import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/extensions/menu_button.dart';
import '../domain/customer.dart';
import '../domain/customers_controller.dart';

class CustomersPage extends ConsumerStatefulWidget {
  const CustomersPage({super.key});

  @override
  ConsumerState<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends ConsumerState<CustomersPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _companyController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _balanceController;
  late final TextEditingController _statusController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _companyController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _balanceController = TextEditingController();
    _statusController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _balanceController.dispose();
    _statusController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitCustomer({Customer? existingCustomer}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final controller = ref.read(customersControllerProvider.notifier);
    final customer =
        (existingCustomer ??
                const Customer(
                  id: '',
                  name: '',
                  company: '',
                  email: '',
                  phone: '',
                  outstandingBalance: 0,
                  status: '',
                  notes: '',
                ))
            .copyWith(
              id:
                  existingCustomer?.id ??
                  'CUST-${DateTime.now().millisecondsSinceEpoch}',
              name: _nameController.text.trim(),
              company: _companyController.text.trim(),
              email: _emailController.text.trim(),
              phone: _phoneController.text.trim(),
              outstandingBalance:
                  double.tryParse(_balanceController.text.trim()) ?? 0,
              status: _statusController.text.trim().isEmpty
                  ? 'Active'
                  : _statusController.text.trim(),
              notes: _notesController.text.trim(),
            );

    if (existingCustomer == null) {
      await controller.createCustomer(customer);
    } else {
      await controller.updateCustomer(customer);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _showCustomerDialog({Customer? customer}) async {
    final l10n = AppLocalizations.of(context)!;

    if (customer != null) {
      _nameController.text = customer.name;
      _companyController.text = customer.company;
      _emailController.text = customer.email;
      _phoneController.text = customer.phone;
      _balanceController.text = customer.outstandingBalance.toString();
      _statusController.text = customer.status;
      _notesController.text = customer.notes;
    } else {
      _nameController.clear();
      _companyController.clear();
      _emailController.clear();
      _phoneController.clear();
      _balanceController.clear();
      _statusController.text = 'Active';
      _notesController.clear();
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            customer == null ? l10n.customerAddTitle : l10n.customerEditTitle,
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
                      controller: _nameController,
                      decoration: InputDecoration(labelText: l10n.customerName),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _companyController,
                      decoration: InputDecoration(
                        labelText: l10n.customerCompany,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: l10n.customerEmail,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: l10n.customerPhone,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _balanceController,
                      decoration: InputDecoration(
                        labelText: l10n.customerBalance,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _statusController,
                      decoration: InputDecoration(
                        labelText: l10n.customerStatus,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: l10n.customerNotes,
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
              onPressed: () => _submitCustomer(existingCustomer: customer),
              child: Text(
                customer == null ? l10n.customerCreate : l10n.customerSave,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCustomer(String id) async {
    final controller = ref.read(customersControllerProvider.notifier);
    await controller.deleteCustomer(id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final customersAsync = ref.watch(customersControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: context.menuButton,
        title: Text(l10n.customersPageTitle),
        actions: [
          IconButton(
            onPressed: () => _showCustomerDialog(),
            icon: const Icon(Icons.person_add_alt_1),
            tooltip: l10n.customerAddTitle,
          ),
        ],
      ),
      body: customersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('${l10n.customersLoadError} $error')),
        data: (customers) {
          if (customers.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.customersEmptyTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(l10n.customersEmptyMessage),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: customers.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final customer = customers[index];
              return Card(
                child: ListTile(
                  title: Text(customer.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customer.company),
                      const SizedBox(height: 4),
                      Text('${l10n.customerEmail}: ${customer.email}'),
                      Text(
                        '${l10n.customerBalance}: ${customer.outstandingBalance.toStringAsFixed(0)} ${l10n.currencyUnit}',
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () =>
                            _showCustomerDialog(customer: customer),
                        icon: const Icon(Icons.edit),
                        tooltip: l10n.invoiceEditAction,
                      ),
                      IconButton(
                        onPressed: () => _deleteCustomer(customer.id),
                        icon: const Icon(Icons.delete),
                        tooltip: l10n.invoiceDeleteAction,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
