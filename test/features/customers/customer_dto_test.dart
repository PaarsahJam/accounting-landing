import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/features/customers/data/dto/customer_dto.dart';
import 'package:accounting_app/features/customers/data/dto/customer_mapper.dart';
import 'package:accounting_app/features/customers/domain/customer.dart';

void main() {
  group('CustomerDto serialization', () {
    final sampleJson = {
      'id': 'CUST-1001',
      'name': 'Ava Rahimi',
      'company': 'Northstar Co.',
      'email': 'ava@northstar.co',
      'phone': '+98 912 000 0001',
      'outstanding_balance': 2450000.0,
      'status': 'Active',
      'notes': 'Preferred client',
    };

    test('fromJson parses correctly', () {
      final dto = CustomerDto.fromJson(sampleJson);
      expect(dto.id, 'CUST-1001');
      expect(dto.name, 'Ava Rahimi');
      expect(dto.outstandingBalance, 2450000.0);
      expect(dto.status, 'Active');
    });

    test('toJson produces expected map', () {
      final dto = CustomerDto.fromJson(sampleJson);
      final json = dto.toJson();
      expect(json['outstanding_balance'], 2450000.0);
      expect(json['name'], 'Ava Rahimi');
    });

    test('round-trip preserves all fields', () {
      final dto = CustomerDto.fromJson(sampleJson);
      final json = dto.toJson();
      final restored = CustomerDto.fromJson(json);
      expect(restored.id, dto.id);
      expect(restored.name, dto.name);
      expect(restored.company, dto.company);
      expect(restored.email, dto.email);
      expect(restored.phone, dto.phone);
      expect(restored.outstandingBalance, dto.outstandingBalance);
      expect(restored.status, dto.status);
      expect(restored.notes, dto.notes);
    });

    test('fromJson handles missing outstanding_balance key', () {
      final json = Map<String, dynamic>.from(sampleJson);
      json.remove('outstanding_balance');
      expect(() => CustomerDto.fromJson(json), throwsA(isA<Object>()));
    });
  });

  group('CustomerDto <-> Domain mapping', () {
    test('toDomain produces correct Customer', () {
      final dto = CustomerDto.fromJson({
        'id': 'CUST-2001',
        'name': 'Sina Nouri',
        'company': 'Bright Labs',
        'email': 'sina@brightlabs.ir',
        'phone': '+98 913 000 0002',
        'outstanding_balance': 860000.0,
        'status': 'Pending',
        'notes': 'Settlement expected',
      });
      final customer = dto.toDomain();
      expect(customer.id, 'CUST-2001');
      expect(customer.name, 'Sina Nouri');
      expect(customer.company, 'Bright Labs');
      expect(customer.outstandingBalance, 860000.0);
    });

    test('domain toDto produces matching DTO', () {
      final customer = const Customer(
        id: 'CUST-3001',
        name: 'Test Co',
        company: 'Test Ltd',
        email: 't@test.co',
        phone: '+1 555 0001',
        outstandingBalance: 1000,
        status: 'Active',
        notes: 'Note',
      );
      final dto = customer.toDto();
      expect(dto.id, 'CUST-3001');
      expect(dto.name, 'Test Co');
      expect(dto.outstandingBalance, 1000);
      expect(dto.company, 'Test Ltd');
    });

    test('domain-toDto-toDomain round-trip preseres data', () {
      final original = const Customer(
        id: 'CUST-4001',
        name: 'Round Trip',
        company: 'RT Inc',
        email: 'rt@rt.com',
        phone: '+1 555 9999',
        outstandingBalance: 50000,
        status: 'Active',
        notes: 'Round-trip test',
      );
      final dto = original.toDto();
      final restored = dto.toDomain();
      expect(restored.id, original.id);
      expect(restored.name, original.name);
      expect(restored.company, original.company);
      expect(restored.email, original.email);
      expect(restored.phone, original.phone);
      expect(restored.outstandingBalance, original.outstandingBalance);
      expect(restored.status, original.status);
      expect(restored.notes, original.notes);
    });
  });
}
