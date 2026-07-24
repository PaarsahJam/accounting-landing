import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../company_controller.dart';
import 'company_selection_page.dart';

class CompanyScopeGuard extends ConsumerWidget {
  final Widget child;

  const CompanyScopeGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyAsync = ref.watch(currentCompanyProvider);

    return companyAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $e'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () =>
                    ref.invalidate(currentCompanyProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (company) {
        if (company == null) {
          return const CompanySelectionPage();
        }
        return child;
      },
    );
  }
}
