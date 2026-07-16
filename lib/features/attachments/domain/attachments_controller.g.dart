// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AttachmentsController)
final attachmentsControllerProvider = AttachmentsControllerFamily._();

final class AttachmentsControllerProvider
    extends $AsyncNotifierProvider<AttachmentsController, List<Attachment>> {
  AttachmentsControllerProvider._({
    required AttachmentsControllerFamily super.from,
    required AttachmentsParams super.argument,
  }) : super(
         retry: null,
         name: r'attachmentsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$attachmentsControllerHash();

  @override
  String toString() {
    return r'attachmentsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AttachmentsController create() => AttachmentsController();

  @override
  bool operator ==(Object other) {
    return other is AttachmentsControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$attachmentsControllerHash() =>
    r'e32e31447380e393b35e262c513181a17f14b782';

final class AttachmentsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          AttachmentsController,
          AsyncValue<List<Attachment>>,
          List<Attachment>,
          FutureOr<List<Attachment>>,
          AttachmentsParams
        > {
  AttachmentsControllerFamily._()
    : super(
        retry: null,
        name: r'attachmentsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AttachmentsControllerProvider call(AttachmentsParams params) =>
      AttachmentsControllerProvider._(argument: params, from: this);

  @override
  String toString() => r'attachmentsControllerProvider';
}

abstract class _$AttachmentsController
    extends $AsyncNotifier<List<Attachment>> {
  late final _$args = ref.$arg as AttachmentsParams;
  AttachmentsParams get params => _$args;

  FutureOr<List<Attachment>> build(AttachmentsParams params);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Attachment>>, List<Attachment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Attachment>>, List<Attachment>>,
              AsyncValue<List<Attachment>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
