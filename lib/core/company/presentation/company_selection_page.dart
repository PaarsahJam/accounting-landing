import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../company_controller.dart';

class CompanySelectionPage extends ConsumerWidget {
  const CompanySelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesAsync = ref.watch(companyListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Company'),
      ),
      body: companiesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (companies) {
          if (companies.isEmpty) {
            return const Center(child: Text('No companies available'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: companies.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, index) {
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
                          : Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
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
