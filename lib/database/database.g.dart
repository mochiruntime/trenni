// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PocketsTable extends Pockets with TableInfo<$PocketsTable, Pocket> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PocketsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _iconCodePointMeta = const VerificationMeta(
    'iconCodePoint',
  );
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
    'icon_code_point',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconFontFamilyMeta = const VerificationMeta(
    'iconFontFamily',
  );
  @override
  late final GeneratedColumn<String> iconFontFamily = GeneratedColumn<String>(
    'icon_font_family',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    iconCodePoint,
    iconFontFamily,
    colorValue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pockets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pocket> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
        _iconCodePointMeta,
        iconCodePoint.isAcceptableOrUnknown(
          data['icon_code_point']!,
          _iconCodePointMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_iconCodePointMeta);
    }
    if (data.containsKey('icon_font_family')) {
      context.handle(
        _iconFontFamilyMeta,
        iconFontFamily.isAcceptableOrUnknown(
          data['icon_font_family']!,
          _iconFontFamilyMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pocket map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pocket(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconCodePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_code_point'],
      )!,
      iconFontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_font_family'],
      ),
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
    );
  }

  @override
  $PocketsTable createAlias(String alias) {
    return $PocketsTable(attachedDatabase, alias);
  }
}

class Pocket extends DataClass implements Insertable<Pocket> {
  final String id;
  final String name;
  final int iconCodePoint;
  final String? iconFontFamily;
  final int? colorValue;
  const Pocket({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    this.iconFontFamily,
    this.colorValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon_code_point'] = Variable<int>(iconCodePoint);
    if (!nullToAbsent || iconFontFamily != null) {
      map['icon_font_family'] = Variable<String>(iconFontFamily);
    }
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    return map;
  }

  PocketsCompanion toCompanion(bool nullToAbsent) {
    return PocketsCompanion(
      id: Value(id),
      name: Value(name),
      iconCodePoint: Value(iconCodePoint),
      iconFontFamily: iconFontFamily == null && nullToAbsent
          ? const Value.absent()
          : Value(iconFontFamily),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
    );
  }

  factory Pocket.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pocket(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconCodePoint: serializer.fromJson<int>(json['iconCodePoint']),
      iconFontFamily: serializer.fromJson<String?>(json['iconFontFamily']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'iconCodePoint': serializer.toJson<int>(iconCodePoint),
      'iconFontFamily': serializer.toJson<String?>(iconFontFamily),
      'colorValue': serializer.toJson<int?>(colorValue),
    };
  }

  Pocket copyWith({
    String? id,
    String? name,
    int? iconCodePoint,
    Value<String?> iconFontFamily = const Value.absent(),
    Value<int?> colorValue = const Value.absent(),
  }) => Pocket(
    id: id ?? this.id,
    name: name ?? this.name,
    iconCodePoint: iconCodePoint ?? this.iconCodePoint,
    iconFontFamily: iconFontFamily.present
        ? iconFontFamily.value
        : this.iconFontFamily,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
  );
  Pocket copyWithCompanion(PocketsCompanion data) {
    return Pocket(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
      iconFontFamily: data.iconFontFamily.present
          ? data.iconFontFamily.value
          : this.iconFontFamily,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pocket(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('iconFontFamily: $iconFontFamily, ')
          ..write('colorValue: $colorValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, iconCodePoint, iconFontFamily, colorValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pocket &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconCodePoint == this.iconCodePoint &&
          other.iconFontFamily == this.iconFontFamily &&
          other.colorValue == this.colorValue);
}

class PocketsCompanion extends UpdateCompanion<Pocket> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> iconCodePoint;
  final Value<String?> iconFontFamily;
  final Value<int?> colorValue;
  final Value<int> rowid;
  const PocketsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.iconFontFamily = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PocketsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int iconCodePoint,
    this.iconFontFamily = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       iconCodePoint = Value(iconCodePoint);
  static Insertable<Pocket> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? iconCodePoint,
    Expression<String>? iconFontFamily,
    Expression<int>? colorValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (iconFontFamily != null) 'icon_font_family': iconFontFamily,
      if (colorValue != null) 'color_value': colorValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PocketsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? iconCodePoint,
    Value<String?>? iconFontFamily,
    Value<int?>? colorValue,
    Value<int>? rowid,
  }) {
    return PocketsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      iconFontFamily: iconFontFamily ?? this.iconFontFamily,
      colorValue: colorValue ?? this.colorValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (iconFontFamily.present) {
      map['icon_font_family'] = Variable<String>(iconFontFamily.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PocketsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('iconFontFamily: $iconFontFamily, ')
          ..write('colorValue: $colorValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconCodePointMeta = const VerificationMeta(
    'iconCodePoint',
  );
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
    'icon_code_point',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconFontFamilyMeta = const VerificationMeta(
    'iconFontFamily',
  );
  @override
  late final GeneratedColumn<String> iconFontFamily = GeneratedColumn<String>(
    'icon_font_family',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    currency,
    iconCodePoint,
    iconFontFamily,
    colorValue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
        _iconCodePointMeta,
        iconCodePoint.isAcceptableOrUnknown(
          data['icon_code_point']!,
          _iconCodePointMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_iconCodePointMeta);
    }
    if (data.containsKey('icon_font_family')) {
      context.handle(
        _iconFontFamilyMeta,
        iconFontFamily.isAcceptableOrUnknown(
          data['icon_font_family']!,
          _iconFontFamilyMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      iconCodePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_code_point'],
      )!,
      iconFontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_font_family'],
      ),
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final String id;
  final String name;
  final String currency;
  final int iconCodePoint;
  final String? iconFontFamily;
  final int? colorValue;
  const Account({
    required this.id,
    required this.name,
    required this.currency,
    required this.iconCodePoint,
    this.iconFontFamily,
    this.colorValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['currency'] = Variable<String>(currency);
    map['icon_code_point'] = Variable<int>(iconCodePoint);
    if (!nullToAbsent || iconFontFamily != null) {
      map['icon_font_family'] = Variable<String>(iconFontFamily);
    }
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      currency: Value(currency),
      iconCodePoint: Value(iconCodePoint),
      iconFontFamily: iconFontFamily == null && nullToAbsent
          ? const Value.absent()
          : Value(iconFontFamily),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      currency: serializer.fromJson<String>(json['currency']),
      iconCodePoint: serializer.fromJson<int>(json['iconCodePoint']),
      iconFontFamily: serializer.fromJson<String?>(json['iconFontFamily']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'currency': serializer.toJson<String>(currency),
      'iconCodePoint': serializer.toJson<int>(iconCodePoint),
      'iconFontFamily': serializer.toJson<String?>(iconFontFamily),
      'colorValue': serializer.toJson<int?>(colorValue),
    };
  }

  Account copyWith({
    String? id,
    String? name,
    String? currency,
    int? iconCodePoint,
    Value<String?> iconFontFamily = const Value.absent(),
    Value<int?> colorValue = const Value.absent(),
  }) => Account(
    id: id ?? this.id,
    name: name ?? this.name,
    currency: currency ?? this.currency,
    iconCodePoint: iconCodePoint ?? this.iconCodePoint,
    iconFontFamily: iconFontFamily.present
        ? iconFontFamily.value
        : this.iconFontFamily,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      currency: data.currency.present ? data.currency.value : this.currency,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
      iconFontFamily: data.iconFontFamily.present
          ? data.iconFontFamily.value
          : this.iconFontFamily,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('currency: $currency, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('iconFontFamily: $iconFontFamily, ')
          ..write('colorValue: $colorValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    currency,
    iconCodePoint,
    iconFontFamily,
    colorValue,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.name == this.name &&
          other.currency == this.currency &&
          other.iconCodePoint == this.iconCodePoint &&
          other.iconFontFamily == this.iconFontFamily &&
          other.colorValue == this.colorValue);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> currency;
  final Value<int> iconCodePoint;
  final Value<String?> iconFontFamily;
  final Value<int?> colorValue;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.currency = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.iconFontFamily = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String currency,
    required int iconCodePoint,
    this.iconFontFamily = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       currency = Value(currency),
       iconCodePoint = Value(iconCodePoint);
  static Insertable<Account> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? currency,
    Expression<int>? iconCodePoint,
    Expression<String>? iconFontFamily,
    Expression<int>? colorValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (currency != null) 'currency': currency,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (iconFontFamily != null) 'icon_font_family': iconFontFamily,
      if (colorValue != null) 'color_value': colorValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? currency,
    Value<int>? iconCodePoint,
    Value<String?>? iconFontFamily,
    Value<int?>? colorValue,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      iconFontFamily: iconFontFamily ?? this.iconFontFamily,
      colorValue: colorValue ?? this.colorValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (iconFontFamily.present) {
      map['icon_font_family'] = Variable<String>(iconFontFamily.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('currency: $currency, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('iconFontFamily: $iconFontFamily, ')
          ..write('colorValue: $colorValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
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
  @override
  late final GeneratedColumnWithTypeConverter<double, int> amount =
      GeneratedColumn<int>(
        'amount',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<double>($TransactionsTable.$converteramount);
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
    'emoji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pocketIdMeta = const VerificationMeta(
    'pocketId',
  );
  @override
  late final GeneratedColumn<String> pocketId = GeneratedColumn<String>(
    'pocket_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pockets (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _parentTransactionIdMeta =
      const VerificationMeta('parentTransactionId');
  @override
  late final GeneratedColumn<String> parentTransactionId =
      GeneratedColumn<String>(
        'parent_transaction_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES transactions (id) ON DELETE CASCADE',
        ),
      );
  static const VerificationMeta _transferToAccountIdMeta =
      const VerificationMeta('transferToAccountId');
  @override
  late final GeneratedColumn<String> transferToAccountId =
      GeneratedColumn<String>(
        'transfer_to_account_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE SET NULL',
        ),
      );
  static const VerificationMeta _transferToPocketIdMeta =
      const VerificationMeta('transferToPocketId');
  @override
  late final GeneratedColumn<String> transferToPocketId =
      GeneratedColumn<String>(
        'transfer_to_pocket_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES pockets (id) ON DELETE SET NULL',
        ),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    amount,
    timestamp,
    notes,
    emoji,
    accountId,
    pocketId,
    parentTransactionId,
    transferToAccountId,
    transferToPocketId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('emoji')) {
      context.handle(
        _emojiMeta,
        emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('pocket_id')) {
      context.handle(
        _pocketIdMeta,
        pocketId.isAcceptableOrUnknown(data['pocket_id']!, _pocketIdMeta),
      );
    }
    if (data.containsKey('parent_transaction_id')) {
      context.handle(
        _parentTransactionIdMeta,
        parentTransactionId.isAcceptableOrUnknown(
          data['parent_transaction_id']!,
          _parentTransactionIdMeta,
        ),
      );
    }
    if (data.containsKey('transfer_to_account_id')) {
      context.handle(
        _transferToAccountIdMeta,
        transferToAccountId.isAcceptableOrUnknown(
          data['transfer_to_account_id']!,
          _transferToAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('transfer_to_pocket_id')) {
      context.handle(
        _transferToPocketIdMeta,
        transferToPocketId.isAcceptableOrUnknown(
          data['transfer_to_pocket_id']!,
          _transferToPocketIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: $TransactionsTable.$converteramount.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}amount'],
        )!,
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      emoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      pocketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pocket_id'],
      ),
      parentTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_transaction_id'],
      ),
      transferToAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_to_account_id'],
      ),
      transferToPocketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_to_pocket_id'],
      ),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static TypeConverter<double, int> $converteramount = const AmountConverter();
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final String id;
  final String name;
  final double amount;
  final DateTime timestamp;
  final String? notes;
  final String? emoji;
  final String accountId;
  final String? pocketId;
  final String? parentTransactionId;
  final String? transferToAccountId;
  final String? transferToPocketId;
  const Transaction({
    required this.id,
    required this.name,
    required this.amount,
    required this.timestamp,
    this.notes,
    this.emoji,
    required this.accountId,
    this.pocketId,
    this.parentTransactionId,
    this.transferToAccountId,
    this.transferToPocketId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['amount'] = Variable<int>(
        $TransactionsTable.$converteramount.toSql(amount),
      );
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || emoji != null) {
      map['emoji'] = Variable<String>(emoji);
    }
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || pocketId != null) {
      map['pocket_id'] = Variable<String>(pocketId);
    }
    if (!nullToAbsent || parentTransactionId != null) {
      map['parent_transaction_id'] = Variable<String>(parentTransactionId);
    }
    if (!nullToAbsent || transferToAccountId != null) {
      map['transfer_to_account_id'] = Variable<String>(transferToAccountId);
    }
    if (!nullToAbsent || transferToPocketId != null) {
      map['transfer_to_pocket_id'] = Variable<String>(transferToPocketId);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      name: Value(name),
      amount: Value(amount),
      timestamp: Value(timestamp),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      emoji: emoji == null && nullToAbsent
          ? const Value.absent()
          : Value(emoji),
      accountId: Value(accountId),
      pocketId: pocketId == null && nullToAbsent
          ? const Value.absent()
          : Value(pocketId),
      parentTransactionId: parentTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTransactionId),
      transferToAccountId: transferToAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(transferToAccountId),
      transferToPocketId: transferToPocketId == null && nullToAbsent
          ? const Value.absent()
          : Value(transferToPocketId),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      notes: serializer.fromJson<String?>(json['notes']),
      emoji: serializer.fromJson<String?>(json['emoji']),
      accountId: serializer.fromJson<String>(json['accountId']),
      pocketId: serializer.fromJson<String?>(json['pocketId']),
      parentTransactionId: serializer.fromJson<String?>(
        json['parentTransactionId'],
      ),
      transferToAccountId: serializer.fromJson<String?>(
        json['transferToAccountId'],
      ),
      transferToPocketId: serializer.fromJson<String?>(
        json['transferToPocketId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'notes': serializer.toJson<String?>(notes),
      'emoji': serializer.toJson<String?>(emoji),
      'accountId': serializer.toJson<String>(accountId),
      'pocketId': serializer.toJson<String?>(pocketId),
      'parentTransactionId': serializer.toJson<String?>(parentTransactionId),
      'transferToAccountId': serializer.toJson<String?>(transferToAccountId),
      'transferToPocketId': serializer.toJson<String?>(transferToPocketId),
    };
  }

  Transaction copyWith({
    String? id,
    String? name,
    double? amount,
    DateTime? timestamp,
    Value<String?> notes = const Value.absent(),
    Value<String?> emoji = const Value.absent(),
    String? accountId,
    Value<String?> pocketId = const Value.absent(),
    Value<String?> parentTransactionId = const Value.absent(),
    Value<String?> transferToAccountId = const Value.absent(),
    Value<String?> transferToPocketId = const Value.absent(),
  }) => Transaction(
    id: id ?? this.id,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    timestamp: timestamp ?? this.timestamp,
    notes: notes.present ? notes.value : this.notes,
    emoji: emoji.present ? emoji.value : this.emoji,
    accountId: accountId ?? this.accountId,
    pocketId: pocketId.present ? pocketId.value : this.pocketId,
    parentTransactionId: parentTransactionId.present
        ? parentTransactionId.value
        : this.parentTransactionId,
    transferToAccountId: transferToAccountId.present
        ? transferToAccountId.value
        : this.transferToAccountId,
    transferToPocketId: transferToPocketId.present
        ? transferToPocketId.value
        : this.transferToPocketId,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      notes: data.notes.present ? data.notes.value : this.notes,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      pocketId: data.pocketId.present ? data.pocketId.value : this.pocketId,
      parentTransactionId: data.parentTransactionId.present
          ? data.parentTransactionId.value
          : this.parentTransactionId,
      transferToAccountId: data.transferToAccountId.present
          ? data.transferToAccountId.value
          : this.transferToAccountId,
      transferToPocketId: data.transferToPocketId.present
          ? data.transferToPocketId.value
          : this.transferToPocketId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes, ')
          ..write('emoji: $emoji, ')
          ..write('accountId: $accountId, ')
          ..write('pocketId: $pocketId, ')
          ..write('parentTransactionId: $parentTransactionId, ')
          ..write('transferToAccountId: $transferToAccountId, ')
          ..write('transferToPocketId: $transferToPocketId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    amount,
    timestamp,
    notes,
    emoji,
    accountId,
    pocketId,
    parentTransactionId,
    transferToAccountId,
    transferToPocketId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.timestamp == this.timestamp &&
          other.notes == this.notes &&
          other.emoji == this.emoji &&
          other.accountId == this.accountId &&
          other.pocketId == this.pocketId &&
          other.parentTransactionId == this.parentTransactionId &&
          other.transferToAccountId == this.transferToAccountId &&
          other.transferToPocketId == this.transferToPocketId);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> amount;
  final Value<DateTime> timestamp;
  final Value<String?> notes;
  final Value<String?> emoji;
  final Value<String> accountId;
  final Value<String?> pocketId;
  final Value<String?> parentTransactionId;
  final Value<String?> transferToAccountId;
  final Value<String?> transferToPocketId;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
    this.emoji = const Value.absent(),
    this.accountId = const Value.absent(),
    this.pocketId = const Value.absent(),
    this.parentTransactionId = const Value.absent(),
    this.transferToAccountId = const Value.absent(),
    this.transferToPocketId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double amount,
    required DateTime timestamp,
    this.notes = const Value.absent(),
    this.emoji = const Value.absent(),
    required String accountId,
    this.pocketId = const Value.absent(),
    this.parentTransactionId = const Value.absent(),
    this.transferToAccountId = const Value.absent(),
    this.transferToPocketId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       amount = Value(amount),
       timestamp = Value(timestamp),
       accountId = Value(accountId);
  static Insertable<Transaction> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? amount,
    Expression<DateTime>? timestamp,
    Expression<String>? notes,
    Expression<String>? emoji,
    Expression<String>? accountId,
    Expression<String>? pocketId,
    Expression<String>? parentTransactionId,
    Expression<String>? transferToAccountId,
    Expression<String>? transferToPocketId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (timestamp != null) 'timestamp': timestamp,
      if (notes != null) 'notes': notes,
      if (emoji != null) 'emoji': emoji,
      if (accountId != null) 'account_id': accountId,
      if (pocketId != null) 'pocket_id': pocketId,
      if (parentTransactionId != null)
        'parent_transaction_id': parentTransactionId,
      if (transferToAccountId != null)
        'transfer_to_account_id': transferToAccountId,
      if (transferToPocketId != null)
        'transfer_to_pocket_id': transferToPocketId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? amount,
    Value<DateTime>? timestamp,
    Value<String?>? notes,
    Value<String?>? emoji,
    Value<String>? accountId,
    Value<String?>? pocketId,
    Value<String?>? parentTransactionId,
    Value<String?>? transferToAccountId,
    Value<String?>? transferToPocketId,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
      emoji: emoji ?? this.emoji,
      accountId: accountId ?? this.accountId,
      pocketId: pocketId ?? this.pocketId,
      parentTransactionId: parentTransactionId ?? this.parentTransactionId,
      transferToAccountId: transferToAccountId ?? this.transferToAccountId,
      transferToPocketId: transferToPocketId ?? this.transferToPocketId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(
        $TransactionsTable.$converteramount.toSql(amount.value),
      );
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (pocketId.present) {
      map['pocket_id'] = Variable<String>(pocketId.value);
    }
    if (parentTransactionId.present) {
      map['parent_transaction_id'] = Variable<String>(
        parentTransactionId.value,
      );
    }
    if (transferToAccountId.present) {
      map['transfer_to_account_id'] = Variable<String>(
        transferToAccountId.value,
      );
    }
    if (transferToPocketId.present) {
      map['transfer_to_pocket_id'] = Variable<String>(transferToPocketId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes, ')
          ..write('emoji: $emoji, ')
          ..write('accountId: $accountId, ')
          ..write('pocketId: $pocketId, ')
          ..write('parentTransactionId: $parentTransactionId, ')
          ..write('transferToAccountId: $transferToAccountId, ')
          ..write('transferToPocketId: $transferToPocketId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PocketsTable pockets = $PocketsTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pockets,
    accounts,
    transactions,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pockets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transactions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pockets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$PocketsTableCreateCompanionBuilder =
    PocketsCompanion Function({
      Value<String> id,
      required String name,
      required int iconCodePoint,
      Value<String?> iconFontFamily,
      Value<int?> colorValue,
      Value<int> rowid,
    });
typedef $$PocketsTableUpdateCompanionBuilder =
    PocketsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> iconCodePoint,
      Value<String?> iconFontFamily,
      Value<int?> colorValue,
      Value<int> rowid,
    });

class $$PocketsTableFilterComposer
    extends Composer<_$AppDatabase, $PocketsTable> {
  $$PocketsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconFontFamily => $composableBuilder(
    column: $table.iconFontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PocketsTableOrderingComposer
    extends Composer<_$AppDatabase, $PocketsTable> {
  $$PocketsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconFontFamily => $composableBuilder(
    column: $table.iconFontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PocketsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PocketsTable> {
  $$PocketsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconFontFamily => $composableBuilder(
    column: $table.iconFontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );
}

class $$PocketsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PocketsTable,
          Pocket,
          $$PocketsTableFilterComposer,
          $$PocketsTableOrderingComposer,
          $$PocketsTableAnnotationComposer,
          $$PocketsTableCreateCompanionBuilder,
          $$PocketsTableUpdateCompanionBuilder,
          (Pocket, BaseReferences<_$AppDatabase, $PocketsTable, Pocket>),
          Pocket,
          PrefetchHooks Function()
        > {
  $$PocketsTableTableManager(_$AppDatabase db, $PocketsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PocketsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PocketsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PocketsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> iconCodePoint = const Value.absent(),
                Value<String?> iconFontFamily = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PocketsCompanion(
                id: id,
                name: name,
                iconCodePoint: iconCodePoint,
                iconFontFamily: iconFontFamily,
                colorValue: colorValue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required int iconCodePoint,
                Value<String?> iconFontFamily = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PocketsCompanion.insert(
                id: id,
                name: name,
                iconCodePoint: iconCodePoint,
                iconFontFamily: iconFontFamily,
                colorValue: colorValue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PocketsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PocketsTable,
      Pocket,
      $$PocketsTableFilterComposer,
      $$PocketsTableOrderingComposer,
      $$PocketsTableAnnotationComposer,
      $$PocketsTableCreateCompanionBuilder,
      $$PocketsTableUpdateCompanionBuilder,
      (Pocket, BaseReferences<_$AppDatabase, $PocketsTable, Pocket>),
      Pocket,
      PrefetchHooks Function()
    >;
typedef $$AccountsTableCreateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> id,
      required String name,
      required String currency,
      required int iconCodePoint,
      Value<String?> iconFontFamily,
      Value<int?> colorValue,
      Value<int> rowid,
    });
typedef $$AccountsTableUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> currency,
      Value<int> iconCodePoint,
      Value<String?> iconFontFamily,
      Value<int?> colorValue,
      Value<int> rowid,
    });

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconFontFamily => $composableBuilder(
    column: $table.iconFontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconFontFamily => $composableBuilder(
    column: $table.iconFontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconFontFamily => $composableBuilder(
    column: $table.iconFontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, BaseReferences<_$AppDatabase, $AccountsTable, Account>),
          Account,
          PrefetchHooks Function()
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> iconCodePoint = const Value.absent(),
                Value<String?> iconFontFamily = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                name: name,
                currency: currency,
                iconCodePoint: iconCodePoint,
                iconFontFamily: iconFontFamily,
                colorValue: colorValue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required String currency,
                required int iconCodePoint,
                Value<String?> iconFontFamily = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                name: name,
                currency: currency,
                iconCodePoint: iconCodePoint,
                iconFontFamily: iconFontFamily,
                colorValue: colorValue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, BaseReferences<_$AppDatabase, $AccountsTable, Account>),
      Account,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      required String name,
      required double amount,
      required DateTime timestamp,
      Value<String?> notes,
      Value<String?> emoji,
      required String accountId,
      Value<String?> pocketId,
      Value<String?> parentTransactionId,
      Value<String?> transferToAccountId,
      Value<String?> transferToPocketId,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> amount,
      Value<DateTime> timestamp,
      Value<String?> notes,
      Value<String?> emoji,
      Value<String> accountId,
      Value<String?> pocketId,
      Value<String?> parentTransactionId,
      Value<String?> transferToAccountId,
      Value<String?> transferToPocketId,
      Value<int> rowid,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias(
        $_aliasNameGenerator(db.transactions.accountId, db.accounts.id),
      );

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PocketsTable _pocketIdTable(_$AppDatabase db) =>
      db.pockets.createAlias(
        $_aliasNameGenerator(db.transactions.pocketId, db.pockets.id),
      );

  $$PocketsTableProcessedTableManager? get pocketId {
    final $_column = $_itemColumn<String>('pocket_id');
    if ($_column == null) return null;
    final manager = $$PocketsTableTableManager(
      $_db,
      $_db.pockets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pocketIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TransactionsTable _parentTransactionIdTable(_$AppDatabase db) =>
      db.transactions.createAlias(
        $_aliasNameGenerator(
          db.transactions.parentTransactionId,
          db.transactions.id,
        ),
      );

  $$TransactionsTableProcessedTableManager? get parentTransactionId {
    final $_column = $_itemColumn<String>('parent_transaction_id');
    if ($_column == null) return null;
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentTransactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _transferToAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias(
        $_aliasNameGenerator(
          db.transactions.transferToAccountId,
          db.accounts.id,
        ),
      );

  $$AccountsTableProcessedTableManager? get transferToAccountId {
    final $_column = $_itemColumn<String>('transfer_to_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transferToAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PocketsTable _transferToPocketIdTable(_$AppDatabase db) =>
      db.pockets.createAlias(
        $_aliasNameGenerator(db.transactions.transferToPocketId, db.pockets.id),
      );

  $$PocketsTableProcessedTableManager? get transferToPocketId {
    final $_column = $_itemColumn<String>('transfer_to_pocket_id');
    if ($_column == null) return null;
    final manager = $$PocketsTableTableManager(
      $_db,
      $_db.pockets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transferToPocketIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<double, double, int> get amount =>
      $composableBuilder(
        column: $table.amount,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PocketsTableFilterComposer get pocketId {
    final $$PocketsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pocketId,
      referencedTable: $db.pockets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PocketsTableFilterComposer(
            $db: $db,
            $table: $db.pockets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionsTableFilterComposer get parentTransactionId {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentTransactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get transferToAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transferToAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PocketsTableFilterComposer get transferToPocketId {
    final $$PocketsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transferToPocketId,
      referencedTable: $db.pockets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PocketsTableFilterComposer(
            $db: $db,
            $table: $db.pockets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PocketsTableOrderingComposer get pocketId {
    final $$PocketsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pocketId,
      referencedTable: $db.pockets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PocketsTableOrderingComposer(
            $db: $db,
            $table: $db.pockets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionsTableOrderingComposer get parentTransactionId {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentTransactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get transferToAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transferToAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PocketsTableOrderingComposer get transferToPocketId {
    final $$PocketsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transferToPocketId,
      referencedTable: $db.pockets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PocketsTableOrderingComposer(
            $db: $db,
            $table: $db.pockets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<double, int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PocketsTableAnnotationComposer get pocketId {
    final $$PocketsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pocketId,
      referencedTable: $db.pockets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PocketsTableAnnotationComposer(
            $db: $db,
            $table: $db.pockets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionsTableAnnotationComposer get parentTransactionId {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentTransactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get transferToAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transferToAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PocketsTableAnnotationComposer get transferToPocketId {
    final $$PocketsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transferToPocketId,
      referencedTable: $db.pockets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PocketsTableAnnotationComposer(
            $db: $db,
            $table: $db.pockets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({
            bool accountId,
            bool pocketId,
            bool parentTransactionId,
            bool transferToAccountId,
            bool transferToPocketId,
          })
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> emoji = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String?> pocketId = const Value.absent(),
                Value<String?> parentTransactionId = const Value.absent(),
                Value<String?> transferToAccountId = const Value.absent(),
                Value<String?> transferToPocketId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                name: name,
                amount: amount,
                timestamp: timestamp,
                notes: notes,
                emoji: emoji,
                accountId: accountId,
                pocketId: pocketId,
                parentTransactionId: parentTransactionId,
                transferToAccountId: transferToAccountId,
                transferToPocketId: transferToPocketId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required double amount,
                required DateTime timestamp,
                Value<String?> notes = const Value.absent(),
                Value<String?> emoji = const Value.absent(),
                required String accountId,
                Value<String?> pocketId = const Value.absent(),
                Value<String?> parentTransactionId = const Value.absent(),
                Value<String?> transferToAccountId = const Value.absent(),
                Value<String?> transferToPocketId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                name: name,
                amount: amount,
                timestamp: timestamp,
                notes: notes,
                emoji: emoji,
                accountId: accountId,
                pocketId: pocketId,
                parentTransactionId: parentTransactionId,
                transferToAccountId: transferToAccountId,
                transferToPocketId: transferToPocketId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                pocketId = false,
                parentTransactionId = false,
                transferToAccountId = false,
                transferToPocketId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (pocketId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.pocketId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._pocketIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._pocketIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (parentTransactionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.parentTransactionId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._parentTransactionIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._parentTransactionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (transferToAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.transferToAccountId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._transferToAccountIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._transferToAccountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (transferToPocketId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.transferToPocketId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._transferToPocketIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._transferToPocketIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({
        bool accountId,
        bool pocketId,
        bool parentTransactionId,
        bool transferToAccountId,
        bool transferToPocketId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PocketsTableTableManager get pockets =>
      $$PocketsTableTableManager(_db, _db.pockets);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
