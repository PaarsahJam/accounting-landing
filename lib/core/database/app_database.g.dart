// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CustomersTableTable extends CustomersTable
    with TableInfo<$CustomersTableTable, CustomersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyMeta = const VerificationMeta(
    'company',
  );
  @override
  late final GeneratedColumn<String> company = GeneratedColumn<String>(
    'company',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outstandingBalanceMeta =
      const VerificationMeta('outstandingBalance');
  @override
  late final GeneratedColumn<double> outstandingBalance =
      GeneratedColumn<double>(
        'outstanding_balance',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    name,
    company,
    email,
    phone,
    outstandingBalance,
    status,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('company')) {
      context.handle(
        _companyMeta,
        company.isAcceptableOrUnknown(data['company']!, _companyMeta),
      );
    } else if (isInserting) {
      context.missing(_companyMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('outstanding_balance')) {
      context.handle(
        _outstandingBalanceMeta,
        outstandingBalance.isAcceptableOrUnknown(
          data['outstanding_balance']!,
          _outstandingBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_outstandingBalanceMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      company: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      outstandingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}outstanding_balance'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $CustomersTableTable createAlias(String alias) {
    return $CustomersTableTable(attachedDatabase, alias);
  }
}

class CustomersTableData extends DataClass
    implements Insertable<CustomersTableData> {
  final String id;
  final String companyId;
  final String name;
  final String company;
  final String email;
  final String phone;
  final double outstandingBalance;
  final String status;
  final String notes;
  const CustomersTableData({
    required this.id,
    required this.companyId,
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
    required this.outstandingBalance,
    required this.status,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['name'] = Variable<String>(name);
    map['company'] = Variable<String>(company);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['outstanding_balance'] = Variable<double>(outstandingBalance);
    map['status'] = Variable<String>(status);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  CustomersTableCompanion toCompanion(bool nullToAbsent) {
    return CustomersTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      name: Value(name),
      company: Value(company),
      email: Value(email),
      phone: Value(phone),
      outstandingBalance: Value(outstandingBalance),
      status: Value(status),
      notes: Value(notes),
    );
  }

  factory CustomersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomersTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      name: serializer.fromJson<String>(json['name']),
      company: serializer.fromJson<String>(json['company']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      outstandingBalance: serializer.fromJson<double>(
        json['outstandingBalance'],
      ),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'name': serializer.toJson<String>(name),
      'company': serializer.toJson<String>(company),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'outstandingBalance': serializer.toJson<double>(outstandingBalance),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String>(notes),
    };
  }

  CustomersTableData copyWith({
    String? id,
    String? companyId,
    String? name,
    String? company,
    String? email,
    String? phone,
    double? outstandingBalance,
    String? status,
    String? notes,
  }) => CustomersTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    name: name ?? this.name,
    company: company ?? this.company,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    outstandingBalance: outstandingBalance ?? this.outstandingBalance,
    status: status ?? this.status,
    notes: notes ?? this.notes,
  );
  CustomersTableData copyWithCompanion(CustomersTableCompanion data) {
    return CustomersTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      name: data.name.present ? data.name.value : this.name,
      company: data.company.present ? data.company.value : this.company,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      outstandingBalance: data.outstandingBalance.present
          ? data.outstandingBalance.value
          : this.outstandingBalance,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomersTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('name: $name, ')
          ..write('company: $company, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('outstandingBalance: $outstandingBalance, ')
          ..write('status: $status, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    name,
    company,
    email,
    phone,
    outstandingBalance,
    status,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomersTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.name == this.name &&
          other.company == this.company &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.outstandingBalance == this.outstandingBalance &&
          other.status == this.status &&
          other.notes == this.notes);
}

class CustomersTableCompanion extends UpdateCompanion<CustomersTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> name;
  final Value<String> company;
  final Value<String> email;
  final Value<String> phone;
  final Value<double> outstandingBalance;
  final Value<String> status;
  final Value<String> notes;
  final Value<int> rowid;
  const CustomersTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.name = const Value.absent(),
    this.company = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.outstandingBalance = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersTableCompanion.insert({
    required String id,
    required String companyId,
    required String name,
    required String company,
    required String email,
    required String phone,
    required double outstandingBalance,
    required String status,
    required String notes,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       name = Value(name),
       company = Value(company),
       email = Value(email),
       phone = Value(phone),
       outstandingBalance = Value(outstandingBalance),
       status = Value(status),
       notes = Value(notes);
  static Insertable<CustomersTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? name,
    Expression<String>? company,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<double>? outstandingBalance,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (name != null) 'name': name,
      if (company != null) 'company': company,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (outstandingBalance != null) 'outstanding_balance': outstandingBalance,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? name,
    Value<String>? company,
    Value<String>? email,
    Value<String>? phone,
    Value<double>? outstandingBalance,
    Value<String>? status,
    Value<String>? notes,
    Value<int>? rowid,
  }) {
    return CustomersTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      outstandingBalance: outstandingBalance ?? this.outstandingBalance,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (company.present) {
      map['company'] = Variable<String>(company.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (outstandingBalance.present) {
      map['outstanding_balance'] = Variable<double>(outstandingBalance.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('name: $name, ')
          ..write('company: $company, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('outstandingBalance: $outstandingBalance, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VendorsTableTable extends VendorsTable
    with TableInfo<$VendorsTableTable, VendorsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VendorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxIdentifierMeta = const VerificationMeta(
    'taxIdentifier',
  );
  @override
  late final GeneratedColumn<String> taxIdentifier = GeneratedColumn<String>(
    'tax_identifier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    companyName,
    contactName,
    email,
    phone,
    address,
    taxIdentifier,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vendors_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<VendorsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companyNameMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('tax_identifier')) {
      context.handle(
        _taxIdentifierMeta,
        taxIdentifier.isAcceptableOrUnknown(
          data['tax_identifier']!,
          _taxIdentifierMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taxIdentifierMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VendorsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VendorsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      taxIdentifier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_identifier'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VendorsTableTable createAlias(String alias) {
    return $VendorsTableTable(attachedDatabase, alias);
  }
}

class VendorsTableData extends DataClass
    implements Insertable<VendorsTableData> {
  final String id;
  final String companyId;
  final String companyName;
  final String contactName;
  final String email;
  final String phone;
  final String address;
  final String taxIdentifier;
  final String notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const VendorsTableData({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.contactName,
    required this.email,
    required this.phone,
    required this.address,
    required this.taxIdentifier,
    required this.notes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['company_name'] = Variable<String>(companyName);
    map['contact_name'] = Variable<String>(contactName);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['address'] = Variable<String>(address);
    map['tax_identifier'] = Variable<String>(taxIdentifier);
    map['notes'] = Variable<String>(notes);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VendorsTableCompanion toCompanion(bool nullToAbsent) {
    return VendorsTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      companyName: Value(companyName),
      contactName: Value(contactName),
      email: Value(email),
      phone: Value(phone),
      address: Value(address),
      taxIdentifier: Value(taxIdentifier),
      notes: Value(notes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VendorsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VendorsTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      companyName: serializer.fromJson<String>(json['companyName']),
      contactName: serializer.fromJson<String>(json['contactName']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      address: serializer.fromJson<String>(json['address']),
      taxIdentifier: serializer.fromJson<String>(json['taxIdentifier']),
      notes: serializer.fromJson<String>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'companyName': serializer.toJson<String>(companyName),
      'contactName': serializer.toJson<String>(contactName),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'address': serializer.toJson<String>(address),
      'taxIdentifier': serializer.toJson<String>(taxIdentifier),
      'notes': serializer.toJson<String>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VendorsTableData copyWith({
    String? id,
    String? companyId,
    String? companyName,
    String? contactName,
    String? email,
    String? phone,
    String? address,
    String? taxIdentifier,
    String? notes,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => VendorsTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    companyName: companyName ?? this.companyName,
    contactName: contactName ?? this.contactName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    address: address ?? this.address,
    taxIdentifier: taxIdentifier ?? this.taxIdentifier,
    notes: notes ?? this.notes,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  VendorsTableData copyWithCompanion(VendorsTableCompanion data) {
    return VendorsTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      taxIdentifier: data.taxIdentifier.present
          ? data.taxIdentifier.value
          : this.taxIdentifier,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VendorsTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('companyName: $companyName, ')
          ..write('contactName: $contactName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('taxIdentifier: $taxIdentifier, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    companyName,
    contactName,
    email,
    phone,
    address,
    taxIdentifier,
    notes,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VendorsTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.companyName == this.companyName &&
          other.contactName == this.contactName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.taxIdentifier == this.taxIdentifier &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VendorsTableCompanion extends UpdateCompanion<VendorsTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> companyName;
  final Value<String> contactName;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> address;
  final Value<String> taxIdentifier;
  final Value<String> notes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const VendorsTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.companyName = const Value.absent(),
    this.contactName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.taxIdentifier = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VendorsTableCompanion.insert({
    required String id,
    required String companyId,
    required String companyName,
    required String contactName,
    required String email,
    required String phone,
    required String address,
    required String taxIdentifier,
    required String notes,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       companyName = Value(companyName),
       contactName = Value(contactName),
       email = Value(email),
       phone = Value(phone),
       address = Value(address),
       taxIdentifier = Value(taxIdentifier),
       notes = Value(notes),
       isActive = Value(isActive),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<VendorsTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? companyName,
    Expression<String>? contactName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? taxIdentifier,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (companyName != null) 'company_name': companyName,
      if (contactName != null) 'contact_name': contactName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (taxIdentifier != null) 'tax_identifier': taxIdentifier,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VendorsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? companyName,
    Value<String>? contactName,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? address,
    Value<String>? taxIdentifier,
    Value<String>? notes,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return VendorsTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      taxIdentifier: taxIdentifier ?? this.taxIdentifier,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (taxIdentifier.present) {
      map['tax_identifier'] = Variable<String>(taxIdentifier.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VendorsTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('companyName: $companyName, ')
          ..write('contactName: $contactName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('taxIdentifier: $taxIdentifier, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTableTable extends ProductsTable
    with TableInfo<$ProductsTableTable, ProductsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockOnHandMeta = const VerificationMeta(
    'stockOnHand',
  );
  @override
  late final GeneratedColumn<double> stockOnHand = GeneratedColumn<double>(
    'stock_on_hand',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    sku,
    name,
    description,
    categoryId,
    unitId,
    price,
    stockOnHand,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('stock_on_hand')) {
      context.handle(
        _stockOnHandMeta,
        stockOnHand.isAcceptableOrUnknown(
          data['stock_on_hand']!,
          _stockOnHandMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stockOnHandMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      stockOnHand: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_on_hand'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $ProductsTableTable createAlias(String alias) {
    return $ProductsTableTable(attachedDatabase, alias);
  }
}

class ProductsTableData extends DataClass
    implements Insertable<ProductsTableData> {
  final String id;
  final String companyId;
  final String sku;
  final String name;
  final String description;
  final String categoryId;
  final String unitId;
  final double price;
  final double stockOnHand;
  final bool active;
  const ProductsTableData({
    required this.id,
    required this.companyId,
    required this.sku,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.unitId,
    required this.price,
    required this.stockOnHand,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['sku'] = Variable<String>(sku);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['category_id'] = Variable<String>(categoryId);
    map['unit_id'] = Variable<String>(unitId);
    map['price'] = Variable<double>(price);
    map['stock_on_hand'] = Variable<double>(stockOnHand);
    map['active'] = Variable<bool>(active);
    return map;
  }

  ProductsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductsTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      sku: Value(sku),
      name: Value(name),
      description: Value(description),
      categoryId: Value(categoryId),
      unitId: Value(unitId),
      price: Value(price),
      stockOnHand: Value(stockOnHand),
      active: Value(active),
    );
  }

  factory ProductsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      sku: serializer.fromJson<String>(json['sku']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      unitId: serializer.fromJson<String>(json['unitId']),
      price: serializer.fromJson<double>(json['price']),
      stockOnHand: serializer.fromJson<double>(json['stockOnHand']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'sku': serializer.toJson<String>(sku),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'categoryId': serializer.toJson<String>(categoryId),
      'unitId': serializer.toJson<String>(unitId),
      'price': serializer.toJson<double>(price),
      'stockOnHand': serializer.toJson<double>(stockOnHand),
      'active': serializer.toJson<bool>(active),
    };
  }

  ProductsTableData copyWith({
    String? id,
    String? companyId,
    String? sku,
    String? name,
    String? description,
    String? categoryId,
    String? unitId,
    double? price,
    double? stockOnHand,
    bool? active,
  }) => ProductsTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    sku: sku ?? this.sku,
    name: name ?? this.name,
    description: description ?? this.description,
    categoryId: categoryId ?? this.categoryId,
    unitId: unitId ?? this.unitId,
    price: price ?? this.price,
    stockOnHand: stockOnHand ?? this.stockOnHand,
    active: active ?? this.active,
  );
  ProductsTableData copyWithCompanion(ProductsTableCompanion data) {
    return ProductsTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      sku: data.sku.present ? data.sku.value : this.sku,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      price: data.price.present ? data.price.value : this.price,
      stockOnHand: data.stockOnHand.present
          ? data.stockOnHand.value
          : this.stockOnHand,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitId: $unitId, ')
          ..write('price: $price, ')
          ..write('stockOnHand: $stockOnHand, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    sku,
    name,
    description,
    categoryId,
    unitId,
    price,
    stockOnHand,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.sku == this.sku &&
          other.name == this.name &&
          other.description == this.description &&
          other.categoryId == this.categoryId &&
          other.unitId == this.unitId &&
          other.price == this.price &&
          other.stockOnHand == this.stockOnHand &&
          other.active == this.active);
}

class ProductsTableCompanion extends UpdateCompanion<ProductsTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> sku;
  final Value<String> name;
  final Value<String> description;
  final Value<String> categoryId;
  final Value<String> unitId;
  final Value<double> price;
  final Value<double> stockOnHand;
  final Value<bool> active;
  final Value<int> rowid;
  const ProductsTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.sku = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.price = const Value.absent(),
    this.stockOnHand = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsTableCompanion.insert({
    required String id,
    required String companyId,
    required String sku,
    required String name,
    required String description,
    required String categoryId,
    required String unitId,
    required double price,
    required double stockOnHand,
    required bool active,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       sku = Value(sku),
       name = Value(name),
       description = Value(description),
       categoryId = Value(categoryId),
       unitId = Value(unitId),
       price = Value(price),
       stockOnHand = Value(stockOnHand),
       active = Value(active);
  static Insertable<ProductsTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? sku,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? categoryId,
    Expression<String>? unitId,
    Expression<double>? price,
    Expression<double>? stockOnHand,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (sku != null) 'sku': sku,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (categoryId != null) 'category_id': categoryId,
      if (unitId != null) 'unit_id': unitId,
      if (price != null) 'price': price,
      if (stockOnHand != null) 'stock_on_hand': stockOnHand,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? sku,
    Value<String>? name,
    Value<String>? description,
    Value<String>? categoryId,
    Value<String>? unitId,
    Value<double>? price,
    Value<double>? stockOnHand,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return ProductsTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      unitId: unitId ?? this.unitId,
      price: price ?? this.price,
      stockOnHand: stockOnHand ?? this.stockOnHand,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (stockOnHand.present) {
      map['stock_on_hand'] = Variable<double>(stockOnHand.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitId: $unitId, ')
          ..write('price: $price, ')
          ..write('stockOnHand: $stockOnHand, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesInvoiceTableTable extends SalesInvoiceTable
    with TableInfo<$SalesInvoiceTableTable, SalesInvoiceTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesInvoiceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceDateMeta = const VerificationMeta(
    'invoiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> invoiceDate = GeneratedColumn<DateTime>(
    'invoice_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusIdMeta = const VerificationMeta(
    'statusId',
  );
  @override
  late final GeneratedColumn<String> statusId = GeneratedColumn<String>(
    'status_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusLabelMeta = const VerificationMeta(
    'statusLabel',
  );
  @override
  late final GeneratedColumn<String> statusLabel = GeneratedColumn<String>(
    'status_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusColorMeta = const VerificationMeta(
    'statusColor',
  );
  @override
  late final GeneratedColumn<String> statusColor = GeneratedColumn<String>(
    'status_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    customerId,
    customerName,
    reference,
    title,
    notes,
    invoiceDate,
    dueDate,
    statusId,
    statusLabel,
    statusColor,
    subtotal,
    tax,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_invoice_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesInvoiceTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('invoice_date')) {
      context.handle(
        _invoiceDateMeta,
        invoiceDate.isAcceptableOrUnknown(
          data['invoice_date']!,
          _invoiceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('status_id')) {
      context.handle(
        _statusIdMeta,
        statusId.isAcceptableOrUnknown(data['status_id']!, _statusIdMeta),
      );
    } else if (isInserting) {
      context.missing(_statusIdMeta);
    }
    if (data.containsKey('status_label')) {
      context.handle(
        _statusLabelMeta,
        statusLabel.isAcceptableOrUnknown(
          data['status_label']!,
          _statusLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statusLabelMeta);
    }
    if (data.containsKey('status_color')) {
      context.handle(
        _statusColorMeta,
        statusColor.isAcceptableOrUnknown(
          data['status_color']!,
          _statusColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statusColorMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesInvoiceTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesInvoiceTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      invoiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}invoice_date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      statusId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_id'],
      )!,
      statusLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_label'],
      )!,
      statusColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_color'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $SalesInvoiceTableTable createAlias(String alias) {
    return $SalesInvoiceTableTable(attachedDatabase, alias);
  }
}

class SalesInvoiceTableData extends DataClass
    implements Insertable<SalesInvoiceTableData> {
  final String id;
  final String companyId;
  final String customerId;
  final String customerName;
  final String reference;
  final String title;
  final String notes;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final String statusId;
  final String statusLabel;
  final String statusColor;
  final double subtotal;
  final double tax;
  final double total;
  const SalesInvoiceTableData({
    required this.id,
    required this.companyId,
    required this.customerId,
    required this.customerName,
    required this.reference,
    required this.title,
    required this.notes,
    required this.invoiceDate,
    required this.dueDate,
    required this.statusId,
    required this.statusLabel,
    required this.statusColor,
    required this.subtotal,
    required this.tax,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['customer_id'] = Variable<String>(customerId);
    map['customer_name'] = Variable<String>(customerName);
    map['reference'] = Variable<String>(reference);
    map['title'] = Variable<String>(title);
    map['notes'] = Variable<String>(notes);
    map['invoice_date'] = Variable<DateTime>(invoiceDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['status_id'] = Variable<String>(statusId);
    map['status_label'] = Variable<String>(statusLabel);
    map['status_color'] = Variable<String>(statusColor);
    map['subtotal'] = Variable<double>(subtotal);
    map['tax'] = Variable<double>(tax);
    map['total'] = Variable<double>(total);
    return map;
  }

  SalesInvoiceTableCompanion toCompanion(bool nullToAbsent) {
    return SalesInvoiceTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      customerId: Value(customerId),
      customerName: Value(customerName),
      reference: Value(reference),
      title: Value(title),
      notes: Value(notes),
      invoiceDate: Value(invoiceDate),
      dueDate: Value(dueDate),
      statusId: Value(statusId),
      statusLabel: Value(statusLabel),
      statusColor: Value(statusColor),
      subtotal: Value(subtotal),
      tax: Value(tax),
      total: Value(total),
    );
  }

  factory SalesInvoiceTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesInvoiceTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      customerId: serializer.fromJson<String>(json['customerId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      reference: serializer.fromJson<String>(json['reference']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String>(json['notes']),
      invoiceDate: serializer.fromJson<DateTime>(json['invoiceDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      statusId: serializer.fromJson<String>(json['statusId']),
      statusLabel: serializer.fromJson<String>(json['statusLabel']),
      statusColor: serializer.fromJson<String>(json['statusColor']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      tax: serializer.fromJson<double>(json['tax']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'customerId': serializer.toJson<String>(customerId),
      'customerName': serializer.toJson<String>(customerName),
      'reference': serializer.toJson<String>(reference),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String>(notes),
      'invoiceDate': serializer.toJson<DateTime>(invoiceDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'statusId': serializer.toJson<String>(statusId),
      'statusLabel': serializer.toJson<String>(statusLabel),
      'statusColor': serializer.toJson<String>(statusColor),
      'subtotal': serializer.toJson<double>(subtotal),
      'tax': serializer.toJson<double>(tax),
      'total': serializer.toJson<double>(total),
    };
  }

  SalesInvoiceTableData copyWith({
    String? id,
    String? companyId,
    String? customerId,
    String? customerName,
    String? reference,
    String? title,
    String? notes,
    DateTime? invoiceDate,
    DateTime? dueDate,
    String? statusId,
    String? statusLabel,
    String? statusColor,
    double? subtotal,
    double? tax,
    double? total,
  }) => SalesInvoiceTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    customerId: customerId ?? this.customerId,
    customerName: customerName ?? this.customerName,
    reference: reference ?? this.reference,
    title: title ?? this.title,
    notes: notes ?? this.notes,
    invoiceDate: invoiceDate ?? this.invoiceDate,
    dueDate: dueDate ?? this.dueDate,
    statusId: statusId ?? this.statusId,
    statusLabel: statusLabel ?? this.statusLabel,
    statusColor: statusColor ?? this.statusColor,
    subtotal: subtotal ?? this.subtotal,
    tax: tax ?? this.tax,
    total: total ?? this.total,
  );
  SalesInvoiceTableData copyWithCompanion(SalesInvoiceTableCompanion data) {
    return SalesInvoiceTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      reference: data.reference.present ? data.reference.value : this.reference,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      invoiceDate: data.invoiceDate.present
          ? data.invoiceDate.value
          : this.invoiceDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      statusId: data.statusId.present ? data.statusId.value : this.statusId,
      statusLabel: data.statusLabel.present
          ? data.statusLabel.value
          : this.statusLabel,
      statusColor: data.statusColor.present
          ? data.statusColor.value
          : this.statusColor,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      tax: data.tax.present ? data.tax.value : this.tax,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoiceTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('reference: $reference, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('statusId: $statusId, ')
          ..write('statusLabel: $statusLabel, ')
          ..write('statusColor: $statusColor, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    customerId,
    customerName,
    reference,
    title,
    notes,
    invoiceDate,
    dueDate,
    statusId,
    statusLabel,
    statusColor,
    subtotal,
    tax,
    total,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesInvoiceTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.reference == this.reference &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.invoiceDate == this.invoiceDate &&
          other.dueDate == this.dueDate &&
          other.statusId == this.statusId &&
          other.statusLabel == this.statusLabel &&
          other.statusColor == this.statusColor &&
          other.subtotal == this.subtotal &&
          other.tax == this.tax &&
          other.total == this.total);
}

class SalesInvoiceTableCompanion
    extends UpdateCompanion<SalesInvoiceTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> customerId;
  final Value<String> customerName;
  final Value<String> reference;
  final Value<String> title;
  final Value<String> notes;
  final Value<DateTime> invoiceDate;
  final Value<DateTime> dueDate;
  final Value<String> statusId;
  final Value<String> statusLabel;
  final Value<String> statusColor;
  final Value<double> subtotal;
  final Value<double> tax;
  final Value<double> total;
  final Value<int> rowid;
  const SalesInvoiceTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.reference = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.statusId = const Value.absent(),
    this.statusLabel = const Value.absent(),
    this.statusColor = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.tax = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesInvoiceTableCompanion.insert({
    required String id,
    required String companyId,
    required String customerId,
    required String customerName,
    required String reference,
    required String title,
    required String notes,
    required DateTime invoiceDate,
    required DateTime dueDate,
    required String statusId,
    required String statusLabel,
    required String statusColor,
    required double subtotal,
    required double tax,
    required double total,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       customerId = Value(customerId),
       customerName = Value(customerName),
       reference = Value(reference),
       title = Value(title),
       notes = Value(notes),
       invoiceDate = Value(invoiceDate),
       dueDate = Value(dueDate),
       statusId = Value(statusId),
       statusLabel = Value(statusLabel),
       statusColor = Value(statusColor),
       subtotal = Value(subtotal),
       tax = Value(tax),
       total = Value(total);
  static Insertable<SalesInvoiceTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? customerId,
    Expression<String>? customerName,
    Expression<String>? reference,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<DateTime>? invoiceDate,
    Expression<DateTime>? dueDate,
    Expression<String>? statusId,
    Expression<String>? statusLabel,
    Expression<String>? statusColor,
    Expression<double>? subtotal,
    Expression<double>? tax,
    Expression<double>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (customerId != null) 'customer_id': customerId,
      if (customerName != null) 'customer_name': customerName,
      if (reference != null) 'reference': reference,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (invoiceDate != null) 'invoice_date': invoiceDate,
      if (dueDate != null) 'due_date': dueDate,
      if (statusId != null) 'status_id': statusId,
      if (statusLabel != null) 'status_label': statusLabel,
      if (statusColor != null) 'status_color': statusColor,
      if (subtotal != null) 'subtotal': subtotal,
      if (tax != null) 'tax': tax,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesInvoiceTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? customerId,
    Value<String>? customerName,
    Value<String>? reference,
    Value<String>? title,
    Value<String>? notes,
    Value<DateTime>? invoiceDate,
    Value<DateTime>? dueDate,
    Value<String>? statusId,
    Value<String>? statusLabel,
    Value<String>? statusColor,
    Value<double>? subtotal,
    Value<double>? tax,
    Value<double>? total,
    Value<int>? rowid,
  }) {
    return SalesInvoiceTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      reference: reference ?? this.reference,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      dueDate: dueDate ?? this.dueDate,
      statusId: statusId ?? this.statusId,
      statusLabel: statusLabel ?? this.statusLabel,
      statusColor: statusColor ?? this.statusColor,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (invoiceDate.present) {
      map['invoice_date'] = Variable<DateTime>(invoiceDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (statusId.present) {
      map['status_id'] = Variable<String>(statusId.value);
    }
    if (statusLabel.present) {
      map['status_label'] = Variable<String>(statusLabel.value);
    }
    if (statusColor.present) {
      map['status_color'] = Variable<String>(statusColor.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoiceTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('reference: $reference, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('statusId: $statusId, ')
          ..write('statusLabel: $statusLabel, ')
          ..write('statusColor: $statusColor, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesInvoiceLineTableTable extends SalesInvoiceLineTable
    with TableInfo<$SalesInvoiceLineTableTable, SalesInvoiceLineTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesInvoiceLineTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    invoiceId,
    description,
    quantity,
    unitPrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_invoice_line_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesInvoiceLineTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesInvoiceLineTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesInvoiceLineTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
    );
  }

  @override
  $SalesInvoiceLineTableTable createAlias(String alias) {
    return $SalesInvoiceLineTableTable(attachedDatabase, alias);
  }
}

class SalesInvoiceLineTableData extends DataClass
    implements Insertable<SalesInvoiceLineTableData> {
  final String id;
  final String companyId;
  final String invoiceId;
  final String description;
  final double quantity;
  final double unitPrice;
  const SalesInvoiceLineTableData({
    required this.id,
    required this.companyId,
    required this.invoiceId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    return map;
  }

  SalesInvoiceLineTableCompanion toCompanion(bool nullToAbsent) {
    return SalesInvoiceLineTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      invoiceId: Value(invoiceId),
      description: Value(description),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
    );
  }

  factory SalesInvoiceLineTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesInvoiceLineTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
    };
  }

  SalesInvoiceLineTableData copyWith({
    String? id,
    String? companyId,
    String? invoiceId,
    String? description,
    double? quantity,
    double? unitPrice,
  }) => SalesInvoiceLineTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    invoiceId: invoiceId ?? this.invoiceId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
  );
  SalesInvoiceLineTableData copyWithCompanion(
    SalesInvoiceLineTableCompanion data,
  ) {
    return SalesInvoiceLineTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoiceLineTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, companyId, invoiceId, description, quantity, unitPrice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesInvoiceLineTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.invoiceId == this.invoiceId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice);
}

class SalesInvoiceLineTableCompanion
    extends UpdateCompanion<SalesInvoiceLineTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> invoiceId;
  final Value<String> description;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<int> rowid;
  const SalesInvoiceLineTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesInvoiceLineTableCompanion.insert({
    required String id,
    required String companyId,
    required String invoiceId,
    required String description,
    required double quantity,
    required double unitPrice,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       invoiceId = Value(invoiceId),
       description = Value(description),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice);
  static Insertable<SalesInvoiceLineTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? invoiceId,
    Expression<String>? description,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesInvoiceLineTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? invoiceId,
    Value<String>? description,
    Value<double>? quantity,
    Value<double>? unitPrice,
    Value<int>? rowid,
  }) {
    return SalesInvoiceLineTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      invoiceId: invoiceId ?? this.invoiceId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoiceLineTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VendorBillTableTable extends VendorBillTable
    with TableInfo<$VendorBillTableTable, VendorBillTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VendorBillTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vendorIdMeta = const VerificationMeta(
    'vendorId',
  );
  @override
  late final GeneratedColumn<String> vendorId = GeneratedColumn<String>(
    'vendor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseOrderIdMeta = const VerificationMeta(
    'purchaseOrderId',
  );
  @override
  late final GeneratedColumn<String> purchaseOrderId = GeneratedColumn<String>(
    'purchase_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goodsReceiptIdMeta = const VerificationMeta(
    'goodsReceiptId',
  );
  @override
  late final GeneratedColumn<String> goodsReceiptId = GeneratedColumn<String>(
    'goods_receipt_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billDateMeta = const VerificationMeta(
    'billDate',
  );
  @override
  late final GeneratedColumn<DateTime> billDate = GeneratedColumn<DateTime>(
    'bill_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusIdMeta = const VerificationMeta(
    'statusId',
  );
  @override
  late final GeneratedColumn<String> statusId = GeneratedColumn<String>(
    'status_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusLabelMeta = const VerificationMeta(
    'statusLabel',
  );
  @override
  late final GeneratedColumn<String> statusLabel = GeneratedColumn<String>(
    'status_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusColorMeta = const VerificationMeta(
    'statusColor',
  );
  @override
  late final GeneratedColumn<String> statusColor = GeneratedColumn<String>(
    'status_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    vendorId,
    purchaseOrderId,
    goodsReceiptId,
    reference,
    title,
    notes,
    billDate,
    dueDate,
    statusId,
    statusLabel,
    statusColor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vendor_bill_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<VendorBillTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('vendor_id')) {
      context.handle(
        _vendorIdMeta,
        vendorId.isAcceptableOrUnknown(data['vendor_id']!, _vendorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vendorIdMeta);
    }
    if (data.containsKey('purchase_order_id')) {
      context.handle(
        _purchaseOrderIdMeta,
        purchaseOrderId.isAcceptableOrUnknown(
          data['purchase_order_id']!,
          _purchaseOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseOrderIdMeta);
    }
    if (data.containsKey('goods_receipt_id')) {
      context.handle(
        _goodsReceiptIdMeta,
        goodsReceiptId.isAcceptableOrUnknown(
          data['goods_receipt_id']!,
          _goodsReceiptIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_goodsReceiptIdMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('bill_date')) {
      context.handle(
        _billDateMeta,
        billDate.isAcceptableOrUnknown(data['bill_date']!, _billDateMeta),
      );
    } else if (isInserting) {
      context.missing(_billDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('status_id')) {
      context.handle(
        _statusIdMeta,
        statusId.isAcceptableOrUnknown(data['status_id']!, _statusIdMeta),
      );
    } else if (isInserting) {
      context.missing(_statusIdMeta);
    }
    if (data.containsKey('status_label')) {
      context.handle(
        _statusLabelMeta,
        statusLabel.isAcceptableOrUnknown(
          data['status_label']!,
          _statusLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statusLabelMeta);
    }
    if (data.containsKey('status_color')) {
      context.handle(
        _statusColorMeta,
        statusColor.isAcceptableOrUnknown(
          data['status_color']!,
          _statusColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statusColorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VendorBillTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VendorBillTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      vendorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_id'],
      )!,
      purchaseOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_order_id'],
      )!,
      goodsReceiptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goods_receipt_id'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      billDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}bill_date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      statusId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_id'],
      )!,
      statusLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_label'],
      )!,
      statusColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_color'],
      )!,
    );
  }

  @override
  $VendorBillTableTable createAlias(String alias) {
    return $VendorBillTableTable(attachedDatabase, alias);
  }
}

class VendorBillTableData extends DataClass
    implements Insertable<VendorBillTableData> {
  final String id;
  final String companyId;
  final String vendorId;
  final String purchaseOrderId;
  final String goodsReceiptId;
  final String reference;
  final String title;
  final String notes;
  final DateTime billDate;
  final DateTime dueDate;
  final String statusId;
  final String statusLabel;
  final String statusColor;
  const VendorBillTableData({
    required this.id,
    required this.companyId,
    required this.vendorId,
    required this.purchaseOrderId,
    required this.goodsReceiptId,
    required this.reference,
    required this.title,
    required this.notes,
    required this.billDate,
    required this.dueDate,
    required this.statusId,
    required this.statusLabel,
    required this.statusColor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['vendor_id'] = Variable<String>(vendorId);
    map['purchase_order_id'] = Variable<String>(purchaseOrderId);
    map['goods_receipt_id'] = Variable<String>(goodsReceiptId);
    map['reference'] = Variable<String>(reference);
    map['title'] = Variable<String>(title);
    map['notes'] = Variable<String>(notes);
    map['bill_date'] = Variable<DateTime>(billDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['status_id'] = Variable<String>(statusId);
    map['status_label'] = Variable<String>(statusLabel);
    map['status_color'] = Variable<String>(statusColor);
    return map;
  }

  VendorBillTableCompanion toCompanion(bool nullToAbsent) {
    return VendorBillTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      vendorId: Value(vendorId),
      purchaseOrderId: Value(purchaseOrderId),
      goodsReceiptId: Value(goodsReceiptId),
      reference: Value(reference),
      title: Value(title),
      notes: Value(notes),
      billDate: Value(billDate),
      dueDate: Value(dueDate),
      statusId: Value(statusId),
      statusLabel: Value(statusLabel),
      statusColor: Value(statusColor),
    );
  }

  factory VendorBillTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VendorBillTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      vendorId: serializer.fromJson<String>(json['vendorId']),
      purchaseOrderId: serializer.fromJson<String>(json['purchaseOrderId']),
      goodsReceiptId: serializer.fromJson<String>(json['goodsReceiptId']),
      reference: serializer.fromJson<String>(json['reference']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String>(json['notes']),
      billDate: serializer.fromJson<DateTime>(json['billDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      statusId: serializer.fromJson<String>(json['statusId']),
      statusLabel: serializer.fromJson<String>(json['statusLabel']),
      statusColor: serializer.fromJson<String>(json['statusColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'vendorId': serializer.toJson<String>(vendorId),
      'purchaseOrderId': serializer.toJson<String>(purchaseOrderId),
      'goodsReceiptId': serializer.toJson<String>(goodsReceiptId),
      'reference': serializer.toJson<String>(reference),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String>(notes),
      'billDate': serializer.toJson<DateTime>(billDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'statusId': serializer.toJson<String>(statusId),
      'statusLabel': serializer.toJson<String>(statusLabel),
      'statusColor': serializer.toJson<String>(statusColor),
    };
  }

  VendorBillTableData copyWith({
    String? id,
    String? companyId,
    String? vendorId,
    String? purchaseOrderId,
    String? goodsReceiptId,
    String? reference,
    String? title,
    String? notes,
    DateTime? billDate,
    DateTime? dueDate,
    String? statusId,
    String? statusLabel,
    String? statusColor,
  }) => VendorBillTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    vendorId: vendorId ?? this.vendorId,
    purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
    goodsReceiptId: goodsReceiptId ?? this.goodsReceiptId,
    reference: reference ?? this.reference,
    title: title ?? this.title,
    notes: notes ?? this.notes,
    billDate: billDate ?? this.billDate,
    dueDate: dueDate ?? this.dueDate,
    statusId: statusId ?? this.statusId,
    statusLabel: statusLabel ?? this.statusLabel,
    statusColor: statusColor ?? this.statusColor,
  );
  VendorBillTableData copyWithCompanion(VendorBillTableCompanion data) {
    return VendorBillTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      vendorId: data.vendorId.present ? data.vendorId.value : this.vendorId,
      purchaseOrderId: data.purchaseOrderId.present
          ? data.purchaseOrderId.value
          : this.purchaseOrderId,
      goodsReceiptId: data.goodsReceiptId.present
          ? data.goodsReceiptId.value
          : this.goodsReceiptId,
      reference: data.reference.present ? data.reference.value : this.reference,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      billDate: data.billDate.present ? data.billDate.value : this.billDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      statusId: data.statusId.present ? data.statusId.value : this.statusId,
      statusLabel: data.statusLabel.present
          ? data.statusLabel.value
          : this.statusLabel,
      statusColor: data.statusColor.present
          ? data.statusColor.value
          : this.statusColor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VendorBillTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('vendorId: $vendorId, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('goodsReceiptId: $goodsReceiptId, ')
          ..write('reference: $reference, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('billDate: $billDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('statusId: $statusId, ')
          ..write('statusLabel: $statusLabel, ')
          ..write('statusColor: $statusColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    vendorId,
    purchaseOrderId,
    goodsReceiptId,
    reference,
    title,
    notes,
    billDate,
    dueDate,
    statusId,
    statusLabel,
    statusColor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VendorBillTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.vendorId == this.vendorId &&
          other.purchaseOrderId == this.purchaseOrderId &&
          other.goodsReceiptId == this.goodsReceiptId &&
          other.reference == this.reference &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.billDate == this.billDate &&
          other.dueDate == this.dueDate &&
          other.statusId == this.statusId &&
          other.statusLabel == this.statusLabel &&
          other.statusColor == this.statusColor);
}

class VendorBillTableCompanion extends UpdateCompanion<VendorBillTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> vendorId;
  final Value<String> purchaseOrderId;
  final Value<String> goodsReceiptId;
  final Value<String> reference;
  final Value<String> title;
  final Value<String> notes;
  final Value<DateTime> billDate;
  final Value<DateTime> dueDate;
  final Value<String> statusId;
  final Value<String> statusLabel;
  final Value<String> statusColor;
  final Value<int> rowid;
  const VendorBillTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.vendorId = const Value.absent(),
    this.purchaseOrderId = const Value.absent(),
    this.goodsReceiptId = const Value.absent(),
    this.reference = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.billDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.statusId = const Value.absent(),
    this.statusLabel = const Value.absent(),
    this.statusColor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VendorBillTableCompanion.insert({
    required String id,
    required String companyId,
    required String vendorId,
    required String purchaseOrderId,
    required String goodsReceiptId,
    required String reference,
    required String title,
    required String notes,
    required DateTime billDate,
    required DateTime dueDate,
    required String statusId,
    required String statusLabel,
    required String statusColor,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       vendorId = Value(vendorId),
       purchaseOrderId = Value(purchaseOrderId),
       goodsReceiptId = Value(goodsReceiptId),
       reference = Value(reference),
       title = Value(title),
       notes = Value(notes),
       billDate = Value(billDate),
       dueDate = Value(dueDate),
       statusId = Value(statusId),
       statusLabel = Value(statusLabel),
       statusColor = Value(statusColor);
  static Insertable<VendorBillTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? vendorId,
    Expression<String>? purchaseOrderId,
    Expression<String>? goodsReceiptId,
    Expression<String>? reference,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<DateTime>? billDate,
    Expression<DateTime>? dueDate,
    Expression<String>? statusId,
    Expression<String>? statusLabel,
    Expression<String>? statusColor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (vendorId != null) 'vendor_id': vendorId,
      if (purchaseOrderId != null) 'purchase_order_id': purchaseOrderId,
      if (goodsReceiptId != null) 'goods_receipt_id': goodsReceiptId,
      if (reference != null) 'reference': reference,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (billDate != null) 'bill_date': billDate,
      if (dueDate != null) 'due_date': dueDate,
      if (statusId != null) 'status_id': statusId,
      if (statusLabel != null) 'status_label': statusLabel,
      if (statusColor != null) 'status_color': statusColor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VendorBillTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? vendorId,
    Value<String>? purchaseOrderId,
    Value<String>? goodsReceiptId,
    Value<String>? reference,
    Value<String>? title,
    Value<String>? notes,
    Value<DateTime>? billDate,
    Value<DateTime>? dueDate,
    Value<String>? statusId,
    Value<String>? statusLabel,
    Value<String>? statusColor,
    Value<int>? rowid,
  }) {
    return VendorBillTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      vendorId: vendorId ?? this.vendorId,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      goodsReceiptId: goodsReceiptId ?? this.goodsReceiptId,
      reference: reference ?? this.reference,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      billDate: billDate ?? this.billDate,
      dueDate: dueDate ?? this.dueDate,
      statusId: statusId ?? this.statusId,
      statusLabel: statusLabel ?? this.statusLabel,
      statusColor: statusColor ?? this.statusColor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (vendorId.present) {
      map['vendor_id'] = Variable<String>(vendorId.value);
    }
    if (purchaseOrderId.present) {
      map['purchase_order_id'] = Variable<String>(purchaseOrderId.value);
    }
    if (goodsReceiptId.present) {
      map['goods_receipt_id'] = Variable<String>(goodsReceiptId.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (billDate.present) {
      map['bill_date'] = Variable<DateTime>(billDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (statusId.present) {
      map['status_id'] = Variable<String>(statusId.value);
    }
    if (statusLabel.present) {
      map['status_label'] = Variable<String>(statusLabel.value);
    }
    if (statusColor.present) {
      map['status_color'] = Variable<String>(statusColor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VendorBillTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('vendorId: $vendorId, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('goodsReceiptId: $goodsReceiptId, ')
          ..write('reference: $reference, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('billDate: $billDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('statusId: $statusId, ')
          ..write('statusLabel: $statusLabel, ')
          ..write('statusColor: $statusColor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VendorBillLineTableTable extends VendorBillLineTable
    with TableInfo<$VendorBillLineTableTable, VendorBillLineTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VendorBillLineTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    billId,
    description,
    quantity,
    unitPrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vendor_bill_line_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<VendorBillLineTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VendorBillLineTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VendorBillLineTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bill_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
    );
  }

  @override
  $VendorBillLineTableTable createAlias(String alias) {
    return $VendorBillLineTableTable(attachedDatabase, alias);
  }
}

class VendorBillLineTableData extends DataClass
    implements Insertable<VendorBillLineTableData> {
  final String id;
  final String companyId;
  final String billId;
  final String description;
  final double quantity;
  final double unitPrice;
  const VendorBillLineTableData({
    required this.id,
    required this.companyId,
    required this.billId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['bill_id'] = Variable<String>(billId);
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    return map;
  }

  VendorBillLineTableCompanion toCompanion(bool nullToAbsent) {
    return VendorBillLineTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      billId: Value(billId),
      description: Value(description),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
    );
  }

  factory VendorBillLineTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VendorBillLineTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      billId: serializer.fromJson<String>(json['billId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'billId': serializer.toJson<String>(billId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
    };
  }

  VendorBillLineTableData copyWith({
    String? id,
    String? companyId,
    String? billId,
    String? description,
    double? quantity,
    double? unitPrice,
  }) => VendorBillLineTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    billId: billId ?? this.billId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
  );
  VendorBillLineTableData copyWithCompanion(VendorBillLineTableCompanion data) {
    return VendorBillLineTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      billId: data.billId.present ? data.billId.value : this.billId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VendorBillLineTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('billId: $billId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, companyId, billId, description, quantity, unitPrice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VendorBillLineTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.billId == this.billId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice);
}

class VendorBillLineTableCompanion
    extends UpdateCompanion<VendorBillLineTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> billId;
  final Value<String> description;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<int> rowid;
  const VendorBillLineTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.billId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VendorBillLineTableCompanion.insert({
    required String id,
    required String companyId,
    required String billId,
    required String description,
    required double quantity,
    required double unitPrice,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       billId = Value(billId),
       description = Value(description),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice);
  static Insertable<VendorBillLineTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? billId,
    Expression<String>? description,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (billId != null) 'bill_id': billId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VendorBillLineTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? billId,
    Value<String>? description,
    Value<double>? quantity,
    Value<double>? unitPrice,
    Value<int>? rowid,
  }) {
    return VendorBillLineTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      billId: billId ?? this.billId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VendorBillLineTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('billId: $billId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrderTableTable extends PurchaseOrderTable
    with TableInfo<$PurchaseOrderTableTable, PurchaseOrderTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrderTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vendorIdMeta = const VerificationMeta(
    'vendorId',
  );
  @override
  late final GeneratedColumn<String> vendorId = GeneratedColumn<String>(
    'vendor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderDateMeta = const VerificationMeta(
    'orderDate',
  );
  @override
  late final GeneratedColumn<DateTime> orderDate = GeneratedColumn<DateTime>(
    'order_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedDateMeta = const VerificationMeta(
    'expectedDate',
  );
  @override
  late final GeneratedColumn<DateTime> expectedDate = GeneratedColumn<DateTime>(
    'expected_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusIdMeta = const VerificationMeta(
    'statusId',
  );
  @override
  late final GeneratedColumn<String> statusId = GeneratedColumn<String>(
    'status_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusLabelMeta = const VerificationMeta(
    'statusLabel',
  );
  @override
  late final GeneratedColumn<String> statusLabel = GeneratedColumn<String>(
    'status_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusColorMeta = const VerificationMeta(
    'statusColor',
  );
  @override
  late final GeneratedColumn<String> statusColor = GeneratedColumn<String>(
    'status_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    vendorId,
    reference,
    title,
    notes,
    orderDate,
    expectedDate,
    statusId,
    statusLabel,
    statusColor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_order_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrderTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('vendor_id')) {
      context.handle(
        _vendorIdMeta,
        vendorId.isAcceptableOrUnknown(data['vendor_id']!, _vendorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vendorIdMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('order_date')) {
      context.handle(
        _orderDateMeta,
        orderDate.isAcceptableOrUnknown(data['order_date']!, _orderDateMeta),
      );
    } else if (isInserting) {
      context.missing(_orderDateMeta);
    }
    if (data.containsKey('expected_date')) {
      context.handle(
        _expectedDateMeta,
        expectedDate.isAcceptableOrUnknown(
          data['expected_date']!,
          _expectedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedDateMeta);
    }
    if (data.containsKey('status_id')) {
      context.handle(
        _statusIdMeta,
        statusId.isAcceptableOrUnknown(data['status_id']!, _statusIdMeta),
      );
    } else if (isInserting) {
      context.missing(_statusIdMeta);
    }
    if (data.containsKey('status_label')) {
      context.handle(
        _statusLabelMeta,
        statusLabel.isAcceptableOrUnknown(
          data['status_label']!,
          _statusLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statusLabelMeta);
    }
    if (data.containsKey('status_color')) {
      context.handle(
        _statusColorMeta,
        statusColor.isAcceptableOrUnknown(
          data['status_color']!,
          _statusColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statusColorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrderTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrderTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      vendorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_id'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      orderDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}order_date'],
      )!,
      expectedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_date'],
      )!,
      statusId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_id'],
      )!,
      statusLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_label'],
      )!,
      statusColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_color'],
      )!,
    );
  }

  @override
  $PurchaseOrderTableTable createAlias(String alias) {
    return $PurchaseOrderTableTable(attachedDatabase, alias);
  }
}

class PurchaseOrderTableData extends DataClass
    implements Insertable<PurchaseOrderTableData> {
  final String id;
  final String companyId;
  final String vendorId;
  final String reference;
  final String title;
  final String notes;
  final DateTime orderDate;
  final DateTime expectedDate;
  final String statusId;
  final String statusLabel;
  final String statusColor;
  const PurchaseOrderTableData({
    required this.id,
    required this.companyId,
    required this.vendorId,
    required this.reference,
    required this.title,
    required this.notes,
    required this.orderDate,
    required this.expectedDate,
    required this.statusId,
    required this.statusLabel,
    required this.statusColor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['vendor_id'] = Variable<String>(vendorId);
    map['reference'] = Variable<String>(reference);
    map['title'] = Variable<String>(title);
    map['notes'] = Variable<String>(notes);
    map['order_date'] = Variable<DateTime>(orderDate);
    map['expected_date'] = Variable<DateTime>(expectedDate);
    map['status_id'] = Variable<String>(statusId);
    map['status_label'] = Variable<String>(statusLabel);
    map['status_color'] = Variable<String>(statusColor);
    return map;
  }

  PurchaseOrderTableCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrderTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      vendorId: Value(vendorId),
      reference: Value(reference),
      title: Value(title),
      notes: Value(notes),
      orderDate: Value(orderDate),
      expectedDate: Value(expectedDate),
      statusId: Value(statusId),
      statusLabel: Value(statusLabel),
      statusColor: Value(statusColor),
    );
  }

  factory PurchaseOrderTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrderTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      vendorId: serializer.fromJson<String>(json['vendorId']),
      reference: serializer.fromJson<String>(json['reference']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String>(json['notes']),
      orderDate: serializer.fromJson<DateTime>(json['orderDate']),
      expectedDate: serializer.fromJson<DateTime>(json['expectedDate']),
      statusId: serializer.fromJson<String>(json['statusId']),
      statusLabel: serializer.fromJson<String>(json['statusLabel']),
      statusColor: serializer.fromJson<String>(json['statusColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'vendorId': serializer.toJson<String>(vendorId),
      'reference': serializer.toJson<String>(reference),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String>(notes),
      'orderDate': serializer.toJson<DateTime>(orderDate),
      'expectedDate': serializer.toJson<DateTime>(expectedDate),
      'statusId': serializer.toJson<String>(statusId),
      'statusLabel': serializer.toJson<String>(statusLabel),
      'statusColor': serializer.toJson<String>(statusColor),
    };
  }

  PurchaseOrderTableData copyWith({
    String? id,
    String? companyId,
    String? vendorId,
    String? reference,
    String? title,
    String? notes,
    DateTime? orderDate,
    DateTime? expectedDate,
    String? statusId,
    String? statusLabel,
    String? statusColor,
  }) => PurchaseOrderTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    vendorId: vendorId ?? this.vendorId,
    reference: reference ?? this.reference,
    title: title ?? this.title,
    notes: notes ?? this.notes,
    orderDate: orderDate ?? this.orderDate,
    expectedDate: expectedDate ?? this.expectedDate,
    statusId: statusId ?? this.statusId,
    statusLabel: statusLabel ?? this.statusLabel,
    statusColor: statusColor ?? this.statusColor,
  );
  PurchaseOrderTableData copyWithCompanion(PurchaseOrderTableCompanion data) {
    return PurchaseOrderTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      vendorId: data.vendorId.present ? data.vendorId.value : this.vendorId,
      reference: data.reference.present ? data.reference.value : this.reference,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      orderDate: data.orderDate.present ? data.orderDate.value : this.orderDate,
      expectedDate: data.expectedDate.present
          ? data.expectedDate.value
          : this.expectedDate,
      statusId: data.statusId.present ? data.statusId.value : this.statusId,
      statusLabel: data.statusLabel.present
          ? data.statusLabel.value
          : this.statusLabel,
      statusColor: data.statusColor.present
          ? data.statusColor.value
          : this.statusColor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('vendorId: $vendorId, ')
          ..write('reference: $reference, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('orderDate: $orderDate, ')
          ..write('expectedDate: $expectedDate, ')
          ..write('statusId: $statusId, ')
          ..write('statusLabel: $statusLabel, ')
          ..write('statusColor: $statusColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    vendorId,
    reference,
    title,
    notes,
    orderDate,
    expectedDate,
    statusId,
    statusLabel,
    statusColor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrderTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.vendorId == this.vendorId &&
          other.reference == this.reference &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.orderDate == this.orderDate &&
          other.expectedDate == this.expectedDate &&
          other.statusId == this.statusId &&
          other.statusLabel == this.statusLabel &&
          other.statusColor == this.statusColor);
}

class PurchaseOrderTableCompanion
    extends UpdateCompanion<PurchaseOrderTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> vendorId;
  final Value<String> reference;
  final Value<String> title;
  final Value<String> notes;
  final Value<DateTime> orderDate;
  final Value<DateTime> expectedDate;
  final Value<String> statusId;
  final Value<String> statusLabel;
  final Value<String> statusColor;
  final Value<int> rowid;
  const PurchaseOrderTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.vendorId = const Value.absent(),
    this.reference = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.orderDate = const Value.absent(),
    this.expectedDate = const Value.absent(),
    this.statusId = const Value.absent(),
    this.statusLabel = const Value.absent(),
    this.statusColor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseOrderTableCompanion.insert({
    required String id,
    required String companyId,
    required String vendorId,
    required String reference,
    required String title,
    required String notes,
    required DateTime orderDate,
    required DateTime expectedDate,
    required String statusId,
    required String statusLabel,
    required String statusColor,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       vendorId = Value(vendorId),
       reference = Value(reference),
       title = Value(title),
       notes = Value(notes),
       orderDate = Value(orderDate),
       expectedDate = Value(expectedDate),
       statusId = Value(statusId),
       statusLabel = Value(statusLabel),
       statusColor = Value(statusColor);
  static Insertable<PurchaseOrderTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? vendorId,
    Expression<String>? reference,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<DateTime>? orderDate,
    Expression<DateTime>? expectedDate,
    Expression<String>? statusId,
    Expression<String>? statusLabel,
    Expression<String>? statusColor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (vendorId != null) 'vendor_id': vendorId,
      if (reference != null) 'reference': reference,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (orderDate != null) 'order_date': orderDate,
      if (expectedDate != null) 'expected_date': expectedDate,
      if (statusId != null) 'status_id': statusId,
      if (statusLabel != null) 'status_label': statusLabel,
      if (statusColor != null) 'status_color': statusColor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseOrderTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? vendorId,
    Value<String>? reference,
    Value<String>? title,
    Value<String>? notes,
    Value<DateTime>? orderDate,
    Value<DateTime>? expectedDate,
    Value<String>? statusId,
    Value<String>? statusLabel,
    Value<String>? statusColor,
    Value<int>? rowid,
  }) {
    return PurchaseOrderTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      vendorId: vendorId ?? this.vendorId,
      reference: reference ?? this.reference,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      orderDate: orderDate ?? this.orderDate,
      expectedDate: expectedDate ?? this.expectedDate,
      statusId: statusId ?? this.statusId,
      statusLabel: statusLabel ?? this.statusLabel,
      statusColor: statusColor ?? this.statusColor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (vendorId.present) {
      map['vendor_id'] = Variable<String>(vendorId.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (orderDate.present) {
      map['order_date'] = Variable<DateTime>(orderDate.value);
    }
    if (expectedDate.present) {
      map['expected_date'] = Variable<DateTime>(expectedDate.value);
    }
    if (statusId.present) {
      map['status_id'] = Variable<String>(statusId.value);
    }
    if (statusLabel.present) {
      map['status_label'] = Variable<String>(statusLabel.value);
    }
    if (statusColor.present) {
      map['status_color'] = Variable<String>(statusColor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('vendorId: $vendorId, ')
          ..write('reference: $reference, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('orderDate: $orderDate, ')
          ..write('expectedDate: $expectedDate, ')
          ..write('statusId: $statusId, ')
          ..write('statusLabel: $statusLabel, ')
          ..write('statusColor: $statusColor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrderLineTableTable extends PurchaseOrderLineTable
    with TableInfo<$PurchaseOrderLineTableTable, PurchaseOrderLineTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrderLineTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseOrderIdMeta = const VerificationMeta(
    'purchaseOrderId',
  );
  @override
  late final GeneratedColumn<String> purchaseOrderId = GeneratedColumn<String>(
    'purchase_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    purchaseOrderId,
    description,
    quantity,
    unitPrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_order_line_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrderLineTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('purchase_order_id')) {
      context.handle(
        _purchaseOrderIdMeta,
        purchaseOrderId.isAcceptableOrUnknown(
          data['purchase_order_id']!,
          _purchaseOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseOrderIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrderLineTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrderLineTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      purchaseOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_order_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
    );
  }

  @override
  $PurchaseOrderLineTableTable createAlias(String alias) {
    return $PurchaseOrderLineTableTable(attachedDatabase, alias);
  }
}

class PurchaseOrderLineTableData extends DataClass
    implements Insertable<PurchaseOrderLineTableData> {
  final String id;
  final String companyId;
  final String purchaseOrderId;
  final String description;
  final double quantity;
  final double unitPrice;
  const PurchaseOrderLineTableData({
    required this.id,
    required this.companyId,
    required this.purchaseOrderId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['purchase_order_id'] = Variable<String>(purchaseOrderId);
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    return map;
  }

  PurchaseOrderLineTableCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrderLineTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      purchaseOrderId: Value(purchaseOrderId),
      description: Value(description),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
    );
  }

  factory PurchaseOrderLineTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrderLineTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      purchaseOrderId: serializer.fromJson<String>(json['purchaseOrderId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'purchaseOrderId': serializer.toJson<String>(purchaseOrderId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
    };
  }

  PurchaseOrderLineTableData copyWith({
    String? id,
    String? companyId,
    String? purchaseOrderId,
    String? description,
    double? quantity,
    double? unitPrice,
  }) => PurchaseOrderLineTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
  );
  PurchaseOrderLineTableData copyWithCompanion(
    PurchaseOrderLineTableCompanion data,
  ) {
    return PurchaseOrderLineTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      purchaseOrderId: data.purchaseOrderId.present
          ? data.purchaseOrderId.value
          : this.purchaseOrderId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderLineTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    purchaseOrderId,
    description,
    quantity,
    unitPrice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrderLineTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.purchaseOrderId == this.purchaseOrderId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice);
}

class PurchaseOrderLineTableCompanion
    extends UpdateCompanion<PurchaseOrderLineTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> purchaseOrderId;
  final Value<String> description;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<int> rowid;
  const PurchaseOrderLineTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.purchaseOrderId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseOrderLineTableCompanion.insert({
    required String id,
    required String companyId,
    required String purchaseOrderId,
    required String description,
    required double quantity,
    required double unitPrice,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       purchaseOrderId = Value(purchaseOrderId),
       description = Value(description),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice);
  static Insertable<PurchaseOrderLineTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? purchaseOrderId,
    Expression<String>? description,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (purchaseOrderId != null) 'purchase_order_id': purchaseOrderId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseOrderLineTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? purchaseOrderId,
    Value<String>? description,
    Value<double>? quantity,
    Value<double>? unitPrice,
    Value<int>? rowid,
  }) {
    return PurchaseOrderLineTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (purchaseOrderId.present) {
      map['purchase_order_id'] = Variable<String>(purchaseOrderId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderLineTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpenseTableTable extends ExpenseTable
    with TableInfo<$ExpenseTableTable, ExpenseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantMeta = const VerificationMeta(
    'merchant',
  );
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
    'merchant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodIdMeta = const VerificationMeta(
    'paymentMethodId',
  );
  @override
  late final GeneratedColumn<String> paymentMethodId = GeneratedColumn<String>(
    'payment_method_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attachmentIdsMeta = const VerificationMeta(
    'attachmentIds',
  );
  @override
  late final GeneratedColumn<String> attachmentIds = GeneratedColumn<String>(
    'attachment_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    merchant,
    amount,
    categoryId,
    paymentMethodId,
    occurredAt,
    description,
    attachmentIds,
    status,
    businessId,
    createdAt,
    updatedAt,
    createdBy,
    updatedBy,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('merchant')) {
      context.handle(
        _merchantMeta,
        merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta),
      );
    } else if (isInserting) {
      context.missing(_merchantMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('payment_method_id')) {
      context.handle(
        _paymentMethodIdMeta,
        paymentMethodId.isAcceptableOrUnknown(
          data['payment_method_id']!,
          _paymentMethodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('attachment_ids')) {
      context.handle(
        _attachmentIdsMeta,
        attachmentIds.isAcceptableOrUnknown(
          data['attachment_ids']!,
          _attachmentIdsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attachmentIdsMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedByMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    } else if (isInserting) {
      context.missing(_isDeletedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      merchant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      paymentMethodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method_id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      attachmentIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_ids'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $ExpenseTableTable createAlias(String alias) {
    return $ExpenseTableTable(attachedDatabase, alias);
  }
}

class ExpenseTableData extends DataClass
    implements Insertable<ExpenseTableData> {
  final String id;
  final String companyId;
  final String merchant;
  final double amount;
  final String categoryId;
  final String paymentMethodId;
  final DateTime occurredAt;
  final String description;
  final String attachmentIds;
  final String status;
  final String businessId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String updatedBy;
  final bool isDeleted;
  const ExpenseTableData({
    required this.id,
    required this.companyId,
    required this.merchant,
    required this.amount,
    required this.categoryId,
    required this.paymentMethodId,
    required this.occurredAt,
    required this.description,
    required this.attachmentIds,
    required this.status,
    required this.businessId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['merchant'] = Variable<String>(merchant);
    map['amount'] = Variable<double>(amount);
    map['category_id'] = Variable<String>(categoryId);
    map['payment_method_id'] = Variable<String>(paymentMethodId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['description'] = Variable<String>(description);
    map['attachment_ids'] = Variable<String>(attachmentIds);
    map['status'] = Variable<String>(status);
    map['business_id'] = Variable<String>(businessId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_by'] = Variable<String>(createdBy);
    map['updated_by'] = Variable<String>(updatedBy);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ExpenseTableCompanion toCompanion(bool nullToAbsent) {
    return ExpenseTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      merchant: Value(merchant),
      amount: Value(amount),
      categoryId: Value(categoryId),
      paymentMethodId: Value(paymentMethodId),
      occurredAt: Value(occurredAt),
      description: Value(description),
      attachmentIds: Value(attachmentIds),
      status: Value(status),
      businessId: Value(businessId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      createdBy: Value(createdBy),
      updatedBy: Value(updatedBy),
      isDeleted: Value(isDeleted),
    );
  }

  factory ExpenseTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      merchant: serializer.fromJson<String>(json['merchant']),
      amount: serializer.fromJson<double>(json['amount']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      paymentMethodId: serializer.fromJson<String>(json['paymentMethodId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      description: serializer.fromJson<String>(json['description']),
      attachmentIds: serializer.fromJson<String>(json['attachmentIds']),
      status: serializer.fromJson<String>(json['status']),
      businessId: serializer.fromJson<String>(json['businessId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'merchant': serializer.toJson<String>(merchant),
      'amount': serializer.toJson<double>(amount),
      'categoryId': serializer.toJson<String>(categoryId),
      'paymentMethodId': serializer.toJson<String>(paymentMethodId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'description': serializer.toJson<String>(description),
      'attachmentIds': serializer.toJson<String>(attachmentIds),
      'status': serializer.toJson<String>(status),
      'businessId': serializer.toJson<String>(businessId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  ExpenseTableData copyWith({
    String? id,
    String? companyId,
    String? merchant,
    double? amount,
    String? categoryId,
    String? paymentMethodId,
    DateTime? occurredAt,
    String? description,
    String? attachmentIds,
    String? status,
    String? businessId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    bool? isDeleted,
  }) => ExpenseTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    merchant: merchant ?? this.merchant,
    amount: amount ?? this.amount,
    categoryId: categoryId ?? this.categoryId,
    paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    occurredAt: occurredAt ?? this.occurredAt,
    description: description ?? this.description,
    attachmentIds: attachmentIds ?? this.attachmentIds,
    status: status ?? this.status,
    businessId: businessId ?? this.businessId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy ?? this.createdBy,
    updatedBy: updatedBy ?? this.updatedBy,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  ExpenseTableData copyWithCompanion(ExpenseTableCompanion data) {
    return ExpenseTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      merchant: data.merchant.present ? data.merchant.value : this.merchant,
      amount: data.amount.present ? data.amount.value : this.amount,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      paymentMethodId: data.paymentMethodId.present
          ? data.paymentMethodId.value
          : this.paymentMethodId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      description: data.description.present
          ? data.description.value
          : this.description,
      attachmentIds: data.attachmentIds.present
          ? data.attachmentIds.value
          : this.attachmentIds,
      status: data.status.present ? data.status.value : this.status,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('merchant: $merchant, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('description: $description, ')
          ..write('attachmentIds: $attachmentIds, ')
          ..write('status: $status, ')
          ..write('businessId: $businessId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    merchant,
    amount,
    categoryId,
    paymentMethodId,
    occurredAt,
    description,
    attachmentIds,
    status,
    businessId,
    createdAt,
    updatedAt,
    createdBy,
    updatedBy,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.merchant == this.merchant &&
          other.amount == this.amount &&
          other.categoryId == this.categoryId &&
          other.paymentMethodId == this.paymentMethodId &&
          other.occurredAt == this.occurredAt &&
          other.description == this.description &&
          other.attachmentIds == this.attachmentIds &&
          other.status == this.status &&
          other.businessId == this.businessId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.isDeleted == this.isDeleted);
}

class ExpenseTableCompanion extends UpdateCompanion<ExpenseTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> merchant;
  final Value<double> amount;
  final Value<String> categoryId;
  final Value<String> paymentMethodId;
  final Value<DateTime> occurredAt;
  final Value<String> description;
  final Value<String> attachmentIds;
  final Value<String> status;
  final Value<String> businessId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> createdBy;
  final Value<String> updatedBy;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const ExpenseTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.merchant = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.paymentMethodId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.description = const Value.absent(),
    this.attachmentIds = const Value.absent(),
    this.status = const Value.absent(),
    this.businessId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpenseTableCompanion.insert({
    required String id,
    required String companyId,
    required String merchant,
    required double amount,
    required String categoryId,
    required String paymentMethodId,
    required DateTime occurredAt,
    required String description,
    required String attachmentIds,
    required String status,
    required String businessId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,
    required bool isDeleted,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       merchant = Value(merchant),
       amount = Value(amount),
       categoryId = Value(categoryId),
       paymentMethodId = Value(paymentMethodId),
       occurredAt = Value(occurredAt),
       description = Value(description),
       attachmentIds = Value(attachmentIds),
       status = Value(status),
       businessId = Value(businessId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       createdBy = Value(createdBy),
       updatedBy = Value(updatedBy),
       isDeleted = Value(isDeleted);
  static Insertable<ExpenseTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? merchant,
    Expression<double>? amount,
    Expression<String>? categoryId,
    Expression<String>? paymentMethodId,
    Expression<DateTime>? occurredAt,
    Expression<String>? description,
    Expression<String>? attachmentIds,
    Expression<String>? status,
    Expression<String>? businessId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (merchant != null) 'merchant': merchant,
      if (amount != null) 'amount': amount,
      if (categoryId != null) 'category_id': categoryId,
      if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (description != null) 'description': description,
      if (attachmentIds != null) 'attachment_ids': attachmentIds,
      if (status != null) 'status': status,
      if (businessId != null) 'business_id': businessId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpenseTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? merchant,
    Value<double>? amount,
    Value<String>? categoryId,
    Value<String>? paymentMethodId,
    Value<DateTime>? occurredAt,
    Value<String>? description,
    Value<String>? attachmentIds,
    Value<String>? status,
    Value<String>? businessId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? createdBy,
    Value<String>? updatedBy,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return ExpenseTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      merchant: merchant ?? this.merchant,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      occurredAt: occurredAt ?? this.occurredAt,
      description: description ?? this.description,
      attachmentIds: attachmentIds ?? this.attachmentIds,
      status: status ?? this.status,
      businessId: businessId ?? this.businessId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (merchant.present) {
      map['merchant'] = Variable<String>(merchant.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (paymentMethodId.present) {
      map['payment_method_id'] = Variable<String>(paymentMethodId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (attachmentIds.present) {
      map['attachment_ids'] = Variable<String>(attachmentIds.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('merchant: $merchant, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('description: $description, ')
          ..write('attachmentIds: $attachmentIds, ')
          ..write('status: $status, ')
          ..write('businessId: $businessId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BankAccountTableTable extends BankAccountTable
    with TableInfo<$BankAccountTableTable, BankAccountTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankAccountTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountNumberMeta = const VerificationMeta(
    'accountNumber',
  );
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
    'account_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountTypeMeta = const VerificationMeta(
    'accountType',
  );
  @override
  late final GeneratedColumn<String> accountType = GeneratedColumn<String>(
    'account_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentBalanceMeta = const VerificationMeta(
    'currentBalance',
  );
  @override
  late final GeneratedColumn<double> currentBalance = GeneratedColumn<double>(
    'current_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    name,
    accountNumber,
    accountType,
    currency,
    currentBalance,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_account_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankAccountTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('account_number')) {
      context.handle(
        _accountNumberMeta,
        accountNumber.isAcceptableOrUnknown(
          data['account_number']!,
          _accountNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountNumberMeta);
    }
    if (data.containsKey('account_type')) {
      context.handle(
        _accountTypeMeta,
        accountType.isAcceptableOrUnknown(
          data['account_type']!,
          _accountTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountTypeMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('current_balance')) {
      context.handle(
        _currentBalanceMeta,
        currentBalance.isAcceptableOrUnknown(
          data['current_balance']!,
          _currentBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentBalanceMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankAccountTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankAccountTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      accountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_number'],
      )!,
      accountType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_type'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      currentBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_balance'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BankAccountTableTable createAlias(String alias) {
    return $BankAccountTableTable(attachedDatabase, alias);
  }
}

class BankAccountTableData extends DataClass
    implements Insertable<BankAccountTableData> {
  final String id;
  final String companyId;
  final String name;
  final String accountNumber;
  final String accountType;
  final String currency;
  final double currentBalance;
  final String status;
  final DateTime createdAt;
  const BankAccountTableData({
    required this.id,
    required this.companyId,
    required this.name,
    required this.accountNumber,
    required this.accountType,
    required this.currency,
    required this.currentBalance,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['name'] = Variable<String>(name);
    map['account_number'] = Variable<String>(accountNumber);
    map['account_type'] = Variable<String>(accountType);
    map['currency'] = Variable<String>(currency);
    map['current_balance'] = Variable<double>(currentBalance);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BankAccountTableCompanion toCompanion(bool nullToAbsent) {
    return BankAccountTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      name: Value(name),
      accountNumber: Value(accountNumber),
      accountType: Value(accountType),
      currency: Value(currency),
      currentBalance: Value(currentBalance),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory BankAccountTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankAccountTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      name: serializer.fromJson<String>(json['name']),
      accountNumber: serializer.fromJson<String>(json['accountNumber']),
      accountType: serializer.fromJson<String>(json['accountType']),
      currency: serializer.fromJson<String>(json['currency']),
      currentBalance: serializer.fromJson<double>(json['currentBalance']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'name': serializer.toJson<String>(name),
      'accountNumber': serializer.toJson<String>(accountNumber),
      'accountType': serializer.toJson<String>(accountType),
      'currency': serializer.toJson<String>(currency),
      'currentBalance': serializer.toJson<double>(currentBalance),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BankAccountTableData copyWith({
    String? id,
    String? companyId,
    String? name,
    String? accountNumber,
    String? accountType,
    String? currency,
    double? currentBalance,
    String? status,
    DateTime? createdAt,
  }) => BankAccountTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    name: name ?? this.name,
    accountNumber: accountNumber ?? this.accountNumber,
    accountType: accountType ?? this.accountType,
    currency: currency ?? this.currency,
    currentBalance: currentBalance ?? this.currentBalance,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  BankAccountTableData copyWithCompanion(BankAccountTableCompanion data) {
    return BankAccountTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      name: data.name.present ? data.name.value : this.name,
      accountNumber: data.accountNumber.present
          ? data.accountNumber.value
          : this.accountNumber,
      accountType: data.accountType.present
          ? data.accountType.value
          : this.accountType,
      currency: data.currency.present ? data.currency.value : this.currency,
      currentBalance: data.currentBalance.present
          ? data.currentBalance.value
          : this.currentBalance,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankAccountTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('name: $name, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('accountType: $accountType, ')
          ..write('currency: $currency, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    name,
    accountNumber,
    accountType,
    currency,
    currentBalance,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankAccountTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.name == this.name &&
          other.accountNumber == this.accountNumber &&
          other.accountType == this.accountType &&
          other.currency == this.currency &&
          other.currentBalance == this.currentBalance &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class BankAccountTableCompanion extends UpdateCompanion<BankAccountTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> name;
  final Value<String> accountNumber;
  final Value<String> accountType;
  final Value<String> currency;
  final Value<double> currentBalance;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BankAccountTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.name = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.accountType = const Value.absent(),
    this.currency = const Value.absent(),
    this.currentBalance = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BankAccountTableCompanion.insert({
    required String id,
    required String companyId,
    required String name,
    required String accountNumber,
    required String accountType,
    required String currency,
    required double currentBalance,
    required String status,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       name = Value(name),
       accountNumber = Value(accountNumber),
       accountType = Value(accountType),
       currency = Value(currency),
       currentBalance = Value(currentBalance),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<BankAccountTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? name,
    Expression<String>? accountNumber,
    Expression<String>? accountType,
    Expression<String>? currency,
    Expression<double>? currentBalance,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (name != null) 'name': name,
      if (accountNumber != null) 'account_number': accountNumber,
      if (accountType != null) 'account_type': accountType,
      if (currency != null) 'currency': currency,
      if (currentBalance != null) 'current_balance': currentBalance,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BankAccountTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? name,
    Value<String>? accountNumber,
    Value<String>? accountType,
    Value<String>? currency,
    Value<double>? currentBalance,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BankAccountTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
      accountType: accountType ?? this.accountType,
      currency: currency ?? this.currency,
      currentBalance: currentBalance ?? this.currentBalance,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<String>(accountType.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (currentBalance.present) {
      map['current_balance'] = Variable<double>(currentBalance.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankAccountTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('name: $name, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('accountType: $accountType, ')
          ..write('currency: $currency, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BankTransactionTableTable extends BankTransactionTable
    with TableInfo<$BankTransactionTableTable, BankTransactionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankTransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  @override
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _runningBalanceMeta = const VerificationMeta(
    'runningBalance',
  );
  @override
  late final GeneratedColumn<double> runningBalance = GeneratedColumn<double>(
    'running_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    accountId,
    date,
    amount,
    transactionType,
    reference,
    description,
    runningBalance,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_transaction_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankTransactionTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('running_balance')) {
      context.handle(
        _runningBalanceMeta,
        runningBalance.isAcceptableOrUnknown(
          data['running_balance']!,
          _runningBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_runningBalanceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankTransactionTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankTransactionTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      transactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_type'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      runningBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}running_balance'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BankTransactionTableTable createAlias(String alias) {
    return $BankTransactionTableTable(attachedDatabase, alias);
  }
}

class BankTransactionTableData extends DataClass
    implements Insertable<BankTransactionTableData> {
  final String id;
  final String companyId;
  final String accountId;
  final DateTime date;
  final double amount;
  final String transactionType;
  final String reference;
  final String description;
  final double runningBalance;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BankTransactionTableData({
    required this.id,
    required this.companyId,
    required this.accountId,
    required this.date,
    required this.amount,
    required this.transactionType,
    required this.reference,
    required this.description,
    required this.runningBalance,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['account_id'] = Variable<String>(accountId);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    map['transaction_type'] = Variable<String>(transactionType);
    map['reference'] = Variable<String>(reference);
    map['description'] = Variable<String>(description);
    map['running_balance'] = Variable<double>(runningBalance);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BankTransactionTableCompanion toCompanion(bool nullToAbsent) {
    return BankTransactionTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      accountId: Value(accountId),
      date: Value(date),
      amount: Value(amount),
      transactionType: Value(transactionType),
      reference: Value(reference),
      description: Value(description),
      runningBalance: Value(runningBalance),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BankTransactionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankTransactionTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      accountId: serializer.fromJson<String>(json['accountId']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      reference: serializer.fromJson<String>(json['reference']),
      description: serializer.fromJson<String>(json['description']),
      runningBalance: serializer.fromJson<double>(json['runningBalance']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'accountId': serializer.toJson<String>(accountId),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
      'transactionType': serializer.toJson<String>(transactionType),
      'reference': serializer.toJson<String>(reference),
      'description': serializer.toJson<String>(description),
      'runningBalance': serializer.toJson<double>(runningBalance),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BankTransactionTableData copyWith({
    String? id,
    String? companyId,
    String? accountId,
    DateTime? date,
    double? amount,
    String? transactionType,
    String? reference,
    String? description,
    double? runningBalance,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BankTransactionTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    accountId: accountId ?? this.accountId,
    date: date ?? this.date,
    amount: amount ?? this.amount,
    transactionType: transactionType ?? this.transactionType,
    reference: reference ?? this.reference,
    description: description ?? this.description,
    runningBalance: runningBalance ?? this.runningBalance,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BankTransactionTableData copyWithCompanion(
    BankTransactionTableCompanion data,
  ) {
    return BankTransactionTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      reference: data.reference.present ? data.reference.value : this.reference,
      description: data.description.present
          ? data.description.value
          : this.description,
      runningBalance: data.runningBalance.present
          ? data.runningBalance.value
          : this.runningBalance,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankTransactionTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('accountId: $accountId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('transactionType: $transactionType, ')
          ..write('reference: $reference, ')
          ..write('description: $description, ')
          ..write('runningBalance: $runningBalance, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    accountId,
    date,
    amount,
    transactionType,
    reference,
    description,
    runningBalance,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankTransactionTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.accountId == this.accountId &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.transactionType == this.transactionType &&
          other.reference == this.reference &&
          other.description == this.description &&
          other.runningBalance == this.runningBalance &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BankTransactionTableCompanion
    extends UpdateCompanion<BankTransactionTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> accountId;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<String> transactionType;
  final Value<String> reference;
  final Value<String> description;
  final Value<double> runningBalance;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BankTransactionTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.reference = const Value.absent(),
    this.description = const Value.absent(),
    this.runningBalance = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BankTransactionTableCompanion.insert({
    required String id,
    required String companyId,
    required String accountId,
    required DateTime date,
    required double amount,
    required String transactionType,
    required String reference,
    required String description,
    required double runningBalance,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       accountId = Value(accountId),
       date = Value(date),
       amount = Value(amount),
       transactionType = Value(transactionType),
       reference = Value(reference),
       description = Value(description),
       runningBalance = Value(runningBalance),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BankTransactionTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? accountId,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<String>? transactionType,
    Expression<String>? reference,
    Expression<String>? description,
    Expression<double>? runningBalance,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (accountId != null) 'account_id': accountId,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (transactionType != null) 'transaction_type': transactionType,
      if (reference != null) 'reference': reference,
      if (description != null) 'description': description,
      if (runningBalance != null) 'running_balance': runningBalance,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BankTransactionTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? accountId,
    Value<DateTime>? date,
    Value<double>? amount,
    Value<String>? transactionType,
    Value<String>? reference,
    Value<String>? description,
    Value<double>? runningBalance,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BankTransactionTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      accountId: accountId ?? this.accountId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      reference: reference ?? this.reference,
      description: description ?? this.description,
      runningBalance: runningBalance ?? this.runningBalance,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (runningBalance.present) {
      map['running_balance'] = Variable<double>(runningBalance.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankTransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('accountId: $accountId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('transactionType: $transactionType, ')
          ..write('reference: $reference, ')
          ..write('description: $description, ')
          ..write('runningBalance: $runningBalance, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BankStatementTableTable extends BankStatementTable
    with TableInfo<$BankStatementTableTable, BankStatementTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankStatementTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankAccountIdMeta = const VerificationMeta(
    'bankAccountId',
  );
  @override
  late final GeneratedColumn<String> bankAccountId = GeneratedColumn<String>(
    'bank_account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankAccountNameMeta = const VerificationMeta(
    'bankAccountName',
  );
  @override
  late final GeneratedColumn<String> bankAccountName = GeneratedColumn<String>(
    'bank_account_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodStartMeta = const VerificationMeta(
    'periodStart',
  );
  @override
  late final GeneratedColumn<DateTime> periodStart = GeneratedColumn<DateTime>(
    'period_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodEndMeta = const VerificationMeta(
    'periodEnd',
  );
  @override
  late final GeneratedColumn<DateTime> periodEnd = GeneratedColumn<DateTime>(
    'period_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingBalanceMeta = const VerificationMeta(
    'openingBalance',
  );
  @override
  late final GeneratedColumn<double> openingBalance = GeneratedColumn<double>(
    'opening_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _closingBalanceMeta = const VerificationMeta(
    'closingBalance',
  );
  @override
  late final GeneratedColumn<double> closingBalance = GeneratedColumn<double>(
    'closing_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reconciledAtMeta = const VerificationMeta(
    'reconciledAt',
  );
  @override
  late final GeneratedColumn<DateTime> reconciledAt = GeneratedColumn<DateTime>(
    'reconciled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    bankAccountId,
    bankAccountName,
    periodStart,
    periodEnd,
    openingBalance,
    closingBalance,
    status,
    importedAt,
    reconciledAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_statement_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankStatementTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('bank_account_id')) {
      context.handle(
        _bankAccountIdMeta,
        bankAccountId.isAcceptableOrUnknown(
          data['bank_account_id']!,
          _bankAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bankAccountIdMeta);
    }
    if (data.containsKey('bank_account_name')) {
      context.handle(
        _bankAccountNameMeta,
        bankAccountName.isAcceptableOrUnknown(
          data['bank_account_name']!,
          _bankAccountNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bankAccountNameMeta);
    }
    if (data.containsKey('period_start')) {
      context.handle(
        _periodStartMeta,
        periodStart.isAcceptableOrUnknown(
          data['period_start']!,
          _periodStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_periodStartMeta);
    }
    if (data.containsKey('period_end')) {
      context.handle(
        _periodEndMeta,
        periodEnd.isAcceptableOrUnknown(data['period_end']!, _periodEndMeta),
      );
    } else if (isInserting) {
      context.missing(_periodEndMeta);
    }
    if (data.containsKey('opening_balance')) {
      context.handle(
        _openingBalanceMeta,
        openingBalance.isAcceptableOrUnknown(
          data['opening_balance']!,
          _openingBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingBalanceMeta);
    }
    if (data.containsKey('closing_balance')) {
      context.handle(
        _closingBalanceMeta,
        closingBalance.isAcceptableOrUnknown(
          data['closing_balance']!,
          _closingBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_closingBalanceMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    if (data.containsKey('reconciled_at')) {
      context.handle(
        _reconciledAtMeta,
        reconciledAt.isAcceptableOrUnknown(
          data['reconciled_at']!,
          _reconciledAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankStatementTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankStatementTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      bankAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_account_id'],
      )!,
      bankAccountName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_account_name'],
      )!,
      periodStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_start'],
      )!,
      periodEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_end'],
      )!,
      openingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}opening_balance'],
      )!,
      closingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}closing_balance'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
      reconciledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reconciled_at'],
      ),
    );
  }

  @override
  $BankStatementTableTable createAlias(String alias) {
    return $BankStatementTableTable(attachedDatabase, alias);
  }
}

class BankStatementTableData extends DataClass
    implements Insertable<BankStatementTableData> {
  final String id;
  final String companyId;
  final String bankAccountId;
  final String bankAccountName;
  final DateTime periodStart;
  final DateTime periodEnd;
  final double openingBalance;
  final double closingBalance;
  final String status;
  final DateTime importedAt;
  final DateTime? reconciledAt;
  const BankStatementTableData({
    required this.id,
    required this.companyId,
    required this.bankAccountId,
    required this.bankAccountName,
    required this.periodStart,
    required this.periodEnd,
    required this.openingBalance,
    required this.closingBalance,
    required this.status,
    required this.importedAt,
    this.reconciledAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['bank_account_id'] = Variable<String>(bankAccountId);
    map['bank_account_name'] = Variable<String>(bankAccountName);
    map['period_start'] = Variable<DateTime>(periodStart);
    map['period_end'] = Variable<DateTime>(periodEnd);
    map['opening_balance'] = Variable<double>(openingBalance);
    map['closing_balance'] = Variable<double>(closingBalance);
    map['status'] = Variable<String>(status);
    map['imported_at'] = Variable<DateTime>(importedAt);
    if (!nullToAbsent || reconciledAt != null) {
      map['reconciled_at'] = Variable<DateTime>(reconciledAt);
    }
    return map;
  }

  BankStatementTableCompanion toCompanion(bool nullToAbsent) {
    return BankStatementTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      bankAccountId: Value(bankAccountId),
      bankAccountName: Value(bankAccountName),
      periodStart: Value(periodStart),
      periodEnd: Value(periodEnd),
      openingBalance: Value(openingBalance),
      closingBalance: Value(closingBalance),
      status: Value(status),
      importedAt: Value(importedAt),
      reconciledAt: reconciledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(reconciledAt),
    );
  }

  factory BankStatementTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankStatementTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      bankAccountId: serializer.fromJson<String>(json['bankAccountId']),
      bankAccountName: serializer.fromJson<String>(json['bankAccountName']),
      periodStart: serializer.fromJson<DateTime>(json['periodStart']),
      periodEnd: serializer.fromJson<DateTime>(json['periodEnd']),
      openingBalance: serializer.fromJson<double>(json['openingBalance']),
      closingBalance: serializer.fromJson<double>(json['closingBalance']),
      status: serializer.fromJson<String>(json['status']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      reconciledAt: serializer.fromJson<DateTime?>(json['reconciledAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'bankAccountId': serializer.toJson<String>(bankAccountId),
      'bankAccountName': serializer.toJson<String>(bankAccountName),
      'periodStart': serializer.toJson<DateTime>(periodStart),
      'periodEnd': serializer.toJson<DateTime>(periodEnd),
      'openingBalance': serializer.toJson<double>(openingBalance),
      'closingBalance': serializer.toJson<double>(closingBalance),
      'status': serializer.toJson<String>(status),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'reconciledAt': serializer.toJson<DateTime?>(reconciledAt),
    };
  }

  BankStatementTableData copyWith({
    String? id,
    String? companyId,
    String? bankAccountId,
    String? bankAccountName,
    DateTime? periodStart,
    DateTime? periodEnd,
    double? openingBalance,
    double? closingBalance,
    String? status,
    DateTime? importedAt,
    Value<DateTime?> reconciledAt = const Value.absent(),
  }) => BankStatementTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    bankAccountId: bankAccountId ?? this.bankAccountId,
    bankAccountName: bankAccountName ?? this.bankAccountName,
    periodStart: periodStart ?? this.periodStart,
    periodEnd: periodEnd ?? this.periodEnd,
    openingBalance: openingBalance ?? this.openingBalance,
    closingBalance: closingBalance ?? this.closingBalance,
    status: status ?? this.status,
    importedAt: importedAt ?? this.importedAt,
    reconciledAt: reconciledAt.present ? reconciledAt.value : this.reconciledAt,
  );
  BankStatementTableData copyWithCompanion(BankStatementTableCompanion data) {
    return BankStatementTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      bankAccountId: data.bankAccountId.present
          ? data.bankAccountId.value
          : this.bankAccountId,
      bankAccountName: data.bankAccountName.present
          ? data.bankAccountName.value
          : this.bankAccountName,
      periodStart: data.periodStart.present
          ? data.periodStart.value
          : this.periodStart,
      periodEnd: data.periodEnd.present ? data.periodEnd.value : this.periodEnd,
      openingBalance: data.openingBalance.present
          ? data.openingBalance.value
          : this.openingBalance,
      closingBalance: data.closingBalance.present
          ? data.closingBalance.value
          : this.closingBalance,
      status: data.status.present ? data.status.value : this.status,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      reconciledAt: data.reconciledAt.present
          ? data.reconciledAt.value
          : this.reconciledAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankStatementTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('bankAccountId: $bankAccountId, ')
          ..write('bankAccountName: $bankAccountName, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('closingBalance: $closingBalance, ')
          ..write('status: $status, ')
          ..write('importedAt: $importedAt, ')
          ..write('reconciledAt: $reconciledAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    bankAccountId,
    bankAccountName,
    periodStart,
    periodEnd,
    openingBalance,
    closingBalance,
    status,
    importedAt,
    reconciledAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankStatementTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.bankAccountId == this.bankAccountId &&
          other.bankAccountName == this.bankAccountName &&
          other.periodStart == this.periodStart &&
          other.periodEnd == this.periodEnd &&
          other.openingBalance == this.openingBalance &&
          other.closingBalance == this.closingBalance &&
          other.status == this.status &&
          other.importedAt == this.importedAt &&
          other.reconciledAt == this.reconciledAt);
}

class BankStatementTableCompanion
    extends UpdateCompanion<BankStatementTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> bankAccountId;
  final Value<String> bankAccountName;
  final Value<DateTime> periodStart;
  final Value<DateTime> periodEnd;
  final Value<double> openingBalance;
  final Value<double> closingBalance;
  final Value<String> status;
  final Value<DateTime> importedAt;
  final Value<DateTime?> reconciledAt;
  final Value<int> rowid;
  const BankStatementTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.bankAccountId = const Value.absent(),
    this.bankAccountName = const Value.absent(),
    this.periodStart = const Value.absent(),
    this.periodEnd = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.closingBalance = const Value.absent(),
    this.status = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.reconciledAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BankStatementTableCompanion.insert({
    required String id,
    required String companyId,
    required String bankAccountId,
    required String bankAccountName,
    required DateTime periodStart,
    required DateTime periodEnd,
    required double openingBalance,
    required double closingBalance,
    required String status,
    required DateTime importedAt,
    this.reconciledAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       bankAccountId = Value(bankAccountId),
       bankAccountName = Value(bankAccountName),
       periodStart = Value(periodStart),
       periodEnd = Value(periodEnd),
       openingBalance = Value(openingBalance),
       closingBalance = Value(closingBalance),
       status = Value(status),
       importedAt = Value(importedAt);
  static Insertable<BankStatementTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? bankAccountId,
    Expression<String>? bankAccountName,
    Expression<DateTime>? periodStart,
    Expression<DateTime>? periodEnd,
    Expression<double>? openingBalance,
    Expression<double>? closingBalance,
    Expression<String>? status,
    Expression<DateTime>? importedAt,
    Expression<DateTime>? reconciledAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (bankAccountId != null) 'bank_account_id': bankAccountId,
      if (bankAccountName != null) 'bank_account_name': bankAccountName,
      if (periodStart != null) 'period_start': periodStart,
      if (periodEnd != null) 'period_end': periodEnd,
      if (openingBalance != null) 'opening_balance': openingBalance,
      if (closingBalance != null) 'closing_balance': closingBalance,
      if (status != null) 'status': status,
      if (importedAt != null) 'imported_at': importedAt,
      if (reconciledAt != null) 'reconciled_at': reconciledAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BankStatementTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? bankAccountId,
    Value<String>? bankAccountName,
    Value<DateTime>? periodStart,
    Value<DateTime>? periodEnd,
    Value<double>? openingBalance,
    Value<double>? closingBalance,
    Value<String>? status,
    Value<DateTime>? importedAt,
    Value<DateTime?>? reconciledAt,
    Value<int>? rowid,
  }) {
    return BankStatementTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      bankAccountId: bankAccountId ?? this.bankAccountId,
      bankAccountName: bankAccountName ?? this.bankAccountName,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      openingBalance: openingBalance ?? this.openingBalance,
      closingBalance: closingBalance ?? this.closingBalance,
      status: status ?? this.status,
      importedAt: importedAt ?? this.importedAt,
      reconciledAt: reconciledAt ?? this.reconciledAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (bankAccountId.present) {
      map['bank_account_id'] = Variable<String>(bankAccountId.value);
    }
    if (bankAccountName.present) {
      map['bank_account_name'] = Variable<String>(bankAccountName.value);
    }
    if (periodStart.present) {
      map['period_start'] = Variable<DateTime>(periodStart.value);
    }
    if (periodEnd.present) {
      map['period_end'] = Variable<DateTime>(periodEnd.value);
    }
    if (openingBalance.present) {
      map['opening_balance'] = Variable<double>(openingBalance.value);
    }
    if (closingBalance.present) {
      map['closing_balance'] = Variable<double>(closingBalance.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (reconciledAt.present) {
      map['reconciled_at'] = Variable<DateTime>(reconciledAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankStatementTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('bankAccountId: $bankAccountId, ')
          ..write('bankAccountName: $bankAccountName, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('closingBalance: $closingBalance, ')
          ..write('status: $status, ')
          ..write('importedAt: $importedAt, ')
          ..write('reconciledAt: $reconciledAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BankStatementTransactionTableTable extends BankStatementTransactionTable
    with
        TableInfo<
          $BankStatementTransactionTableTable,
          BankStatementTransactionTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankStatementTransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statementIdMeta = const VerificationMeta(
    'statementId',
  );
  @override
  late final GeneratedColumn<String> statementId = GeneratedColumn<String>(
    'statement_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isMatchedMeta = const VerificationMeta(
    'isMatched',
  );
  @override
  late final GeneratedColumn<bool> isMatched = GeneratedColumn<bool>(
    'is_matched',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_matched" IN (0, 1))',
    ),
  );
  static const VerificationMeta _matchedErpEntryIdMeta = const VerificationMeta(
    'matchedErpEntryId',
  );
  @override
  late final GeneratedColumn<String> matchedErpEntryId =
      GeneratedColumn<String>(
        'matched_erp_entry_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    statementId,
    date,
    amount,
    description,
    reference,
    isMatched,
    matchedErpEntryId,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_statement_transaction_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankStatementTransactionTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('statement_id')) {
      context.handle(
        _statementIdMeta,
        statementId.isAcceptableOrUnknown(
          data['statement_id']!,
          _statementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statementIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('is_matched')) {
      context.handle(
        _isMatchedMeta,
        isMatched.isAcceptableOrUnknown(data['is_matched']!, _isMatchedMeta),
      );
    } else if (isInserting) {
      context.missing(_isMatchedMeta);
    }
    if (data.containsKey('matched_erp_entry_id')) {
      context.handle(
        _matchedErpEntryIdMeta,
        matchedErpEntryId.isAcceptableOrUnknown(
          data['matched_erp_entry_id']!,
          _matchedErpEntryIdMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankStatementTransactionTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankStatementTransactionTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      statementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statement_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      isMatched: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_matched'],
      )!,
      matchedErpEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matched_erp_entry_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $BankStatementTransactionTableTable createAlias(String alias) {
    return $BankStatementTransactionTableTable(attachedDatabase, alias);
  }
}

class BankStatementTransactionTableData extends DataClass
    implements Insertable<BankStatementTransactionTableData> {
  final String id;
  final String companyId;
  final String statementId;
  final DateTime date;
  final double amount;
  final String description;
  final String reference;
  final bool isMatched;
  final String? matchedErpEntryId;
  final String? notes;
  const BankStatementTransactionTableData({
    required this.id,
    required this.companyId,
    required this.statementId,
    required this.date,
    required this.amount,
    required this.description,
    required this.reference,
    required this.isMatched,
    this.matchedErpEntryId,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['company_id'] = Variable<String>(companyId);
    map['statement_id'] = Variable<String>(statementId);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    map['reference'] = Variable<String>(reference);
    map['is_matched'] = Variable<bool>(isMatched);
    if (!nullToAbsent || matchedErpEntryId != null) {
      map['matched_erp_entry_id'] = Variable<String>(matchedErpEntryId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  BankStatementTransactionTableCompanion toCompanion(bool nullToAbsent) {
    return BankStatementTransactionTableCompanion(
      id: Value(id),
      companyId: Value(companyId),
      statementId: Value(statementId),
      date: Value(date),
      amount: Value(amount),
      description: Value(description),
      reference: Value(reference),
      isMatched: Value(isMatched),
      matchedErpEntryId: matchedErpEntryId == null && nullToAbsent
          ? const Value.absent()
          : Value(matchedErpEntryId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory BankStatementTransactionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankStatementTransactionTableData(
      id: serializer.fromJson<String>(json['id']),
      companyId: serializer.fromJson<String>(json['companyId']),
      statementId: serializer.fromJson<String>(json['statementId']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      reference: serializer.fromJson<String>(json['reference']),
      isMatched: serializer.fromJson<bool>(json['isMatched']),
      matchedErpEntryId: serializer.fromJson<String?>(
        json['matchedErpEntryId'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'companyId': serializer.toJson<String>(companyId),
      'statementId': serializer.toJson<String>(statementId),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'reference': serializer.toJson<String>(reference),
      'isMatched': serializer.toJson<bool>(isMatched),
      'matchedErpEntryId': serializer.toJson<String?>(matchedErpEntryId),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  BankStatementTransactionTableData copyWith({
    String? id,
    String? companyId,
    String? statementId,
    DateTime? date,
    double? amount,
    String? description,
    String? reference,
    bool? isMatched,
    Value<String?> matchedErpEntryId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => BankStatementTransactionTableData(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    statementId: statementId ?? this.statementId,
    date: date ?? this.date,
    amount: amount ?? this.amount,
    description: description ?? this.description,
    reference: reference ?? this.reference,
    isMatched: isMatched ?? this.isMatched,
    matchedErpEntryId: matchedErpEntryId.present
        ? matchedErpEntryId.value
        : this.matchedErpEntryId,
    notes: notes.present ? notes.value : this.notes,
  );
  BankStatementTransactionTableData copyWithCompanion(
    BankStatementTransactionTableCompanion data,
  ) {
    return BankStatementTransactionTableData(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      statementId: data.statementId.present
          ? data.statementId.value
          : this.statementId,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      description: data.description.present
          ? data.description.value
          : this.description,
      reference: data.reference.present ? data.reference.value : this.reference,
      isMatched: data.isMatched.present ? data.isMatched.value : this.isMatched,
      matchedErpEntryId: data.matchedErpEntryId.present
          ? data.matchedErpEntryId.value
          : this.matchedErpEntryId,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankStatementTransactionTableData(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('statementId: $statementId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('reference: $reference, ')
          ..write('isMatched: $isMatched, ')
          ..write('matchedErpEntryId: $matchedErpEntryId, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyId,
    statementId,
    date,
    amount,
    description,
    reference,
    isMatched,
    matchedErpEntryId,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankStatementTransactionTableData &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.statementId == this.statementId &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.reference == this.reference &&
          other.isMatched == this.isMatched &&
          other.matchedErpEntryId == this.matchedErpEntryId &&
          other.notes == this.notes);
}

class BankStatementTransactionTableCompanion
    extends UpdateCompanion<BankStatementTransactionTableData> {
  final Value<String> id;
  final Value<String> companyId;
  final Value<String> statementId;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<String> description;
  final Value<String> reference;
  final Value<bool> isMatched;
  final Value<String?> matchedErpEntryId;
  final Value<String?> notes;
  final Value<int> rowid;
  const BankStatementTransactionTableCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.statementId = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.reference = const Value.absent(),
    this.isMatched = const Value.absent(),
    this.matchedErpEntryId = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BankStatementTransactionTableCompanion.insert({
    required String id,
    required String companyId,
    required String statementId,
    required DateTime date,
    required double amount,
    required String description,
    required String reference,
    required bool isMatched,
    this.matchedErpEntryId = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       companyId = Value(companyId),
       statementId = Value(statementId),
       date = Value(date),
       amount = Value(amount),
       description = Value(description),
       reference = Value(reference),
       isMatched = Value(isMatched);
  static Insertable<BankStatementTransactionTableData> custom({
    Expression<String>? id,
    Expression<String>? companyId,
    Expression<String>? statementId,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<String>? reference,
    Expression<bool>? isMatched,
    Expression<String>? matchedErpEntryId,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (statementId != null) 'statement_id': statementId,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (reference != null) 'reference': reference,
      if (isMatched != null) 'is_matched': isMatched,
      if (matchedErpEntryId != null) 'matched_erp_entry_id': matchedErpEntryId,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BankStatementTransactionTableCompanion copyWith({
    Value<String>? id,
    Value<String>? companyId,
    Value<String>? statementId,
    Value<DateTime>? date,
    Value<double>? amount,
    Value<String>? description,
    Value<String>? reference,
    Value<bool>? isMatched,
    Value<String?>? matchedErpEntryId,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return BankStatementTransactionTableCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      statementId: statementId ?? this.statementId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      reference: reference ?? this.reference,
      isMatched: isMatched ?? this.isMatched,
      matchedErpEntryId: matchedErpEntryId ?? this.matchedErpEntryId,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (statementId.present) {
      map['statement_id'] = Variable<String>(statementId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (isMatched.present) {
      map['is_matched'] = Variable<bool>(isMatched.value);
    }
    if (matchedErpEntryId.present) {
      map['matched_erp_entry_id'] = Variable<String>(matchedErpEntryId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankStatementTransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('statementId: $statementId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('reference: $reference, ')
          ..write('isMatched: $isMatched, ')
          ..write('matchedErpEntryId: $matchedErpEntryId, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CustomersTableTable customersTable = $CustomersTableTable(this);
  late final $VendorsTableTable vendorsTable = $VendorsTableTable(this);
  late final $ProductsTableTable productsTable = $ProductsTableTable(this);
  late final $SalesInvoiceTableTable salesInvoiceTable =
      $SalesInvoiceTableTable(this);
  late final $SalesInvoiceLineTableTable salesInvoiceLineTable =
      $SalesInvoiceLineTableTable(this);
  late final $VendorBillTableTable vendorBillTable = $VendorBillTableTable(
    this,
  );
  late final $VendorBillLineTableTable vendorBillLineTable =
      $VendorBillLineTableTable(this);
  late final $PurchaseOrderTableTable purchaseOrderTable =
      $PurchaseOrderTableTable(this);
  late final $PurchaseOrderLineTableTable purchaseOrderLineTable =
      $PurchaseOrderLineTableTable(this);
  late final $ExpenseTableTable expenseTable = $ExpenseTableTable(this);
  late final $BankAccountTableTable bankAccountTable = $BankAccountTableTable(
    this,
  );
  late final $BankTransactionTableTable bankTransactionTable =
      $BankTransactionTableTable(this);
  late final $BankStatementTableTable bankStatementTable =
      $BankStatementTableTable(this);
  late final $BankStatementTransactionTableTable bankStatementTransactionTable =
      $BankStatementTransactionTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    customersTable,
    vendorsTable,
    productsTable,
    salesInvoiceTable,
    salesInvoiceLineTable,
    vendorBillTable,
    vendorBillLineTable,
    purchaseOrderTable,
    purchaseOrderLineTable,
    expenseTable,
    bankAccountTable,
    bankTransactionTable,
    bankStatementTable,
    bankStatementTransactionTable,
  ];
}

typedef $$CustomersTableTableCreateCompanionBuilder =
    CustomersTableCompanion Function({
      required String id,
      required String companyId,
      required String name,
      required String company,
      required String email,
      required String phone,
      required double outstandingBalance,
      required String status,
      required String notes,
      Value<int> rowid,
    });
typedef $$CustomersTableTableUpdateCompanionBuilder =
    CustomersTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> name,
      Value<String> company,
      Value<String> email,
      Value<String> phone,
      Value<double> outstandingBalance,
      Value<String> status,
      Value<String> notes,
      Value<int> rowid,
    });

class $$CustomersTableTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get company => $composableBuilder(
    column: $table.company,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get outstandingBalance => $composableBuilder(
    column: $table.outstandingBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get company => $composableBuilder(
    column: $table.company,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get outstandingBalance => $composableBuilder(
    column: $table.outstandingBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get company =>
      $composableBuilder(column: $table.company, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<double> get outstandingBalance => $composableBuilder(
    column: $table.outstandingBalance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$CustomersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTableTable,
          CustomersTableData,
          $$CustomersTableTableFilterComposer,
          $$CustomersTableTableOrderingComposer,
          $$CustomersTableTableAnnotationComposer,
          $$CustomersTableTableCreateCompanionBuilder,
          $$CustomersTableTableUpdateCompanionBuilder,
          (
            CustomersTableData,
            BaseReferences<
              _$AppDatabase,
              $CustomersTableTable,
              CustomersTableData
            >,
          ),
          CustomersTableData,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableTableManager(
    _$AppDatabase db,
    $CustomersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> company = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<double> outstandingBalance = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersTableCompanion(
                id: id,
                companyId: companyId,
                name: name,
                company: company,
                email: email,
                phone: phone,
                outstandingBalance: outstandingBalance,
                status: status,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String name,
                required String company,
                required String email,
                required String phone,
                required double outstandingBalance,
                required String status,
                required String notes,
                Value<int> rowid = const Value.absent(),
              }) => CustomersTableCompanion.insert(
                id: id,
                companyId: companyId,
                name: name,
                company: company,
                email: email,
                phone: phone,
                outstandingBalance: outstandingBalance,
                status: status,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTableTable,
      CustomersTableData,
      $$CustomersTableTableFilterComposer,
      $$CustomersTableTableOrderingComposer,
      $$CustomersTableTableAnnotationComposer,
      $$CustomersTableTableCreateCompanionBuilder,
      $$CustomersTableTableUpdateCompanionBuilder,
      (
        CustomersTableData,
        BaseReferences<_$AppDatabase, $CustomersTableTable, CustomersTableData>,
      ),
      CustomersTableData,
      PrefetchHooks Function()
    >;
typedef $$VendorsTableTableCreateCompanionBuilder =
    VendorsTableCompanion Function({
      required String id,
      required String companyId,
      required String companyName,
      required String contactName,
      required String email,
      required String phone,
      required String address,
      required String taxIdentifier,
      required String notes,
      required bool isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$VendorsTableTableUpdateCompanionBuilder =
    VendorsTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> companyName,
      Value<String> contactName,
      Value<String> email,
      Value<String> phone,
      Value<String> address,
      Value<String> taxIdentifier,
      Value<String> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$VendorsTableTableFilterComposer
    extends Composer<_$AppDatabase, $VendorsTableTable> {
  $$VendorsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxIdentifier => $composableBuilder(
    column: $table.taxIdentifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VendorsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VendorsTableTable> {
  $$VendorsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxIdentifier => $composableBuilder(
    column: $table.taxIdentifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VendorsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VendorsTableTable> {
  $$VendorsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get taxIdentifier => $composableBuilder(
    column: $table.taxIdentifier,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$VendorsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VendorsTableTable,
          VendorsTableData,
          $$VendorsTableTableFilterComposer,
          $$VendorsTableTableOrderingComposer,
          $$VendorsTableTableAnnotationComposer,
          $$VendorsTableTableCreateCompanionBuilder,
          $$VendorsTableTableUpdateCompanionBuilder,
          (
            VendorsTableData,
            BaseReferences<_$AppDatabase, $VendorsTableTable, VendorsTableData>,
          ),
          VendorsTableData,
          PrefetchHooks Function()
        > {
  $$VendorsTableTableTableManager(_$AppDatabase db, $VendorsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VendorsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VendorsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VendorsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> companyName = const Value.absent(),
                Value<String> contactName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> taxIdentifier = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VendorsTableCompanion(
                id: id,
                companyId: companyId,
                companyName: companyName,
                contactName: contactName,
                email: email,
                phone: phone,
                address: address,
                taxIdentifier: taxIdentifier,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String companyName,
                required String contactName,
                required String email,
                required String phone,
                required String address,
                required String taxIdentifier,
                required String notes,
                required bool isActive,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => VendorsTableCompanion.insert(
                id: id,
                companyId: companyId,
                companyName: companyName,
                contactName: contactName,
                email: email,
                phone: phone,
                address: address,
                taxIdentifier: taxIdentifier,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VendorsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VendorsTableTable,
      VendorsTableData,
      $$VendorsTableTableFilterComposer,
      $$VendorsTableTableOrderingComposer,
      $$VendorsTableTableAnnotationComposer,
      $$VendorsTableTableCreateCompanionBuilder,
      $$VendorsTableTableUpdateCompanionBuilder,
      (
        VendorsTableData,
        BaseReferences<_$AppDatabase, $VendorsTableTable, VendorsTableData>,
      ),
      VendorsTableData,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableTableCreateCompanionBuilder =
    ProductsTableCompanion Function({
      required String id,
      required String companyId,
      required String sku,
      required String name,
      required String description,
      required String categoryId,
      required String unitId,
      required double price,
      required double stockOnHand,
      required bool active,
      Value<int> rowid,
    });
typedef $$ProductsTableTableUpdateCompanionBuilder =
    ProductsTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> sku,
      Value<String> name,
      Value<String> description,
      Value<String> categoryId,
      Value<String> unitId,
      Value<double> price,
      Value<double> stockOnHand,
      Value<bool> active,
      Value<int> rowid,
    });

class $$ProductsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockOnHand => $composableBuilder(
    column: $table.stockOnHand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockOnHand => $composableBuilder(
    column: $table.stockOnHand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get stockOnHand => $composableBuilder(
    column: $table.stockOnHand,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$ProductsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTableTable,
          ProductsTableData,
          $$ProductsTableTableFilterComposer,
          $$ProductsTableTableOrderingComposer,
          $$ProductsTableTableAnnotationComposer,
          $$ProductsTableTableCreateCompanionBuilder,
          $$ProductsTableTableUpdateCompanionBuilder,
          (
            ProductsTableData,
            BaseReferences<
              _$AppDatabase,
              $ProductsTableTable,
              ProductsTableData
            >,
          ),
          ProductsTableData,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableTableManager(_$AppDatabase db, $ProductsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> sku = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> unitId = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double> stockOnHand = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsTableCompanion(
                id: id,
                companyId: companyId,
                sku: sku,
                name: name,
                description: description,
                categoryId: categoryId,
                unitId: unitId,
                price: price,
                stockOnHand: stockOnHand,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String sku,
                required String name,
                required String description,
                required String categoryId,
                required String unitId,
                required double price,
                required double stockOnHand,
                required bool active,
                Value<int> rowid = const Value.absent(),
              }) => ProductsTableCompanion.insert(
                id: id,
                companyId: companyId,
                sku: sku,
                name: name,
                description: description,
                categoryId: categoryId,
                unitId: unitId,
                price: price,
                stockOnHand: stockOnHand,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTableTable,
      ProductsTableData,
      $$ProductsTableTableFilterComposer,
      $$ProductsTableTableOrderingComposer,
      $$ProductsTableTableAnnotationComposer,
      $$ProductsTableTableCreateCompanionBuilder,
      $$ProductsTableTableUpdateCompanionBuilder,
      (
        ProductsTableData,
        BaseReferences<_$AppDatabase, $ProductsTableTable, ProductsTableData>,
      ),
      ProductsTableData,
      PrefetchHooks Function()
    >;
typedef $$SalesInvoiceTableTableCreateCompanionBuilder =
    SalesInvoiceTableCompanion Function({
      required String id,
      required String companyId,
      required String customerId,
      required String customerName,
      required String reference,
      required String title,
      required String notes,
      required DateTime invoiceDate,
      required DateTime dueDate,
      required String statusId,
      required String statusLabel,
      required String statusColor,
      required double subtotal,
      required double tax,
      required double total,
      Value<int> rowid,
    });
typedef $$SalesInvoiceTableTableUpdateCompanionBuilder =
    SalesInvoiceTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> customerId,
      Value<String> customerName,
      Value<String> reference,
      Value<String> title,
      Value<String> notes,
      Value<DateTime> invoiceDate,
      Value<DateTime> dueDate,
      Value<String> statusId,
      Value<String> statusLabel,
      Value<String> statusColor,
      Value<double> subtotal,
      Value<double> tax,
      Value<double> total,
      Value<int> rowid,
    });

class $$SalesInvoiceTableTableFilterComposer
    extends Composer<_$AppDatabase, $SalesInvoiceTableTable> {
  $$SalesInvoiceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusId => $composableBuilder(
    column: $table.statusId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusColor => $composableBuilder(
    column: $table.statusColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesInvoiceTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesInvoiceTableTable> {
  $$SalesInvoiceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusId => $composableBuilder(
    column: $table.statusId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusColor => $composableBuilder(
    column: $table.statusColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesInvoiceTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesInvoiceTableTable> {
  $$SalesInvoiceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get statusId =>
      $composableBuilder(column: $table.statusId, builder: (column) => column);

  GeneratedColumn<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statusColor => $composableBuilder(
    column: $table.statusColor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);
}

class $$SalesInvoiceTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesInvoiceTableTable,
          SalesInvoiceTableData,
          $$SalesInvoiceTableTableFilterComposer,
          $$SalesInvoiceTableTableOrderingComposer,
          $$SalesInvoiceTableTableAnnotationComposer,
          $$SalesInvoiceTableTableCreateCompanionBuilder,
          $$SalesInvoiceTableTableUpdateCompanionBuilder,
          (
            SalesInvoiceTableData,
            BaseReferences<
              _$AppDatabase,
              $SalesInvoiceTableTable,
              SalesInvoiceTableData
            >,
          ),
          SalesInvoiceTableData,
          PrefetchHooks Function()
        > {
  $$SalesInvoiceTableTableTableManager(
    _$AppDatabase db,
    $SalesInvoiceTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesInvoiceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesInvoiceTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesInvoiceTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> invoiceDate = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<String> statusId = const Value.absent(),
                Value<String> statusLabel = const Value.absent(),
                Value<String> statusColor = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> tax = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoiceTableCompanion(
                id: id,
                companyId: companyId,
                customerId: customerId,
                customerName: customerName,
                reference: reference,
                title: title,
                notes: notes,
                invoiceDate: invoiceDate,
                dueDate: dueDate,
                statusId: statusId,
                statusLabel: statusLabel,
                statusColor: statusColor,
                subtotal: subtotal,
                tax: tax,
                total: total,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String customerId,
                required String customerName,
                required String reference,
                required String title,
                required String notes,
                required DateTime invoiceDate,
                required DateTime dueDate,
                required String statusId,
                required String statusLabel,
                required String statusColor,
                required double subtotal,
                required double tax,
                required double total,
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoiceTableCompanion.insert(
                id: id,
                companyId: companyId,
                customerId: customerId,
                customerName: customerName,
                reference: reference,
                title: title,
                notes: notes,
                invoiceDate: invoiceDate,
                dueDate: dueDate,
                statusId: statusId,
                statusLabel: statusLabel,
                statusColor: statusColor,
                subtotal: subtotal,
                tax: tax,
                total: total,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesInvoiceTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesInvoiceTableTable,
      SalesInvoiceTableData,
      $$SalesInvoiceTableTableFilterComposer,
      $$SalesInvoiceTableTableOrderingComposer,
      $$SalesInvoiceTableTableAnnotationComposer,
      $$SalesInvoiceTableTableCreateCompanionBuilder,
      $$SalesInvoiceTableTableUpdateCompanionBuilder,
      (
        SalesInvoiceTableData,
        BaseReferences<
          _$AppDatabase,
          $SalesInvoiceTableTable,
          SalesInvoiceTableData
        >,
      ),
      SalesInvoiceTableData,
      PrefetchHooks Function()
    >;
typedef $$SalesInvoiceLineTableTableCreateCompanionBuilder =
    SalesInvoiceLineTableCompanion Function({
      required String id,
      required String companyId,
      required String invoiceId,
      required String description,
      required double quantity,
      required double unitPrice,
      Value<int> rowid,
    });
typedef $$SalesInvoiceLineTableTableUpdateCompanionBuilder =
    SalesInvoiceLineTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> invoiceId,
      Value<String> description,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<int> rowid,
    });

class $$SalesInvoiceLineTableTableFilterComposer
    extends Composer<_$AppDatabase, $SalesInvoiceLineTableTable> {
  $$SalesInvoiceLineTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesInvoiceLineTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesInvoiceLineTableTable> {
  $$SalesInvoiceLineTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesInvoiceLineTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesInvoiceLineTableTable> {
  $$SalesInvoiceLineTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);
}

class $$SalesInvoiceLineTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesInvoiceLineTableTable,
          SalesInvoiceLineTableData,
          $$SalesInvoiceLineTableTableFilterComposer,
          $$SalesInvoiceLineTableTableOrderingComposer,
          $$SalesInvoiceLineTableTableAnnotationComposer,
          $$SalesInvoiceLineTableTableCreateCompanionBuilder,
          $$SalesInvoiceLineTableTableUpdateCompanionBuilder,
          (
            SalesInvoiceLineTableData,
            BaseReferences<
              _$AppDatabase,
              $SalesInvoiceLineTableTable,
              SalesInvoiceLineTableData
            >,
          ),
          SalesInvoiceLineTableData,
          PrefetchHooks Function()
        > {
  $$SalesInvoiceLineTableTableTableManager(
    _$AppDatabase db,
    $SalesInvoiceLineTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesInvoiceLineTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SalesInvoiceLineTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SalesInvoiceLineTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoiceLineTableCompanion(
                id: id,
                companyId: companyId,
                invoiceId: invoiceId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String invoiceId,
                required String description,
                required double quantity,
                required double unitPrice,
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoiceLineTableCompanion.insert(
                id: id,
                companyId: companyId,
                invoiceId: invoiceId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesInvoiceLineTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesInvoiceLineTableTable,
      SalesInvoiceLineTableData,
      $$SalesInvoiceLineTableTableFilterComposer,
      $$SalesInvoiceLineTableTableOrderingComposer,
      $$SalesInvoiceLineTableTableAnnotationComposer,
      $$SalesInvoiceLineTableTableCreateCompanionBuilder,
      $$SalesInvoiceLineTableTableUpdateCompanionBuilder,
      (
        SalesInvoiceLineTableData,
        BaseReferences<
          _$AppDatabase,
          $SalesInvoiceLineTableTable,
          SalesInvoiceLineTableData
        >,
      ),
      SalesInvoiceLineTableData,
      PrefetchHooks Function()
    >;
typedef $$VendorBillTableTableCreateCompanionBuilder =
    VendorBillTableCompanion Function({
      required String id,
      required String companyId,
      required String vendorId,
      required String purchaseOrderId,
      required String goodsReceiptId,
      required String reference,
      required String title,
      required String notes,
      required DateTime billDate,
      required DateTime dueDate,
      required String statusId,
      required String statusLabel,
      required String statusColor,
      Value<int> rowid,
    });
typedef $$VendorBillTableTableUpdateCompanionBuilder =
    VendorBillTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> vendorId,
      Value<String> purchaseOrderId,
      Value<String> goodsReceiptId,
      Value<String> reference,
      Value<String> title,
      Value<String> notes,
      Value<DateTime> billDate,
      Value<DateTime> dueDate,
      Value<String> statusId,
      Value<String> statusLabel,
      Value<String> statusColor,
      Value<int> rowid,
    });

class $$VendorBillTableTableFilterComposer
    extends Composer<_$AppDatabase, $VendorBillTableTable> {
  $$VendorBillTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goodsReceiptId => $composableBuilder(
    column: $table.goodsReceiptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get billDate => $composableBuilder(
    column: $table.billDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusId => $composableBuilder(
    column: $table.statusId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusColor => $composableBuilder(
    column: $table.statusColor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VendorBillTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VendorBillTableTable> {
  $$VendorBillTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goodsReceiptId => $composableBuilder(
    column: $table.goodsReceiptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get billDate => $composableBuilder(
    column: $table.billDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusId => $composableBuilder(
    column: $table.statusId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusColor => $composableBuilder(
    column: $table.statusColor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VendorBillTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VendorBillTableTable> {
  $$VendorBillTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get vendorId =>
      $composableBuilder(column: $table.vendorId, builder: (column) => column);

  GeneratedColumn<String> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goodsReceiptId => $composableBuilder(
    column: $table.goodsReceiptId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get billDate =>
      $composableBuilder(column: $table.billDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get statusId =>
      $composableBuilder(column: $table.statusId, builder: (column) => column);

  GeneratedColumn<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statusColor => $composableBuilder(
    column: $table.statusColor,
    builder: (column) => column,
  );
}

class $$VendorBillTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VendorBillTableTable,
          VendorBillTableData,
          $$VendorBillTableTableFilterComposer,
          $$VendorBillTableTableOrderingComposer,
          $$VendorBillTableTableAnnotationComposer,
          $$VendorBillTableTableCreateCompanionBuilder,
          $$VendorBillTableTableUpdateCompanionBuilder,
          (
            VendorBillTableData,
            BaseReferences<
              _$AppDatabase,
              $VendorBillTableTable,
              VendorBillTableData
            >,
          ),
          VendorBillTableData,
          PrefetchHooks Function()
        > {
  $$VendorBillTableTableTableManager(
    _$AppDatabase db,
    $VendorBillTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VendorBillTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VendorBillTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VendorBillTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> vendorId = const Value.absent(),
                Value<String> purchaseOrderId = const Value.absent(),
                Value<String> goodsReceiptId = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> billDate = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<String> statusId = const Value.absent(),
                Value<String> statusLabel = const Value.absent(),
                Value<String> statusColor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VendorBillTableCompanion(
                id: id,
                companyId: companyId,
                vendorId: vendorId,
                purchaseOrderId: purchaseOrderId,
                goodsReceiptId: goodsReceiptId,
                reference: reference,
                title: title,
                notes: notes,
                billDate: billDate,
                dueDate: dueDate,
                statusId: statusId,
                statusLabel: statusLabel,
                statusColor: statusColor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String vendorId,
                required String purchaseOrderId,
                required String goodsReceiptId,
                required String reference,
                required String title,
                required String notes,
                required DateTime billDate,
                required DateTime dueDate,
                required String statusId,
                required String statusLabel,
                required String statusColor,
                Value<int> rowid = const Value.absent(),
              }) => VendorBillTableCompanion.insert(
                id: id,
                companyId: companyId,
                vendorId: vendorId,
                purchaseOrderId: purchaseOrderId,
                goodsReceiptId: goodsReceiptId,
                reference: reference,
                title: title,
                notes: notes,
                billDate: billDate,
                dueDate: dueDate,
                statusId: statusId,
                statusLabel: statusLabel,
                statusColor: statusColor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VendorBillTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VendorBillTableTable,
      VendorBillTableData,
      $$VendorBillTableTableFilterComposer,
      $$VendorBillTableTableOrderingComposer,
      $$VendorBillTableTableAnnotationComposer,
      $$VendorBillTableTableCreateCompanionBuilder,
      $$VendorBillTableTableUpdateCompanionBuilder,
      (
        VendorBillTableData,
        BaseReferences<
          _$AppDatabase,
          $VendorBillTableTable,
          VendorBillTableData
        >,
      ),
      VendorBillTableData,
      PrefetchHooks Function()
    >;
typedef $$VendorBillLineTableTableCreateCompanionBuilder =
    VendorBillLineTableCompanion Function({
      required String id,
      required String companyId,
      required String billId,
      required String description,
      required double quantity,
      required double unitPrice,
      Value<int> rowid,
    });
typedef $$VendorBillLineTableTableUpdateCompanionBuilder =
    VendorBillLineTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> billId,
      Value<String> description,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<int> rowid,
    });

class $$VendorBillLineTableTableFilterComposer
    extends Composer<_$AppDatabase, $VendorBillLineTableTable> {
  $$VendorBillLineTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VendorBillLineTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VendorBillLineTableTable> {
  $$VendorBillLineTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VendorBillLineTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VendorBillLineTableTable> {
  $$VendorBillLineTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get billId =>
      $composableBuilder(column: $table.billId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);
}

class $$VendorBillLineTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VendorBillLineTableTable,
          VendorBillLineTableData,
          $$VendorBillLineTableTableFilterComposer,
          $$VendorBillLineTableTableOrderingComposer,
          $$VendorBillLineTableTableAnnotationComposer,
          $$VendorBillLineTableTableCreateCompanionBuilder,
          $$VendorBillLineTableTableUpdateCompanionBuilder,
          (
            VendorBillLineTableData,
            BaseReferences<
              _$AppDatabase,
              $VendorBillLineTableTable,
              VendorBillLineTableData
            >,
          ),
          VendorBillLineTableData,
          PrefetchHooks Function()
        > {
  $$VendorBillLineTableTableTableManager(
    _$AppDatabase db,
    $VendorBillLineTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VendorBillLineTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VendorBillLineTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$VendorBillLineTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> billId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VendorBillLineTableCompanion(
                id: id,
                companyId: companyId,
                billId: billId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String billId,
                required String description,
                required double quantity,
                required double unitPrice,
                Value<int> rowid = const Value.absent(),
              }) => VendorBillLineTableCompanion.insert(
                id: id,
                companyId: companyId,
                billId: billId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VendorBillLineTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VendorBillLineTableTable,
      VendorBillLineTableData,
      $$VendorBillLineTableTableFilterComposer,
      $$VendorBillLineTableTableOrderingComposer,
      $$VendorBillLineTableTableAnnotationComposer,
      $$VendorBillLineTableTableCreateCompanionBuilder,
      $$VendorBillLineTableTableUpdateCompanionBuilder,
      (
        VendorBillLineTableData,
        BaseReferences<
          _$AppDatabase,
          $VendorBillLineTableTable,
          VendorBillLineTableData
        >,
      ),
      VendorBillLineTableData,
      PrefetchHooks Function()
    >;
typedef $$PurchaseOrderTableTableCreateCompanionBuilder =
    PurchaseOrderTableCompanion Function({
      required String id,
      required String companyId,
      required String vendorId,
      required String reference,
      required String title,
      required String notes,
      required DateTime orderDate,
      required DateTime expectedDate,
      required String statusId,
      required String statusLabel,
      required String statusColor,
      Value<int> rowid,
    });
typedef $$PurchaseOrderTableTableUpdateCompanionBuilder =
    PurchaseOrderTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> vendorId,
      Value<String> reference,
      Value<String> title,
      Value<String> notes,
      Value<DateTime> orderDate,
      Value<DateTime> expectedDate,
      Value<String> statusId,
      Value<String> statusLabel,
      Value<String> statusColor,
      Value<int> rowid,
    });

class $$PurchaseOrderTableTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrderTableTable> {
  $$PurchaseOrderTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get orderDate => $composableBuilder(
    column: $table.orderDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedDate => $composableBuilder(
    column: $table.expectedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusId => $composableBuilder(
    column: $table.statusId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusColor => $composableBuilder(
    column: $table.statusColor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseOrderTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrderTableTable> {
  $$PurchaseOrderTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get orderDate => $composableBuilder(
    column: $table.orderDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedDate => $composableBuilder(
    column: $table.expectedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusId => $composableBuilder(
    column: $table.statusId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusColor => $composableBuilder(
    column: $table.statusColor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseOrderTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrderTableTable> {
  $$PurchaseOrderTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get vendorId =>
      $composableBuilder(column: $table.vendorId, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get orderDate =>
      $composableBuilder(column: $table.orderDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expectedDate => $composableBuilder(
    column: $table.expectedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statusId =>
      $composableBuilder(column: $table.statusId, builder: (column) => column);

  GeneratedColumn<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statusColor => $composableBuilder(
    column: $table.statusColor,
    builder: (column) => column,
  );
}

class $$PurchaseOrderTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrderTableTable,
          PurchaseOrderTableData,
          $$PurchaseOrderTableTableFilterComposer,
          $$PurchaseOrderTableTableOrderingComposer,
          $$PurchaseOrderTableTableAnnotationComposer,
          $$PurchaseOrderTableTableCreateCompanionBuilder,
          $$PurchaseOrderTableTableUpdateCompanionBuilder,
          (
            PurchaseOrderTableData,
            BaseReferences<
              _$AppDatabase,
              $PurchaseOrderTableTable,
              PurchaseOrderTableData
            >,
          ),
          PurchaseOrderTableData,
          PrefetchHooks Function()
        > {
  $$PurchaseOrderTableTableTableManager(
    _$AppDatabase db,
    $PurchaseOrderTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrderTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrderTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrderTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> vendorId = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> orderDate = const Value.absent(),
                Value<DateTime> expectedDate = const Value.absent(),
                Value<String> statusId = const Value.absent(),
                Value<String> statusLabel = const Value.absent(),
                Value<String> statusColor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrderTableCompanion(
                id: id,
                companyId: companyId,
                vendorId: vendorId,
                reference: reference,
                title: title,
                notes: notes,
                orderDate: orderDate,
                expectedDate: expectedDate,
                statusId: statusId,
                statusLabel: statusLabel,
                statusColor: statusColor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String vendorId,
                required String reference,
                required String title,
                required String notes,
                required DateTime orderDate,
                required DateTime expectedDate,
                required String statusId,
                required String statusLabel,
                required String statusColor,
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrderTableCompanion.insert(
                id: id,
                companyId: companyId,
                vendorId: vendorId,
                reference: reference,
                title: title,
                notes: notes,
                orderDate: orderDate,
                expectedDate: expectedDate,
                statusId: statusId,
                statusLabel: statusLabel,
                statusColor: statusColor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseOrderTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrderTableTable,
      PurchaseOrderTableData,
      $$PurchaseOrderTableTableFilterComposer,
      $$PurchaseOrderTableTableOrderingComposer,
      $$PurchaseOrderTableTableAnnotationComposer,
      $$PurchaseOrderTableTableCreateCompanionBuilder,
      $$PurchaseOrderTableTableUpdateCompanionBuilder,
      (
        PurchaseOrderTableData,
        BaseReferences<
          _$AppDatabase,
          $PurchaseOrderTableTable,
          PurchaseOrderTableData
        >,
      ),
      PurchaseOrderTableData,
      PrefetchHooks Function()
    >;
typedef $$PurchaseOrderLineTableTableCreateCompanionBuilder =
    PurchaseOrderLineTableCompanion Function({
      required String id,
      required String companyId,
      required String purchaseOrderId,
      required String description,
      required double quantity,
      required double unitPrice,
      Value<int> rowid,
    });
typedef $$PurchaseOrderLineTableTableUpdateCompanionBuilder =
    PurchaseOrderLineTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> purchaseOrderId,
      Value<String> description,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<int> rowid,
    });

class $$PurchaseOrderLineTableTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrderLineTableTable> {
  $$PurchaseOrderLineTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseOrderLineTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrderLineTableTable> {
  $$PurchaseOrderLineTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseOrderLineTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrderLineTableTable> {
  $$PurchaseOrderLineTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);
}

class $$PurchaseOrderLineTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrderLineTableTable,
          PurchaseOrderLineTableData,
          $$PurchaseOrderLineTableTableFilterComposer,
          $$PurchaseOrderLineTableTableOrderingComposer,
          $$PurchaseOrderLineTableTableAnnotationComposer,
          $$PurchaseOrderLineTableTableCreateCompanionBuilder,
          $$PurchaseOrderLineTableTableUpdateCompanionBuilder,
          (
            PurchaseOrderLineTableData,
            BaseReferences<
              _$AppDatabase,
              $PurchaseOrderLineTableTable,
              PurchaseOrderLineTableData
            >,
          ),
          PurchaseOrderLineTableData,
          PrefetchHooks Function()
        > {
  $$PurchaseOrderLineTableTableTableManager(
    _$AppDatabase db,
    $PurchaseOrderLineTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrderLineTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PurchaseOrderLineTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PurchaseOrderLineTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> purchaseOrderId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrderLineTableCompanion(
                id: id,
                companyId: companyId,
                purchaseOrderId: purchaseOrderId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String purchaseOrderId,
                required String description,
                required double quantity,
                required double unitPrice,
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrderLineTableCompanion.insert(
                id: id,
                companyId: companyId,
                purchaseOrderId: purchaseOrderId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseOrderLineTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrderLineTableTable,
      PurchaseOrderLineTableData,
      $$PurchaseOrderLineTableTableFilterComposer,
      $$PurchaseOrderLineTableTableOrderingComposer,
      $$PurchaseOrderLineTableTableAnnotationComposer,
      $$PurchaseOrderLineTableTableCreateCompanionBuilder,
      $$PurchaseOrderLineTableTableUpdateCompanionBuilder,
      (
        PurchaseOrderLineTableData,
        BaseReferences<
          _$AppDatabase,
          $PurchaseOrderLineTableTable,
          PurchaseOrderLineTableData
        >,
      ),
      PurchaseOrderLineTableData,
      PrefetchHooks Function()
    >;
typedef $$ExpenseTableTableCreateCompanionBuilder =
    ExpenseTableCompanion Function({
      required String id,
      required String companyId,
      required String merchant,
      required double amount,
      required String categoryId,
      required String paymentMethodId,
      required DateTime occurredAt,
      required String description,
      required String attachmentIds,
      required String status,
      required String businessId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String createdBy,
      required String updatedBy,
      required bool isDeleted,
      Value<int> rowid,
    });
typedef $$ExpenseTableTableUpdateCompanionBuilder =
    ExpenseTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> merchant,
      Value<double> amount,
      Value<String> categoryId,
      Value<String> paymentMethodId,
      Value<DateTime> occurredAt,
      Value<String> description,
      Value<String> attachmentIds,
      Value<String> status,
      Value<String> businessId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> createdBy,
      Value<String> updatedBy,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

class $$ExpenseTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseTableTable> {
  $$ExpenseTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentIds => $composableBuilder(
    column: $table.attachmentIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseTableTable> {
  $$ExpenseTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentIds => $composableBuilder(
    column: $table.attachmentIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseTableTable> {
  $$ExpenseTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get merchant =>
      $composableBuilder(column: $table.merchant, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentIds => $composableBuilder(
    column: $table.attachmentIds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$ExpenseTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseTableTable,
          ExpenseTableData,
          $$ExpenseTableTableFilterComposer,
          $$ExpenseTableTableOrderingComposer,
          $$ExpenseTableTableAnnotationComposer,
          $$ExpenseTableTableCreateCompanionBuilder,
          $$ExpenseTableTableUpdateCompanionBuilder,
          (
            ExpenseTableData,
            BaseReferences<_$AppDatabase, $ExpenseTableTable, ExpenseTableData>,
          ),
          ExpenseTableData,
          PrefetchHooks Function()
        > {
  $$ExpenseTableTableTableManager(_$AppDatabase db, $ExpenseTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> merchant = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> paymentMethodId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> attachmentIds = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> updatedBy = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpenseTableCompanion(
                id: id,
                companyId: companyId,
                merchant: merchant,
                amount: amount,
                categoryId: categoryId,
                paymentMethodId: paymentMethodId,
                occurredAt: occurredAt,
                description: description,
                attachmentIds: attachmentIds,
                status: status,
                businessId: businessId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                updatedBy: updatedBy,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String merchant,
                required double amount,
                required String categoryId,
                required String paymentMethodId,
                required DateTime occurredAt,
                required String description,
                required String attachmentIds,
                required String status,
                required String businessId,
                required DateTime createdAt,
                required DateTime updatedAt,
                required String createdBy,
                required String updatedBy,
                required bool isDeleted,
                Value<int> rowid = const Value.absent(),
              }) => ExpenseTableCompanion.insert(
                id: id,
                companyId: companyId,
                merchant: merchant,
                amount: amount,
                categoryId: categoryId,
                paymentMethodId: paymentMethodId,
                occurredAt: occurredAt,
                description: description,
                attachmentIds: attachmentIds,
                status: status,
                businessId: businessId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                updatedBy: updatedBy,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseTableTable,
      ExpenseTableData,
      $$ExpenseTableTableFilterComposer,
      $$ExpenseTableTableOrderingComposer,
      $$ExpenseTableTableAnnotationComposer,
      $$ExpenseTableTableCreateCompanionBuilder,
      $$ExpenseTableTableUpdateCompanionBuilder,
      (
        ExpenseTableData,
        BaseReferences<_$AppDatabase, $ExpenseTableTable, ExpenseTableData>,
      ),
      ExpenseTableData,
      PrefetchHooks Function()
    >;
typedef $$BankAccountTableTableCreateCompanionBuilder =
    BankAccountTableCompanion Function({
      required String id,
      required String companyId,
      required String name,
      required String accountNumber,
      required String accountType,
      required String currency,
      required double currentBalance,
      required String status,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$BankAccountTableTableUpdateCompanionBuilder =
    BankAccountTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> name,
      Value<String> accountNumber,
      Value<String> accountType,
      Value<String> currency,
      Value<double> currentBalance,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$BankAccountTableTableFilterComposer
    extends Composer<_$AppDatabase, $BankAccountTableTable> {
  $$BankAccountTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BankAccountTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BankAccountTableTable> {
  $$BankAccountTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BankAccountTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BankAccountTableTable> {
  $$BankAccountTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BankAccountTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BankAccountTableTable,
          BankAccountTableData,
          $$BankAccountTableTableFilterComposer,
          $$BankAccountTableTableOrderingComposer,
          $$BankAccountTableTableAnnotationComposer,
          $$BankAccountTableTableCreateCompanionBuilder,
          $$BankAccountTableTableUpdateCompanionBuilder,
          (
            BankAccountTableData,
            BaseReferences<
              _$AppDatabase,
              $BankAccountTableTable,
              BankAccountTableData
            >,
          ),
          BankAccountTableData,
          PrefetchHooks Function()
        > {
  $$BankAccountTableTableTableManager(
    _$AppDatabase db,
    $BankAccountTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BankAccountTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BankAccountTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BankAccountTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> accountNumber = const Value.absent(),
                Value<String> accountType = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> currentBalance = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankAccountTableCompanion(
                id: id,
                companyId: companyId,
                name: name,
                accountNumber: accountNumber,
                accountType: accountType,
                currency: currency,
                currentBalance: currentBalance,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String name,
                required String accountNumber,
                required String accountType,
                required String currency,
                required double currentBalance,
                required String status,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => BankAccountTableCompanion.insert(
                id: id,
                companyId: companyId,
                name: name,
                accountNumber: accountNumber,
                accountType: accountType,
                currency: currency,
                currentBalance: currentBalance,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BankAccountTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BankAccountTableTable,
      BankAccountTableData,
      $$BankAccountTableTableFilterComposer,
      $$BankAccountTableTableOrderingComposer,
      $$BankAccountTableTableAnnotationComposer,
      $$BankAccountTableTableCreateCompanionBuilder,
      $$BankAccountTableTableUpdateCompanionBuilder,
      (
        BankAccountTableData,
        BaseReferences<
          _$AppDatabase,
          $BankAccountTableTable,
          BankAccountTableData
        >,
      ),
      BankAccountTableData,
      PrefetchHooks Function()
    >;
typedef $$BankTransactionTableTableCreateCompanionBuilder =
    BankTransactionTableCompanion Function({
      required String id,
      required String companyId,
      required String accountId,
      required DateTime date,
      required double amount,
      required String transactionType,
      required String reference,
      required String description,
      required double runningBalance,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BankTransactionTableTableUpdateCompanionBuilder =
    BankTransactionTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> accountId,
      Value<DateTime> date,
      Value<double> amount,
      Value<String> transactionType,
      Value<String> reference,
      Value<String> description,
      Value<double> runningBalance,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BankTransactionTableTableFilterComposer
    extends Composer<_$AppDatabase, $BankTransactionTableTable> {
  $$BankTransactionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get runningBalance => $composableBuilder(
    column: $table.runningBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BankTransactionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BankTransactionTableTable> {
  $$BankTransactionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get runningBalance => $composableBuilder(
    column: $table.runningBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BankTransactionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BankTransactionTableTable> {
  $$BankTransactionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get runningBalance => $composableBuilder(
    column: $table.runningBalance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BankTransactionTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BankTransactionTableTable,
          BankTransactionTableData,
          $$BankTransactionTableTableFilterComposer,
          $$BankTransactionTableTableOrderingComposer,
          $$BankTransactionTableTableAnnotationComposer,
          $$BankTransactionTableTableCreateCompanionBuilder,
          $$BankTransactionTableTableUpdateCompanionBuilder,
          (
            BankTransactionTableData,
            BaseReferences<
              _$AppDatabase,
              $BankTransactionTableTable,
              BankTransactionTableData
            >,
          ),
          BankTransactionTableData,
          PrefetchHooks Function()
        > {
  $$BankTransactionTableTableTableManager(
    _$AppDatabase db,
    $BankTransactionTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BankTransactionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BankTransactionTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BankTransactionTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> transactionType = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> runningBalance = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankTransactionTableCompanion(
                id: id,
                companyId: companyId,
                accountId: accountId,
                date: date,
                amount: amount,
                transactionType: transactionType,
                reference: reference,
                description: description,
                runningBalance: runningBalance,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String accountId,
                required DateTime date,
                required double amount,
                required String transactionType,
                required String reference,
                required String description,
                required double runningBalance,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BankTransactionTableCompanion.insert(
                id: id,
                companyId: companyId,
                accountId: accountId,
                date: date,
                amount: amount,
                transactionType: transactionType,
                reference: reference,
                description: description,
                runningBalance: runningBalance,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BankTransactionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BankTransactionTableTable,
      BankTransactionTableData,
      $$BankTransactionTableTableFilterComposer,
      $$BankTransactionTableTableOrderingComposer,
      $$BankTransactionTableTableAnnotationComposer,
      $$BankTransactionTableTableCreateCompanionBuilder,
      $$BankTransactionTableTableUpdateCompanionBuilder,
      (
        BankTransactionTableData,
        BaseReferences<
          _$AppDatabase,
          $BankTransactionTableTable,
          BankTransactionTableData
        >,
      ),
      BankTransactionTableData,
      PrefetchHooks Function()
    >;
typedef $$BankStatementTableTableCreateCompanionBuilder =
    BankStatementTableCompanion Function({
      required String id,
      required String companyId,
      required String bankAccountId,
      required String bankAccountName,
      required DateTime periodStart,
      required DateTime periodEnd,
      required double openingBalance,
      required double closingBalance,
      required String status,
      required DateTime importedAt,
      Value<DateTime?> reconciledAt,
      Value<int> rowid,
    });
typedef $$BankStatementTableTableUpdateCompanionBuilder =
    BankStatementTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> bankAccountId,
      Value<String> bankAccountName,
      Value<DateTime> periodStart,
      Value<DateTime> periodEnd,
      Value<double> openingBalance,
      Value<double> closingBalance,
      Value<String> status,
      Value<DateTime> importedAt,
      Value<DateTime?> reconciledAt,
      Value<int> rowid,
    });

class $$BankStatementTableTableFilterComposer
    extends Composer<_$AppDatabase, $BankStatementTableTable> {
  $$BankStatementTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankAccountId => $composableBuilder(
    column: $table.bankAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankAccountName => $composableBuilder(
    column: $table.bankAccountName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodEnd => $composableBuilder(
    column: $table.periodEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get closingBalance => $composableBuilder(
    column: $table.closingBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reconciledAt => $composableBuilder(
    column: $table.reconciledAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BankStatementTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BankStatementTableTable> {
  $$BankStatementTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankAccountId => $composableBuilder(
    column: $table.bankAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankAccountName => $composableBuilder(
    column: $table.bankAccountName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodEnd => $composableBuilder(
    column: $table.periodEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get closingBalance => $composableBuilder(
    column: $table.closingBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reconciledAt => $composableBuilder(
    column: $table.reconciledAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BankStatementTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BankStatementTableTable> {
  $$BankStatementTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get bankAccountId => $composableBuilder(
    column: $table.bankAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bankAccountName => $composableBuilder(
    column: $table.bankAccountName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get periodEnd =>
      $composableBuilder(column: $table.periodEnd, builder: (column) => column);

  GeneratedColumn<double> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get closingBalance => $composableBuilder(
    column: $table.closingBalance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reconciledAt => $composableBuilder(
    column: $table.reconciledAt,
    builder: (column) => column,
  );
}

class $$BankStatementTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BankStatementTableTable,
          BankStatementTableData,
          $$BankStatementTableTableFilterComposer,
          $$BankStatementTableTableOrderingComposer,
          $$BankStatementTableTableAnnotationComposer,
          $$BankStatementTableTableCreateCompanionBuilder,
          $$BankStatementTableTableUpdateCompanionBuilder,
          (
            BankStatementTableData,
            BaseReferences<
              _$AppDatabase,
              $BankStatementTableTable,
              BankStatementTableData
            >,
          ),
          BankStatementTableData,
          PrefetchHooks Function()
        > {
  $$BankStatementTableTableTableManager(
    _$AppDatabase db,
    $BankStatementTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BankStatementTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BankStatementTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BankStatementTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> bankAccountId = const Value.absent(),
                Value<String> bankAccountName = const Value.absent(),
                Value<DateTime> periodStart = const Value.absent(),
                Value<DateTime> periodEnd = const Value.absent(),
                Value<double> openingBalance = const Value.absent(),
                Value<double> closingBalance = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<DateTime?> reconciledAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankStatementTableCompanion(
                id: id,
                companyId: companyId,
                bankAccountId: bankAccountId,
                bankAccountName: bankAccountName,
                periodStart: periodStart,
                periodEnd: periodEnd,
                openingBalance: openingBalance,
                closingBalance: closingBalance,
                status: status,
                importedAt: importedAt,
                reconciledAt: reconciledAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String bankAccountId,
                required String bankAccountName,
                required DateTime periodStart,
                required DateTime periodEnd,
                required double openingBalance,
                required double closingBalance,
                required String status,
                required DateTime importedAt,
                Value<DateTime?> reconciledAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankStatementTableCompanion.insert(
                id: id,
                companyId: companyId,
                bankAccountId: bankAccountId,
                bankAccountName: bankAccountName,
                periodStart: periodStart,
                periodEnd: periodEnd,
                openingBalance: openingBalance,
                closingBalance: closingBalance,
                status: status,
                importedAt: importedAt,
                reconciledAt: reconciledAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BankStatementTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BankStatementTableTable,
      BankStatementTableData,
      $$BankStatementTableTableFilterComposer,
      $$BankStatementTableTableOrderingComposer,
      $$BankStatementTableTableAnnotationComposer,
      $$BankStatementTableTableCreateCompanionBuilder,
      $$BankStatementTableTableUpdateCompanionBuilder,
      (
        BankStatementTableData,
        BaseReferences<
          _$AppDatabase,
          $BankStatementTableTable,
          BankStatementTableData
        >,
      ),
      BankStatementTableData,
      PrefetchHooks Function()
    >;
typedef $$BankStatementTransactionTableTableCreateCompanionBuilder =
    BankStatementTransactionTableCompanion Function({
      required String id,
      required String companyId,
      required String statementId,
      required DateTime date,
      required double amount,
      required String description,
      required String reference,
      required bool isMatched,
      Value<String?> matchedErpEntryId,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$BankStatementTransactionTableTableUpdateCompanionBuilder =
    BankStatementTransactionTableCompanion Function({
      Value<String> id,
      Value<String> companyId,
      Value<String> statementId,
      Value<DateTime> date,
      Value<double> amount,
      Value<String> description,
      Value<String> reference,
      Value<bool> isMatched,
      Value<String?> matchedErpEntryId,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$BankStatementTransactionTableTableFilterComposer
    extends Composer<_$AppDatabase, $BankStatementTransactionTableTable> {
  $$BankStatementTransactionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statementId => $composableBuilder(
    column: $table.statementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMatched => $composableBuilder(
    column: $table.isMatched,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchedErpEntryId => $composableBuilder(
    column: $table.matchedErpEntryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BankStatementTransactionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BankStatementTransactionTableTable> {
  $$BankStatementTransactionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statementId => $composableBuilder(
    column: $table.statementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMatched => $composableBuilder(
    column: $table.isMatched,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchedErpEntryId => $composableBuilder(
    column: $table.matchedErpEntryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BankStatementTransactionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BankStatementTransactionTableTable> {
  $$BankStatementTransactionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get statementId => $composableBuilder(
    column: $table.statementId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<bool> get isMatched =>
      $composableBuilder(column: $table.isMatched, builder: (column) => column);

  GeneratedColumn<String> get matchedErpEntryId => $composableBuilder(
    column: $table.matchedErpEntryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$BankStatementTransactionTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BankStatementTransactionTableTable,
          BankStatementTransactionTableData,
          $$BankStatementTransactionTableTableFilterComposer,
          $$BankStatementTransactionTableTableOrderingComposer,
          $$BankStatementTransactionTableTableAnnotationComposer,
          $$BankStatementTransactionTableTableCreateCompanionBuilder,
          $$BankStatementTransactionTableTableUpdateCompanionBuilder,
          (
            BankStatementTransactionTableData,
            BaseReferences<
              _$AppDatabase,
              $BankStatementTransactionTableTable,
              BankStatementTransactionTableData
            >,
          ),
          BankStatementTransactionTableData,
          PrefetchHooks Function()
        > {
  $$BankStatementTransactionTableTableTableManager(
    _$AppDatabase db,
    $BankStatementTransactionTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BankStatementTransactionTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BankStatementTransactionTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BankStatementTransactionTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> statementId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<bool> isMatched = const Value.absent(),
                Value<String?> matchedErpEntryId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankStatementTransactionTableCompanion(
                id: id,
                companyId: companyId,
                statementId: statementId,
                date: date,
                amount: amount,
                description: description,
                reference: reference,
                isMatched: isMatched,
                matchedErpEntryId: matchedErpEntryId,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String companyId,
                required String statementId,
                required DateTime date,
                required double amount,
                required String description,
                required String reference,
                required bool isMatched,
                Value<String?> matchedErpEntryId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankStatementTransactionTableCompanion.insert(
                id: id,
                companyId: companyId,
                statementId: statementId,
                date: date,
                amount: amount,
                description: description,
                reference: reference,
                isMatched: isMatched,
                matchedErpEntryId: matchedErpEntryId,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BankStatementTransactionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BankStatementTransactionTableTable,
      BankStatementTransactionTableData,
      $$BankStatementTransactionTableTableFilterComposer,
      $$BankStatementTransactionTableTableOrderingComposer,
      $$BankStatementTransactionTableTableAnnotationComposer,
      $$BankStatementTransactionTableTableCreateCompanionBuilder,
      $$BankStatementTransactionTableTableUpdateCompanionBuilder,
      (
        BankStatementTransactionTableData,
        BaseReferences<
          _$AppDatabase,
          $BankStatementTransactionTableTable,
          BankStatementTransactionTableData
        >,
      ),
      BankStatementTransactionTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CustomersTableTableTableManager get customersTable =>
      $$CustomersTableTableTableManager(_db, _db.customersTable);
  $$VendorsTableTableTableManager get vendorsTable =>
      $$VendorsTableTableTableManager(_db, _db.vendorsTable);
  $$ProductsTableTableTableManager get productsTable =>
      $$ProductsTableTableTableManager(_db, _db.productsTable);
  $$SalesInvoiceTableTableTableManager get salesInvoiceTable =>
      $$SalesInvoiceTableTableTableManager(_db, _db.salesInvoiceTable);
  $$SalesInvoiceLineTableTableTableManager get salesInvoiceLineTable =>
      $$SalesInvoiceLineTableTableTableManager(_db, _db.salesInvoiceLineTable);
  $$VendorBillTableTableTableManager get vendorBillTable =>
      $$VendorBillTableTableTableManager(_db, _db.vendorBillTable);
  $$VendorBillLineTableTableTableManager get vendorBillLineTable =>
      $$VendorBillLineTableTableTableManager(_db, _db.vendorBillLineTable);
  $$PurchaseOrderTableTableTableManager get purchaseOrderTable =>
      $$PurchaseOrderTableTableTableManager(_db, _db.purchaseOrderTable);
  $$PurchaseOrderLineTableTableTableManager get purchaseOrderLineTable =>
      $$PurchaseOrderLineTableTableTableManager(
        _db,
        _db.purchaseOrderLineTable,
      );
  $$ExpenseTableTableTableManager get expenseTable =>
      $$ExpenseTableTableTableManager(_db, _db.expenseTable);
  $$BankAccountTableTableTableManager get bankAccountTable =>
      $$BankAccountTableTableTableManager(_db, _db.bankAccountTable);
  $$BankTransactionTableTableTableManager get bankTransactionTable =>
      $$BankTransactionTableTableTableManager(_db, _db.bankTransactionTable);
  $$BankStatementTableTableTableManager get bankStatementTable =>
      $$BankStatementTableTableTableManager(_db, _db.bankStatementTable);
  $$BankStatementTransactionTableTableTableManager
  get bankStatementTransactionTable =>
      $$BankStatementTransactionTableTableTableManager(
        _db,
        _db.bankStatementTransactionTable,
      );
}
