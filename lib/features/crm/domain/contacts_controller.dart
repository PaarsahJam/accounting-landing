import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/crm_repository.dart';
import '../data/crm_repository_provider.dart';
import 'contact.dart';

part 'contacts_controller.g.dart';

@riverpod
class ContactsController extends _$ContactsController {
  late final CrmRepository _repository;
  late String _customerId;

  @override
  FutureOr<List<Contact>> build(String customerId) async {
    _customerId = customerId;
    _repository = ref.watch(crmRepositoryProvider);
    final result = await _repository.fetchContacts(customerId);
    if (result.isSuccess) {
      return result.data ?? const <Contact>[];
    }
    AppLogger.warning('Failed to load contacts', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createContact(Contact contact) async {
    try {
      final result = await _repository.createContact(contact);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <Contact>[];
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, _) {
      AppLogger.warning('Failed to create contact', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> updateContact(Contact contact) async {
    try {
      final result = await _repository.updateContact(contact);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <Contact>[];
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, _) {
      AppLogger.warning('Failed to update contact', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      final result = await _repository.deleteContact(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <Contact>[];
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, _) {
      AppLogger.warning('Failed to delete contact', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> refresh() async {
    try {
      final result = await _repository.fetchContacts(_customerId);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <Contact>[]);
    } catch (e, _) {
      AppLogger.warning('Failed to refresh contacts', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }
}
