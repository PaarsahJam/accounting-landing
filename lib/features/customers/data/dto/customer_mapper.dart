import '../../domain/customer.dart';
import 'customer_dto.dart';

extension CustomerDtoMapping on CustomerDto {
  Customer toDomain() => Customer(
        id: id,
        name: name,
        company: company,
        email: email,
        phone: phone,
        outstandingBalance: outstandingBalance,
        status: status,
        notes: notes,
        version: version,
      );
}

extension CustomerMapping on Customer {
  CustomerDto toDto() => CustomerDto(
        id: id,
        name: name,
        company: company,
        email: email,
        phone: phone,
        outstandingBalance: outstandingBalance,
        status: status,
        notes: notes,
        version: version,
      );
}
