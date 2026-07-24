import '../../../core/api/api_client.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/customer.dart';
import 'customer_repository.dart';
import 'dto/customer_dto.dart';
import 'dto/customer_mapper.dart';

class CustomerApiRepository implements CustomerRepository {
  CustomerApiRepository({required this.apiClient});

  final ApiClient apiClient;


  @override
  Future<AppResult<List<Customer>>> fetchCustomers() async {
    try {
      final response = await apiClient.get<List<dynamic>>('/customers');
      final list = response.data ?? <dynamic>[];
      final customers = list
          .map((e) => CustomerDto.fromJson(e as Map<String, dynamic>))
          .map((dto) => dto.toDomain())
          .toList();
      return AppResult.success(customers);
    } on AppFailure catch (f) {
      return AppResult.failure(f);
    } catch (e) {
      return AppResult.failure(
          UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<AppResult<Customer>> createCustomer(Customer customer) async {
    try {
      final body = customer.toDto().toJson();
      final response =
          await apiClient.post<Map<String, dynamic>>('/customers', data: body);
      final dto = CustomerDto.fromJson(response.data!);
      return AppResult.success(dto.toDomain());
    } on AppFailure catch (f) {
      return AppResult.failure(f);
    } catch (e) {
      return AppResult.failure(
          UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<AppResult<Customer>> updateCustomer(Customer customer) async {
    try {
      final body = customer.toDto().toJson();
      final response = await apiClient.put<Map<String, dynamic>>(
        '/customers/${customer.id}',
        data: body,
      );
      final dto = CustomerDto.fromJson(response.data!);
      return AppResult.success(dto.toDomain());
    } on AppFailure catch (f) {
      return AppResult.failure(f);
    } catch (e) {
      return AppResult.failure(
          UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteCustomer(String id) async {
    try {
      await apiClient.delete('/customers/$id');
      return AppResult.success(null);
    } on AppFailure catch (f) {
      return AppResult.failure(f);
    } catch (e) {
      return AppResult.failure(
          UnknownFailure(message: e.toString()));
    }
  }
}
