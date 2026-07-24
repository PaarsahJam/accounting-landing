import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../domain/contact.dart';
import '../domain/contacts_controller.dart';
import 'contact_detail_page.dart';

class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key, required this.customerId});

  final String customerId;

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _jobTitleController;
  late final TextEditingController _departmentController;
  late final TextEditingController _notesController;
  bool _isPrimary = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _jobTitleController = TextEditingController();
    _departmentController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _jobTitleController.dispose();
    _departmentController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _populateForm(Contact contact) {
    _firstNameController.text = contact.firstName;
    _lastNameController.text = contact.lastName;
    _emailController.text = contact.email;
    _phoneController.text = contact.phone;
    _jobTitleController.text = contact.jobTitle;
    _departmentController.text = contact.department;
    _notesController.text = contact.notes;
    _isPrimary = contact.isPrimary;
  }

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _jobTitleController.clear();
    _departmentController.clear();
    _notesController.clear();
    _isPrimary = false;
  }

  Future<void> _submit({Contact? existing}) async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(contactsControllerProvider(widget.customerId).notifier);
    final contact = (existing ?? Contact(
      id: '',
      customerId: widget.customerId,
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      jobTitle: '',
      department: '',
      isPrimary: false,
      notes: '',
    )).copyWith(
      id: existing?.id ?? 'CONT-${DateTime.now().millisecondsSinceEpoch}',
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      jobTitle: _jobTitleController.text.trim(),
      department: _departmentController.text.trim(),
      isPrimary: _isPrimary,
      notes: _notesController.text.trim(),
    );

    if (existing == null) {
      await controller.createContact(contact);
    } else {
      await controller.updateContact(contact);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _showForm({Contact? contact}) async {
    final l10n = AppLocalizations.of(context)!;
    if (contact != null) {
      _populateForm(contact);
    } else {
      _clearForm();
    }

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(contact == null ? l10n.contactCreateTitle : l10n.contactEditTitle),
          content: SizedBox(
            width: 480,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(labelText: l10n.contactFirstName),
                      validator: (v) => (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(labelText: l10n.contactLastName),
                      validator: (v) => (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: l10n.contactEmail),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: l10n.contactPhone),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _jobTitleController,
                      decoration: InputDecoration(labelText: l10n.contactJobTitle),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _departmentController,
                      decoration: InputDecoration(labelText: l10n.contactDepartment),
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      title: Text(l10n.contactPrimary),
                      value: _isPrimary,
                      onChanged: (v) => setState(() => _isPrimary = v ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(labelText: l10n.contactNotes),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () => _submit(existing: contact),
              child: Text(contact == null ? l10n.createButton : l10n.saveButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final contactsAsync = ref.watch(contactsControllerProvider(widget.customerId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.contactsPageTitle),
        actions: [
          IconButton(
            onPressed: () => _showForm(),
            icon: const Icon(Icons.person_add_alt_1),
            tooltip: l10n.contactCreateTitle,
          ),
        ],
      ),
      body: contactsAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(message: '${l10n.contactsLoadError} $error'),
        data: (contacts) {
          if (contacts.isEmpty) {
            return AppEmptyState(
              title: l10n.contactsEmptyTitle,
              message: l10n.contactsEmptyMessage,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: contacts.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      '${contact.firstName[0]}${contact.lastName[0]}',
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(contact.fullName),
                      if (contact.isPrimary)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Chip(
                            label: Text(
                              l10n.contactPrimaryLabel,
                              style: const TextStyle(fontSize: 11),
                            ),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact.jobTitle),
                      Text('${contact.email} | ${contact.phone}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _showForm(contact: contact),
                        icon: const Icon(Icons.edit),
                        tooltip: l10n.contactEditTitle,
                      ),
                      IconButton(
                        onPressed: () async {
                          await ref
                              .read(contactsControllerProvider(widget.customerId).notifier)
                              .deleteContact(contact.id);
                        },
                        icon: const Icon(Icons.delete),
                        tooltip: l10n.contactDeleteTitle,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ContactDetailPage(
                          contact: contact,
                          customerId: widget.customerId,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
