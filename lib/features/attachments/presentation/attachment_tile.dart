import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/attachment.dart';
import '../domain/attachment_file_type.dart';
import '../domain/attachments_controller.dart';

/// A single attachment row in [EntityAttachmentsView].
class AttachmentTile extends ConsumerWidget {
  const AttachmentTile({
    super.key,
    required this.attachment,
    required this.params,
  });

  final Attachment attachment;
  final AttachmentsParams params;

  IconData _icon(AttachmentFileType type) {
    switch (type) {
      case AttachmentFileType.pdf:
        return Icons.picture_as_pdf_outlined;
      case AttachmentFileType.image:
        return Icons.image_outlined;
      case AttachmentFileType.spreadsheet:
        return Icons.table_chart_outlined;
      case AttachmentFileType.document:
        return Icons.description_outlined;
      case AttachmentFileType.archive:
        return Icons.folder_zip_outlined;
      case AttachmentFileType.other:
        return Icons.attach_file;
    }
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _showRenameDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final controller = TextEditingController(text: attachment.filename);
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.attachmentRenameTitle),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: l10n.attachmentFilename),
              autofocus: true,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                await ref
                    .read(attachmentsControllerProvider(params).notifier)
                    .renameAttachment(attachment.id, controller.text.trim());
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: Text(l10n.invoiceSave),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditNotesDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final controller = TextEditingController(text: attachment.notes);

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.attachmentEditNotesTitle),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: l10n.attachmentNotes),
            maxLines: 4,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () async {
                await ref
                    .read(attachmentsControllerProvider(params).notifier)
                    .updateNotes(attachment.id, controller.text.trim());
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: Text(l10n.invoiceSave),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmRemove(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.attachmentRemoveTitle),
          content: Text(l10n.attachmentRemoveConfirm(attachment.filename)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.attachmentRemoveAction),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      await ref
          .read(attachmentsControllerProvider(params).notifier)
          .removeAttachment(attachment.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withAlpha(80),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          _icon(attachment.fileType),
          size: 18,
          color: theme.colorScheme.primary,
        ),
      ),
      title: Text(
        attachment.filename,
        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${attachment.formattedSize} · ${_formatDate(attachment.uploadedAt)} · ${attachment.uploadedBy}'
        '${attachment.notes.isNotEmpty ? '\n${attachment.notes}' : ''}',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      isThreeLine: attachment.notes.isNotEmpty,
      trailing: PopupMenuButton<_AttachmentAction>(
        itemBuilder: (_) => [
          PopupMenuItem(
            value: _AttachmentAction.rename,
            child: Text(l10n.attachmentRenameAction),
          ),
          PopupMenuItem(
            value: _AttachmentAction.editNotes,
            child: Text(l10n.attachmentEditNotesAction),
          ),
          PopupMenuItem(
            value: _AttachmentAction.remove,
            child: Text(
              l10n.attachmentRemoveAction,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ],
        onSelected: (action) {
          switch (action) {
            case _AttachmentAction.rename:
              _showRenameDialog(context, ref, l10n);
            case _AttachmentAction.editNotes:
              _showEditNotesDialog(context, ref, l10n);
            case _AttachmentAction.remove:
              _confirmRemove(context, ref, l10n);
          }
        },
      ),
    );
  }
}

enum _AttachmentAction { rename, editNotes, remove }
