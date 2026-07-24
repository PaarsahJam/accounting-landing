import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/contact.dart';
import 'entity_interactions_view.dart';

class ContactDetailPage extends ConsumerWidget {
  const ContactDetailPage({
    super.key,
    required this.contact,
    required this.customerId,
  });

  final Contact contact;
  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(contact.fullName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        child: Text(
                          '${contact.firstName[0]}${contact.lastName[0]}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact.fullName,
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              contact.jobTitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (contact.isPrimary)
                        Chip(
                          label: Text(
                            l10n.contactPrimaryLabel,
                            style: const TextStyle(fontSize: 11),
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                  const Divider(height: 24),
                  _InfoRow(
                    icon: Icons.email,
                    label: l10n.contactEmail,
                    value: contact.email,
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.phone,
                    label: l10n.contactPhone,
                    value: contact.phone,
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.business,
                    label: l10n.contactDepartment,
                    value: contact.department,
                  ),
                  if (contact.notes.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.notes,
                      label: l10n.contactNotes,
                      value: contact.notes,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          EntityInteractionsView(
            contactId: contact.id,
            customerId: customerId,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
        Expanded(child: Text(value)),
      ],
    );
  }
}
