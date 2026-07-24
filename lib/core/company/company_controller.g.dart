// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentCompany)
final currentCompanyProvider = CurrentCompanyProvider._();

final class CurrentCompanyProvider
    extends $AsyncNotifierProvider<CurrentCompany, Company?> {
  CurrentCompanyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentCompanyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentCompanyHash();

  @$internal
  @override
  CurrentCompany create() => CurrentCompany();
}

String _$currentCompanyHash() => r'4d52a15422bec0d7f7a1c7a409b4da9a503d4e32';

abstract class _$CurrentCompany extends $AsyncNotifier<Company?> {
  FutureOr<Company?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Company?>, Company?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Company?>, Company?>,
              AsyncValue<Company?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(CompanyList)
final companyListProvider = CompanyListProvider._();

final class CompanyListProvider
    extends $AsyncNotifierProvider<CompanyList, List<Company>> {
  CompanyListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'companyListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$companyListHash();

  @$internal
  @override
  CompanyList create() => CompanyList();
}

String _$companyListHash() => r'0d9b7daba66ec736dc26ae23a9fa10ddf4d6494f';

abstract class _$CompanyList extends $AsyncNotifier<List<Company>> {
  FutureOr<List<Company>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Company>>, List<Company>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Company>>, List<Company>>,
              AsyncValue<List<Company>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
