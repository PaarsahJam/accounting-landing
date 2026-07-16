// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachments_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(attachmentsRepository)
final attachmentsRepositoryProvider = AttachmentsRepositoryProvider._();

final class AttachmentsRepositoryProvider
    extends
        $FunctionalProvider<
          AttachmentsRepository,
          AttachmentsRepository,
          AttachmentsRepository
        >
    with $Provider<AttachmentsRepository> {
  AttachmentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attachmentsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attachmentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AttachmentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AttachmentsRepository create(Ref ref) {
    return attachmentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AttachmentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AttachmentsRepository>(value),
    );
  }
}

String _$attachmentsRepositoryHash() =>
    r'93d26d8742413a85077afee28034c30a48f110f0';
