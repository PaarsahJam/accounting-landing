// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interactions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InteractionsController)
final interactionsControllerProvider = InteractionsControllerFamily._();

final class InteractionsControllerProvider
    extends $AsyncNotifierProvider<InteractionsController, List<Interaction>> {
  InteractionsControllerProvider._({
    required InteractionsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'interactionsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$interactionsControllerHash();

  @override
  String toString() {
    return r'interactionsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  InteractionsController create() => InteractionsController();

  @override
  bool operator ==(Object other) {
    return other is InteractionsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$interactionsControllerHash() =>
    r'2ff264572f69d0c633faeacaa3cd4fd00f03cb70';

final class InteractionsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          InteractionsController,
          AsyncValue<List<Interaction>>,
          List<Interaction>,
          FutureOr<List<Interaction>>,
          String
        > {
  InteractionsControllerFamily._()
    : super(
        retry: null,
        name: r'interactionsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InteractionsControllerProvider call(String contactId) =>
      InteractionsControllerProvider._(argument: contactId, from: this);

  @override
  String toString() => r'interactionsControllerProvider';
}

abstract class _$InteractionsController
    extends $AsyncNotifier<List<Interaction>> {
  late final _$args = ref.$arg as String;
  String get contactId => _$args;

  FutureOr<List<Interaction>> build(String contactId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Interaction>>, List<Interaction>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Interaction>>, List<Interaction>>,
              AsyncValue<List<Interaction>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
