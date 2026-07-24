// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmailController)
final emailControllerProvider = EmailControllerProvider._();

final class EmailControllerProvider
    extends $AsyncNotifierProvider<EmailController, List<EmailMessage>> {
  EmailControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailControllerHash();

  @$internal
  @override
  EmailController create() => EmailController();
}

String _$emailControllerHash() => r'5f7d237cc422a646f77cab9665531bd9c156b355';

abstract class _$EmailController extends $AsyncNotifier<List<EmailMessage>> {
  FutureOr<List<EmailMessage>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<EmailMessage>>, List<EmailMessage>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<EmailMessage>>, List<EmailMessage>>,
              AsyncValue<List<EmailMessage>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
