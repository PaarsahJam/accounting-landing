import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../company_controller.dart';

class CompanySelectionPage extends ConsumerWidget {
  const CompanySelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesAsync = ref.watch(companyListProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.appTitle ?? 'Select Company'),
      ),
      body: companiesAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (companies) {
          if (companies.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n?.createCompany ?? 'Create your first company'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.go('/company/create'),
                    child: Text(l10n?.createCompany ?? 'Create Company'),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: companies.length + 1,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, index) {
              if (index == companies.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/company/create'),
                    icon: const Icon(Icons.add),
                    label: Text(l10n?.createCompany ?? 'Create Company'),
                  ),
                );
              }
              final company = companies[index];
              final isActive = company.isActive;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Text(
                    company.initials,
                    style: TextStyle(
                      color: isActive
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                title: Text(company.name),
                subtitle: Text(
                  '${company.legalName ?? ''}${company.taxId != null ? ' • ${company.taxId}' : ''}',
                ),
                enabled: isActive,
                trailing: const Icon(Icons.chevron_right),
                onTap: isActive
                    ? () {
                        ref
                            .read(currentCompanyProvider.notifier)
                            .switchTo(company.id);
                      }
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
