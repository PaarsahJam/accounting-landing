import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/attachment.dart';
import '../domain/attachment_file_type.dart';
import '../domain/attachments_controller.dart';
import 'attachment_tile.dart';

/// Drop-in widget that shows attachments for any entity.
///
/// Embed this in any detail page:
/// ```dart
/// EntityAttachmentsView(
///   entityType: 'salesInvoice',
///   entityId: 'SI-2026-000001',
/// )
/// ```
class EntityAttachmentsView extends ConsumerWidget {
  const EntityAttachmentsView({
    super.key,
    required this.entityType,
    required this.entityId,
    this.uploadedBy = 'current_user',
  });

  final String entityType;
  final String entityId;
  final String uploadedBy;

  AttachmentsParams get _params =>
      AttachmentsParams(entityType: entityType, entityId: entityId);

  Future<void> _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final filenameController = TextEditingController();
    final notesController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: Text(l10n.attachmentAddTitle),
          content: SizedBox(
            width: 380,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: filenameController,
                    decoration: InputDecoration(
                      labelText: l10n.attachmentFilename,
                      hintText: 'document.pdf',
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return l10n.requiredField;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: notesController,
                    decoration: InputDecoration(
                      labelText: l10n.attachmentNotes,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final filename = filenameController.text.trim();
                final attachment = Attachment(
                  id: '',
                  entityType: entityType,
                  entityId: entityId,
                  filename: filename,
                  fileType: AttachmentFileType.fromFilename(filename),
                  fileSizeBytes: (filename.length * 1024) + 4096, // mock size
                  uploadedAt: DateTime.now(),
                  uploadedBy: uploadedBy,
                  notes: notesController.text.trim(),
                );
                final result = await ref
                    .read(attachmentsControllerProvider(_params).notifier)
                    .addAttachment(attachment);
                if (!dialogCtx.mounted) return;
                if (result == null || !result.isSuccess) {
                  ScaffoldMessenger.of(dialogCtx).showSnackBar(
                    SnackBar(
                      content: Text(
                        result?.error?.message ?? l10n.attachmentAddError,
                      ),
                    ),
                  );
                } else {
                  Navigator.of(dialogCtx).pop();
                }
              },
              child: Text(l10n.createButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final attachmentsAsync = ref.watch(attachmentsControllerProvider(_params));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Text(
                l10n.attachmentsSectionTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showAddDialog(context, ref, l10n),
                icon: const Icon(Icons.attach_file, size: 16),
                label: Text(l10n.attachmentAdd),
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ),
        attachmentsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: AppLoadingState(),
          ),
          error: (error, _) =>
              AppErrorState(message: '${l10n.attachmentLoadError} $error'),
          data: (attachments) {
            if (attachments.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AppEmptyState(
                  title: l10n.attachmentEmptyTitle,
                  message: l10n.attachmentEmptyMessage,
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: attachments.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return AttachmentTile(
                  attachment: attachments[index],
                  params: _params,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
