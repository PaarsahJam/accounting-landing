import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ai/ai_action.dart';
import '../../../core/ai/ai_providers.dart';
import '../../../core/errors/app_result.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';

class AiAssistantPage extends ConsumerStatefulWidget {
  const AiAssistantPage({super.key});

  @override
  ConsumerState<AiAssistantPage> createState() => _AiAssistantPageState();
}

class _ChatMessage {
  _ChatMessage.user(this.text)
      : isUser = true,
        isError = false;

  _ChatMessage.assistant(this.text)
      : isUser = false,
        isError = false;

  _ChatMessage.error(this.text)
      : isUser = false,
        isError = true;

  final String text;
  final bool isUser;
  final bool isError;
}

class _AiAssistantPageState extends ConsumerState<AiAssistantPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _loading = false;

  static const _createKeywords = [
    'create',
    'add',
    'new',
    'ایجاد',
    'افزودن',
    'ساخت',
    'ստեղծել',
    'ավելացնել',
  ];

  static const _editKeywords = [
    'edit',
    'update',
    'change',
    'modify',
    'ویرایش',
    'به‌روزرسانی',
    'تغییر',
    'խմբագրել',
    'փոխել',
  ];

  static const _deleteKeywords = [
    'delete',
    'remove',
    'حذف',
    'پاک',
    'հեռացնել',
    'ջնջել',
  ];

  static const _remindKeywords = [
    'remind',
    'reminder',
    'یادآوری',
    'یاداوری',
    'հիշեցնել',
    'հիշեցում',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsivePageScaffold(
      title: l10n.aiAssistantTitle,
      child: Column(
        children: [
          Expanded(
            child: _messages.isEmpty && !_loading
                ? _EmptyState(message: l10n.aiAssistantEmptyMessage)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _MessageBubble(message: _messages[index]);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: l10n.aiAssistantHint,
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      onSubmitted: (_) => _ask(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _loading ? null : _ask,
                    icon: _loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(Icons.send),
                    tooltip: l10n.aiAssistantSend,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _ask() async {
    final query = _controller.text.trim();
    if (query.isEmpty || _loading) return;

    _controller.clear();
    setState(() {
      _messages.add(_ChatMessage.user(query));
      _loading = true;
    });
    _scrollToBottom();

    try {
      final l10n = AppLocalizations.of(context)!;
      final liveContext = ref.read(aiLiveContextProvider);
      final businessContext = await liveContext.contextForQuery(query);

      final actionType = _detectActionType(query);
      if (actionType == null) {
        await _answerQuestion(query, businessContext, l10n);
      } else {
        await _draftAndConfirm(actionType, query, businessContext, l10n);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(_ChatMessage.error('$e'));
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
        _scrollToBottom();
      }
    }
  }

  Future<void> _answerQuestion(
    String query,
    String context,
    AppLocalizations l10n,
  ) async {
    final summarizer = ref.read(aiSummarizeProvider);
    final result = await summarizer.answer(query: query, context: context);
    if (!mounted) return;

    setState(() {
      _messages.add(_ChatMessage.assistant(result ?? l10n.aiAssistantError));
    });
  }

  Future<void> _draftAndConfirm(
    AiActionType actionType,
    String query,
    String context,
    AppLocalizations l10n,
  ) async {
    final draft = ref.read(aiDraftActionProvider);
    final result = await draft.draft(
      actionType: actionType,
      entityContext: context,
      userInstruction: query,
    );
    if (!mounted) return;

    if (result.confirmationRequirement == null) {
      setState(() {
        _messages.add(_ChatMessage.assistant(result.suggestion));
      });
      return;
    }

    setState(() {
      _loading = false;
    });

    final confirmed = await _showConfirmation(l10n, result.suggestion);
    if (confirmed != true || !mounted) return;

    final gateway = ref.read(aiActionGatewayProvider);
    final confirmedAction = draft.createConfirmedAction(
      actionType: actionType,
      suggestionText: result.suggestion,
      action: () async => AppResult.success(true),
    );

    final outcome = await gateway.executeConfirmed(confirmedAction);
    if (!mounted) return;

    setState(() {
      _messages.add(
        outcome.isSuccess
            ? _ChatMessage.assistant(l10n.aiAssistantActionLogged)
            : _ChatMessage.error(
                outcome.error?.message ?? l10n.aiAssistantActionFailed,
              ),
      );
    });
  }

  Future<bool?> _showConfirmation(
    AppLocalizations l10n,
    String suggestion,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.aiAssistantConfirmTitle),
        content: SingleChildScrollView(
          child: Text(l10n.aiAssistantConfirmBody(suggestion)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.aiAssistantConfirmAction),
          ),
        ],
      ),
    );
  }

  AiActionType? _detectActionType(String query) {
    final q = query.toLowerCase();
    if (_containsAny(q, _deleteKeywords)) {
      return AiActionType.draftDelete;
    }
    if (_containsAny(q, _createKeywords)) {
      return AiActionType.draftCreate;
    }
    if (_containsAny(q, _editKeywords)) {
      return AiActionType.draftUpdate;
    }
    if (_containsAny(q, _remindKeywords)) {
      return AiActionType.suggestAction;
    }
    return null;
  }

  bool _containsAny(String query, List<String> keywords) =>
      keywords.any(query.contains);

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isUser = message.isUser;

    final backgroundColor = isUser
        ? scheme.primaryContainer
        : message.isError
            ? scheme.errorContainer
            : scheme.surfaceContainerHighest;
    final foregroundColor = isUser
        ? scheme.onPrimaryContainer
        : message.isError
            ? scheme.onErrorContainer
            : scheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isUser
                ? l10n.aiAssistantYou
                : message.isError
                    ? l10n.aiAssistantError
                    : l10n.aiAssistantAssistant,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment:
                isUser ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                message.text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: foregroundColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.smart_toy_outlined, size: 56, color: scheme.primary),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
