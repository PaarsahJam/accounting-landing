import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../errors/app_failure.dart';
import '../logging/app_logger.dart';
import '../../features/user_roles/domain/authorization.dart';
import '../../features/user_roles/domain/permission.dart';
import 'company.dart';
import 'company_provider.dart';
import 'company_repository.dart';

part 'company_controller.g.dart';

@riverpod
class CurrentCompany extends _$CurrentCompany {
  late final CompanyRepository _repository;

  @override
  FutureOr<Company?> build() async {
    _repository = ref.watch(companyRepositoryProvider);
    final savedIdResult = await _repository.getActiveCompanyId();
    if (savedIdResult.isSuccess && savedIdResult.data != null) {
      final companyResult =
          await _repository.fetchCompany(savedIdResult.data!);
      if (companyResult.isSuccess) return companyResult.data;
    }
    final companiesResult = await _repository.fetchCompanies();
    if (companiesResult.isSuccess && companiesResult.data!.isNotEmpty) {
      return companiesResult.data!.first;
    }
    return null;
  }

  Future<void> switchTo(String companyId) async {
    // Enforce permission before switching the active company. Company
    // switching is an administrative action gated on manageSettings.
    final denied = ref.checkPermission(
      Permission.manageSettings,
      action: 'switch companies',
    );
    if (denied != null) {
      state = AsyncValue.error(denied, StackTrace.current);
      return;
    }
    try {
      final result = await _repository.fetchCompany(companyId);
      if (!result.isSuccess) {
        throw result.error ??
            const UnknownFailure(message: 'Company not found');
      }
      final saveResult = await _repository.saveActiveCompanyId(companyId);
      if (!saveResult.isSuccess) {
        throw saveResult.error ??
            const UnknownFailure(message: 'Failed to save selection');
      }
      state = AsyncValue.data(result.data);
    } catch (e, st) {
      AppLogger.warning('Failed to switch company', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final savedIdResult = await _repository.getActiveCompanyId();
      if (savedIdResult.isSuccess && savedIdResult.data != null) {
        final companyResult =
            await _repository.fetchCompany(savedIdResult.data!);
        if (companyResult.isSuccess) {
          state = AsyncValue.data(companyResult.data);
          return;
        }
      }
      final companiesResult = await _repository.fetchCompanies();
      if (companiesResult.isSuccess && companiesResult.data!.isNotEmpty) {
        state = AsyncValue.data(companiesResult.data!.first);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, st) {
      AppLogger.warning('Failed to refresh current company', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}

@riverpod
class CompanyList extends _$CompanyList {
  late final CompanyRepository _repository;

  @override
  FutureOr<List<Company>> build() async {
    _repository = ref.watch(companyRepositoryProvider);
    final result = await _repository.fetchCompanies();
    if (result.isSuccess) {
      return result.data ?? const <Company>[];
    }
    AppLogger.warning('Failed to load companies', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }
}
