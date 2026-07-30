import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../company.dart';
import '../company_controller.dart';

class CompanyFormPage extends ConsumerStatefulWidget {
  const CompanyFormPage({super.key});

  @override
  ConsumerState<CompanyFormPage> createState() => _CompanyFormPageState();
}

class _CompanyFormPageState extends ConsumerState<CompanyFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _legalNameCtrl = TextEditingController();
  final _taxIdCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _legalNameCtrl.dispose();
    _taxIdCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final id = 'comp-${DateTime.now().millisecondsSinceEpoch}';
      final company = Company(
        id: id,
        name: _nameCtrl.text.trim(),
        legalName: _legalNameCtrl.text.trim().isEmpty
            ? null
            : _legalNameCtrl.text.trim(),
        taxId: _taxIdCtrl.text.trim().isEmpty
            ? null
            : _taxIdCtrl.text.trim(),
        currency: 'IRR',
        fiscalYearStartMonth: '3',
        isActive: true,
      );
      await ref.read(currentCompanyProvider.notifier).createCompany(company);
      if (!mounted) return;
      context.go('/dashboard');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createCompany)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.customerName,
                    ),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    enabled: !_isLoading,
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? l10n.requiredField
                            : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _legalNameCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.companyLegalName,
                    ),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _taxIdCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.companyTaxId,
                    ),
                    textInputAction: TextInputAction.done,
                    enabled: !_isLoading,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _isLoading ? null : _submit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(l10n.createCompany),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
