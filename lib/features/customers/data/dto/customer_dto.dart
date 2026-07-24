import 'package:json_annotation/json_annotation.dart';

part 'customer_dto.g.dart';

@JsonSerializable()
class CustomerDto {
  const CustomerDto({
    required this.id,
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
    @JsonKey(name: 'outstanding_balance') required this.outstandingBalance,
    required this.status,
    required this.notes,
  });

  factory CustomerDto.fromJson(Map<String, dynamic> json) =>
      _$CustomerDtoFromJson(json);

  final String id;
  final String name;
  final String company;
  final String email;
  final String phone;

  @JsonKey(name: 'outstanding_balance')
  final double outstandingBalance;

  final String status;
  final String notes;

  Map<String, dynamic> toJson() => _$CustomerDtoToJson(this);
}
