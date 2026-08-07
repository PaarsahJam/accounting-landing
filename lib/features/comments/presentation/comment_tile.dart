import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/comment.dart';
import '../domain/comments_controller.dart';

/// A single comment row in [EntityCommentsView].
class CommentTile extends ConsumerWidget {
  const CommentTile({super.key, required this.comment, required this.params});

  final Comment comment;
  final CommentsParams params;

  String _formatDate(BuildContext context, DateTime d) =>
      AppFormatters.formatIsoDateTime(
        d,
        locale: Localizations.localeOf(context).languageCode,
      );

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final controller = TextEditingController(text: comment.message);
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.commentEditTitle),
          content: SizedBox(
            width: 380,
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: l10n.commentAddPlaceholder,
                ),
                maxLines: 4,
                autofocus: true,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
              ),
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
                    .read(commentsControllerProvider(params).notifier)
                    .editComment(comment.id, controller.text.trim());
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: Text(l10n.commentEditAction),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.commentDeleteTitle),
          content: Text(l10n.commentDeleteConfirm(comment.author)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.commentDeleteAction),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      await ref
          .read(commentsControllerProvider(params).notifier)
          .deleteComment(comment.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  comment.author.isNotEmpty
                      ? comment.author[0].toUpperCase()
                      : '?',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.commentPostedBy(comment.author),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _formatDate(context, comment.createdAt),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<_CommentAction>(
                iconSize: 16,
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: _CommentAction.edit,
                    child: Text(l10n.commentEditTitle),
                  ),
                  PopupMenuItem(
                    value: _CommentAction.delete,
                    child: Text(
                      l10n.commentDeleteAction,
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                ],
                onSelected: (action) {
                  switch (action) {
                    case _CommentAction.edit:
                      _showEditDialog(context, ref, l10n);
                    case _CommentAction.delete:
                      _confirmDelete(context, ref, l10n);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.message, style: theme.textTheme.bodySmall),
                if (comment.isEdited) ...[
                  const SizedBox(height: 2),
                  Text(
                    l10n.commentEditedLabel,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _CommentAction { edit, delete }
