import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../domain/vendor.dart';
import '../domain/vendors_controller.dart';

class VendorsPage extends ConsumerStatefulWidget {
  const VendorsPage({super.key});

  @override
  ConsumerState<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends ConsumerState<VendorsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  late final TextEditingController _companyNameController;
  late final TextEditingController _contactNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _taxIdentifierController;
  late final TextEditingController _notesController;
  late final TextEditingController _activeController;

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController();
    _contactNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _taxIdentifierController = TextEditingController();
    _notesController = TextEditingController();
    _activeController = TextEditingController(text: 'true');
  }

  @override
  void dispose() {
    _searchController.dispose();
    _companyNameController.dispose();
    _contactNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _taxIdentifierController.dispose();
    _notesController.dispose();
    _activeController.dispose();
    super.dispose();
  }

  Future<void> _submitVendor({Vendor? existingVendor}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final controller = ref.read(vendorsControllerProvider.notifier);
    final now = DateTime.now();
    final vendor =
        (existingVendor ??
                Vendor(
                  id: '',
                  companyName: '',
                  contactName: '',
                  email: '',
                  phone: '',
                  address: '',
                  taxIdentifier: '',
                  notes: '',
                  isActive: true,
                  createdAt: now,
                  updatedAt: now,
                ))
            .copyWith(
              id: existingVendor?.id ?? 'VEN-${now.millisecondsSinceEpoch}',
              companyName: _companyNameController.text.trim(),
              contactName: _contactNameController.text.trim(),
              email: _emailController.text.trim(),
              phone: _phoneController.text.trim(),
              address: _addressController.text.trim(),
              taxIdentifier: _taxIdentifierController.text.trim(),
              notes: _notesController.text.trim(),
              isActive: _activeController.text.trim().toLowerCase() != 'false',
              createdAt: existingVendor?.createdAt ?? now,
              updatedAt: now,
            );

    if (existingVendor == null) {
      await controller.createVendor(vendor);
    } else {
      await controller.updateVendor(vendor);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _showVendorDialog({Vendor? vendor}) async {
    final l10n = AppLocalizations.of(context)!;

    if (vendor != null) {
      _companyNameController.text = vendor.companyName;
      _contactNameController.text = vendor.contactName;
      _emailController.text = vendor.email;
      _phoneController.text = vendor.phone;
      _addressController.text = vendor.address;
      _taxIdentifierController.text = vendor.taxIdentifier;
      _notesController.text = vendor.notes;
      _activeController.text = vendor.isActive ? 'true' : 'false';
    } else {
      _companyNameController.clear();
      _contactNameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _addressController.clear();
      _taxIdentifierController.clear();
      _notesController.clear();
      _activeController.text = 'true';
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            vendor == null ? l10n.vendorAddTitle : l10n.vendorEditTitle,
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
                      controller: _companyNameController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorCompanyName,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _contactNameController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorContactName,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: l10n.vendorEmail),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: l10n.vendorPhone),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorAddress,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _taxIdentifierController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorTaxIdentifier,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _activeController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorActiveStatus,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(labelText: l10n.vendorNotes),
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
              onPressed: () => _submitVendor(existingVendor: vendor),
              child: Text(vendor == null ? l10n.vendorCreate : l10n.vendorSave),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteVendor(String id) async {
    final controller = ref.read(vendorsControllerProvider.notifier);
    await controller.deleteVendor(id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final vendorsAsync = ref.watch(vendorsControllerProvider);
    final searchValue = _searchController.text.trim().toLowerCase();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.vendorsPageTitle),
        actions: [
          IconButton(
            onPressed: () => _showVendorDialog(),
            icon: const Icon(Icons.add_business),
            tooltip: l10n.vendorAddTitle,
          ),
        ],
      ),
      body: vendorsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('${l10n.vendorsLoadError} $error')),
        data: (vendors) {
          final filtered = vendors.where((vendor) {
            if (searchValue.isEmpty) return true;
            return vendor.companyName.toLowerCase().contains(searchValue) ||
                vendor.contactName.toLowerCase().contains(searchValue) ||
                vendor.email.toLowerCase().contains(searchValue);
          }).toList();

          if (filtered.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.vendorsEmptyTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(l10n.vendorsEmptyMessage),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l10n.vendorSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final vendor = filtered[index];
                    return Card(
                      child: ListTile(
                        title: Text(vendor.companyName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vendor.contactName),
                            const SizedBox(height: 4),
                            Text(vendor.email),
                            Text(
                              '${l10n.vendorStatusLabel}: ${vendor.isActive ? l10n.vendorActive : l10n.vendorInactive}',
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  _showVendorDialog(vendor: vendor),
                              icon: const Icon(Icons.edit),
                              tooltip: l10n.invoiceEditAction,
                            ),
                            IconButton(
                              onPressed: () => _deleteVendor(vendor.id),
                              icon: const Icon(Icons.delete),
                              tooltip: l10n.invoiceDeleteAction,
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
