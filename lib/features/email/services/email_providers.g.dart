// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(emailProvider)
final emailProviderProvider = EmailProviderProvider._();

final class EmailProviderProvider
    extends $FunctionalProvider<EmailProvider, EmailProvider, EmailProvider>
    with $Provider<EmailProvider> {
  EmailProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailProviderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailProviderHash();

  @$internal
  @override
  $ProviderElement<EmailProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmailProvider create(Ref ref) {
    return emailProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailProvider>(value),
    );
  }
}

String _$emailProviderHash() => r'0963bf7be401039c84013a3d56441e55a2151c48';

@ProviderFor(emailRepository)
final emailRepositoryProvider = EmailRepositoryProvider._();

final class EmailRepositoryProvider
    extends
        $FunctionalProvider<EmailRepository, EmailRepository, EmailRepository>
    with $Provider<EmailRepository> {
  EmailRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailRepositoryHash();

  @$internal
  @override
  $ProviderElement<EmailRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmailRepository create(Ref ref) {
    return emailRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailRepository>(value),
    );
  }
}

String _$emailRepositoryHash() => r'd2d788cc3b851cc847bdf6013dc20caee0de36ca';

@ProviderFor(emailTemplateService)
final emailTemplateServiceProvider = EmailTemplateServiceProvider._();

final class EmailTemplateServiceProvider
    extends
        $FunctionalProvider<
          EmailTemplateService,
          EmailTemplateService,
          EmailTemplateService
        >
    with $Provider<EmailTemplateService> {
  EmailTemplateServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailTemplateServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailTemplateServiceHash();

  @$internal
  @override
  $ProviderElement<EmailTemplateService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EmailTemplateService create(Ref ref) {
    return emailTemplateService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailTemplateService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailTemplateService>(value),
    );
  }
}

String _$emailTemplateServiceHash() =>
    r'd16e9ff1ff3f4ce704b21ccc4cd52dc2df0112c4';

@ProviderFor(emailService)
final emailServiceProvider = EmailServiceProvider._();

final class EmailServiceProvider
    extends $FunctionalProvider<EmailService, EmailService, EmailService>
    with $Provider<EmailService> {
  EmailServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailServiceHash();

  @$internal
  @override
  $ProviderElement<EmailService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmailService create(Ref ref) {
    return emailService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailService>(value),
    );
  }
}

String _$emailServiceHash() => r'361dd229c0df0c04f9355ff6136b4b9d49742bc1';
