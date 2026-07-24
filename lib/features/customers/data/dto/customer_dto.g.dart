// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDto _$CustomerDtoFromJson(Map<String, dynamic> json) => CustomerDto(
  id: json['id'] as String,
  name: json['name'] as String,
  company: json['company'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  outstandingBalance: (json['outstanding_balance'] as num).toDouble(),
  status: json['status'] as String,
  notes: json['notes'] as String,
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$CustomerDtoToJson(CustomerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company': instance.company,
      'email': instance.email,
      'phone': instance.phone,
      'outstanding_balance': instance.outstandingBalance,
      'status': instance.status,
      'notes': instance.notes,
      'version': instance.version,
    };
