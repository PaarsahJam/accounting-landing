import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'company_repository.dart';

part 'company_provider.g.dart';

@riverpod
CompanyRepository companyRepository(Ref ref) => MockCompanyRepository();
