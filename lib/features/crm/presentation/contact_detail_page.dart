import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../attachments/presentation/entity_attachments_view.dart';
import '../../audit_trail/domain/audit_entity_type.dart';
import '../../audit_trail/domain/audit_trail_controller.dart';
import '../../audit_trail/presentation/widgets/audit_trail_view.dart';
import '../../comments/presentation/entity_comments_view.dart';
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

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(contact.fullName),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Info'),
              Tab(text: l10n.interactionsSectionTitle),
              Tab(text: l10n.attachmentsSectionTitle),
              Tab(text: l10n.commentsSectionTitle),
              Tab(text: 'Audit Trail'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _InfoTab(contact: contact),
            EntityInteractionsView(
              contactId: contact.id,
              customerId: customerId,
            ),
            EntityAttachmentsView(
              entityType: AuditEntityType.contact.name,
              entityId: contact.id,
            ),
            EntityCommentsView(
              entityType: AuditEntityType.contact.name,
              entityId: contact.id,
            ),
            _AuditTrailTab(entityType: AuditEntityType.contact, entityId: contact.id),
          ],
        ),
      ),
    );
  }
}

class _InfoTab extends StatelessWidget {
  const _InfoTab({required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ListView(
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
      ],
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

class _AuditTrailTab extends ConsumerWidget {
  const _AuditTrailTab({required this.entityType, required this.entityId});

  final AuditEntityType entityType;
  final String entityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEntries =
        ref.watch(entityAuditTrailControllerProvider(entityType, entityId));
    return asyncEntries.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text(
          'Error loading audit trail: $e',
          style: const TextStyle(color: Colors.red),
        ),
      ),
      data: (entries) => AuditTrailView.forEntity(
        entries: entries,
        entityType: entityType,
        entityId: entityId,
      ),
    );
  }
}
