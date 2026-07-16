// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TagsController)
final tagsControllerProvider = TagsControllerProvider._();

final class TagsControllerProvider
    extends $AsyncNotifierProvider<TagsController, List<Tag>> {
  TagsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagsControllerHash();

  @$internal
  @override
  TagsController create() => TagsController();
}

String _$tagsControllerHash() => r'd47ef359d366f35eb60e2ec59664fe319850deb3';

abstract class _$TagsController extends $AsyncNotifier<List<Tag>> {
  FutureOr<List<Tag>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Tag>>, List<Tag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Tag>>, List<Tag>>,
              AsyncValue<List<Tag>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(EntityTagsController)
final entityTagsControllerProvider = EntityTagsControllerFamily._();

final class EntityTagsControllerProvider
    extends $AsyncNotifierProvider<EntityTagsController, List<Tag>> {
  EntityTagsControllerProvider._({
    required EntityTagsControllerFamily super.from,
    required EntityTagsParams super.argument,
  }) : super(
         retry: null,
         name: r'entityTagsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$entityTagsControllerHash();

  @override
  String toString() {
    return r'entityTagsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EntityTagsController create() => EntityTagsController();

  @override
  bool operator ==(Object other) {
    return other is EntityTagsControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$entityTagsControllerHash() =>
    r'1364c6335ecd8e34ef54e2610b72e54e9992b19e';

final class EntityTagsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          EntityTagsController,
          AsyncValue<List<Tag>>,
          List<Tag>,
          FutureOr<List<Tag>>,
          EntityTagsParams
        > {
  EntityTagsControllerFamily._()
    : super(
        retry: null,
        name: r'entityTagsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EntityTagsControllerProvider call(EntityTagsParams params) =>
      EntityTagsControllerProvider._(argument: params, from: this);

  @override
  String toString() => r'entityTagsControllerProvider';
}

abstract class _$EntityTagsController extends $AsyncNotifier<List<Tag>> {
  late final _$args = ref.$arg as EntityTagsParams;
  EntityTagsParams get params => _$args;

  FutureOr<List<Tag>> build(EntityTagsParams params);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Tag>>, List<Tag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Tag>>, List<Tag>>,
              AsyncValue<List<Tag>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
