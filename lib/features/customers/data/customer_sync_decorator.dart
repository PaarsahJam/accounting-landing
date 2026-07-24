import 'dart:convert';

import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../../../core/sync/sync_engine.dart';
import '../../../core/sync/sync_operation.dart';
import '../../../core/sync/sync_queue.dart';
import '../domain/customer.dart';
import 'customer_repository.dart';

class CustomerSyncDecorator implements CustomerRepository {
  CustomerSyncDecorator({
    required CustomerRepository inner,
    required SyncQueue queue,
    required SyncEngine engine,
  })  : _inner = inner,
        _queue = queue,
        _engine = engine;

  final CustomerRepository _inner;
  final SyncQueue _queue;
  final SyncEngine _engine;

  @override
  Future<AppResult<List<Customer>>> fetchCustomers() =>
      _inner.fetchCustomers();

  @override
  Future<AppResult<Customer>> createCustomer(Customer customer) async {
    final result = await _inner.createCustomer(customer);
    if (result.isSuccess) {
      await _enqueue(OperationType.create, customer);
      _triggerSync();
    }
    return result;
  }

  @override
  Future<AppResult<Customer>> updateCustomer(Customer customer) async {
    final result = await _inner.updateCustomer(customer);
    if (result.isSuccess) {
      await _enqueue(OperationType.update, customer);
      _triggerSync();
    }
    return result;
  }

  @override
  Future<AppResult<void>> deleteCustomer(String id) async {
    final result = await _inner.deleteCustomer(id);
    if (result.isSuccess) {
      await _queue.enqueue(SyncOperation(
        id: 'sync-del-$id-${DateTime.now().millisecondsSinceEpoch}',
        operationType: OperationType.delete,
        entityType: 'customer',
        entityId: id,
        data: {'id': id},
        createdAt: DateTime.now(),
      ));
      _triggerSync();
    }
    return result;
  }

  Future<void> _enqueue(OperationType type, Customer customer) async {
    await _queue.enqueue(SyncOperation(
      id: 'sync-${type.name}-${customer.id}-${DateTime.now().millisecondsSinceEpoch}',
      operationType: type,
      entityType: 'customer',
      entityId: customer.id,
      data: jsonDecode(jsonEncode(customer)) as Map<String, dynamic>,
      localVersion: customer.version,
      createdAt: DateTime.now(),
    ));
  }

  void _triggerSync() {
    _engine.processAll().then((result) {
      if (result.failed > 0) {
        AppLogger.warning(
            'Sync completed with ${result.failed} failures');
      }
    });
  }
}
