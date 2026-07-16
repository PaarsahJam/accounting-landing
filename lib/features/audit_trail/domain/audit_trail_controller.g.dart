// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_trail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Global audit trail — loads all entries, supports filtering.

@ProviderFor(AuditTrailController)
final auditTrailControllerProvider = AuditTrailControllerProvider._();

/// Global audit trail — loads all entries, supports filtering.
final class AuditTrailControllerProvider
    extends $AsyncNotifierProvider<AuditTrailController, List<AuditEntry>> {
  /// Global audit trail — loads all entries, supports filtering.
  AuditTrailControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditTrailControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditTrailControllerHash();

  @$internal
  @override
  AuditTrailController create() => AuditTrailController();
}

String _$auditTrailControllerHash() =>
    r'7ecaf5fe1e4089c9563eca45ff16bf2e18ee0837';

/// Global audit trail — loads all entries, supports filtering.

abstract class _$AuditTrailController extends $AsyncNotifier<List<AuditEntry>> {
  FutureOr<List<AuditEntry>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<AuditEntry>>, List<AuditEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AuditEntry>>, List<AuditEntry>>,
              AsyncValue<List<AuditEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(EntityAuditTrailController)
final entityAuditTrailControllerProvider = EntityAuditTrailControllerFamily._();

final class EntityAuditTrailControllerProvider
    extends
        $AsyncNotifierProvider<EntityAuditTrailController, List<AuditEntry>> {
  EntityAuditTrailControllerProvider._({
    required EntityAuditTrailControllerFamily super.from,
    required (AuditEntityType, String) super.argument,
  }) : super(
         retry: null,
         name: r'entityAuditTrailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$entityAuditTrailControllerHash();

  @override
  String toString() {
    return r'entityAuditTrailControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  EntityAuditTrailController create() => EntityAuditTrailController();

  @override
  bool operator ==(Object other) {
    return other is EntityAuditTrailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$entityAuditTrailControllerHash() =>
    r'3ef8284d82cd99aec59e134afb430b324568ba63';

final class EntityAuditTrailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          EntityAuditTrailController,
          AsyncValue<List<AuditEntry>>,
          List<AuditEntry>,
          FutureOr<List<AuditEntry>>,
          (AuditEntityType, String)
        > {
  EntityAuditTrailControllerFamily._()
    : super(
        retry: null,
        name: r'entityAuditTrailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EntityAuditTrailControllerProvider call(
    AuditEntityType entityType,
    String entityId,
  ) => EntityAuditTrailControllerProvider._(
    argument: (entityType, entityId),
    from: this,
  );

  @override
  String toString() => r'entityAuditTrailControllerProvider';
}

abstract class _$EntityAuditTrailController
    extends $AsyncNotifier<List<AuditEntry>> {
  late final _$args = ref.$arg as (AuditEntityType, String);
  AuditEntityType get entityType => _$args.$1;
  String get entityId => _$args.$2;

  FutureOr<List<AuditEntry>> build(AuditEntityType entityType, String entityId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<AuditEntry>>, List<AuditEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AuditEntry>>, List<AuditEntry>>,
              AsyncValue<List<AuditEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
