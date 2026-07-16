import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/comment.dart';
import '../domain/comments_controller.dart';
import 'comment_tile.dart';

/// Drop-in widget that shows comments / internal notes for any entity.
///
/// Embed this in any detail page:
/// ```dart
/// EntityCommentsView(
///   entityType: 'purchaseOrder',
///   entityId: 'PO-2026-000001',
/// )
/// ```
class EntityCommentsView extends ConsumerWidget {
  const EntityCommentsView({
    super.key,
    required this.entityType,
    required this.entityId,
    this.currentUser = 'current_user',
  });

  final String entityType;
  final String entityId;
  final String currentUser;

  CommentsParams get _params =>
      CommentsParams(entityType: entityType, entityId: entityId);

  Future<void> _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: Text(l10n.commentAdd),
          content: SizedBox(
            width: 380,
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: l10n.commentAddPlaceholder,
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
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final comment = Comment(
                  id: '',
                  entityType: entityType,
                  entityId: entityId,
                  author: currentUser,
                  createdAt: DateTime.now(),
                  message: messageController.text.trim(),
                );
                final result = await ref
                    .read(commentsControllerProvider(_params).notifier)
                    .addComment(comment);
                if (!dialogCtx.mounted) return;
                if (result == null || !result.isSuccess) {
                  ScaffoldMessenger.of(dialogCtx).showSnackBar(
                    SnackBar(
                      content: Text(
                        result?.error?.message ?? l10n.commentAddError,
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
    final commentsAsync = ref.watch(commentsControllerProvider(_params));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Text(
                l10n.commentsSectionTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showAddDialog(context, ref, l10n),
                icon: const Icon(Icons.add_comment_outlined, size: 16),
                label: Text(l10n.commentAdd),
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ),
        commentsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: AppLoadingState(),
          ),
          error: (error, _) =>
              AppErrorState(message: '${l10n.commentLoadError} $error'),
          data: (comments) {
            if (comments.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AppEmptyState(
                  title: l10n.commentEmptyTitle,
                  message: l10n.commentEmptyMessage,
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return CommentTile(comment: comments[index], params: _params);
              },
            );
          },
        ),
      ],
    );
  }
}
