import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/expenses_controller.dart';

class ExpensesPage extends ConsumerWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final expensesAsync = ref.watch(expensesControllerProvider);

    return Shortcuts(
      shortcuts: {
        const SingleActivator(LogicalKeyboardKey.keyR, control: true):
            const _RefreshExpensesIntent(),
      },
      child: Actions(
        actions: {
          _RefreshExpensesIntent: CallbackAction<_RefreshExpensesIntent>(
            onInvoke: (_) async {
              await ref.read(expensesControllerProvider.notifier).refresh();
              return null;
            },
          ),
        },
        child: ResponsivePageScaffold(
          title: l10n.expensesPageTitle,
          actions: [
            Semantics(
              button: true,
              label: 'Refresh expenses',
              child: IconButton(
                onPressed: () =>
                    ref.read(expensesControllerProvider.notifier).refresh(),
                icon: const Icon(Icons.refresh),
                tooltip: l10n.refresh,
              ),
            ),
          ],
          child: expensesAsync.when(
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) =>
                AppErrorState(message: '${l10n.expensesLoadError} $error'),
            data: (expenses) {
              if (expenses.isEmpty) {
                return AppEmptyState(
                  title: l10n.expensesEmptyTitle,
                  message: l10n.expensesEmptyMessage,
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: expenses.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return Card(
                    child: ListTile(
                      title: Text(expense.merchant),
                      subtitle: Text(expense.description),
                      trailing: Text(
                        '${expense.amount.toStringAsFixed(0)} ${l10n.currencyUnit}',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RefreshExpensesIntent extends Intent {
  const _RefreshExpensesIntent();
}
