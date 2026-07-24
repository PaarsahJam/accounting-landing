// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ContactsController)
final contactsControllerProvider = ContactsControllerFamily._();

final class ContactsControllerProvider
    extends $AsyncNotifierProvider<ContactsController, List<Contact>> {
  ContactsControllerProvider._({
    required ContactsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'contactsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contactsControllerHash();

  @override
  String toString() {
    return r'contactsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ContactsController create() => ContactsController();

  @override
  bool operator ==(Object other) {
    return other is ContactsControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contactsControllerHash() =>
    r'aae1745131ca331cec438c7593a450d249e586e6';

final class ContactsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ContactsController,
          AsyncValue<List<Contact>>,
          List<Contact>,
          FutureOr<List<Contact>>,
          String
        > {
  ContactsControllerFamily._()
    : super(
        retry: null,
        name: r'contactsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ContactsControllerProvider call(String customerId) =>
      ContactsControllerProvider._(argument: customerId, from: this);

  @override
  String toString() => r'contactsControllerProvider';
}

abstract class _$ContactsController extends $AsyncNotifier<List<Contact>> {
  late final _$args = ref.$arg as String;
  String get customerId => _$args;

  FutureOr<List<Contact>> build(String customerId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Contact>>, List<Contact>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Contact>>, List<Contact>>,
              AsyncValue<List<Contact>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
