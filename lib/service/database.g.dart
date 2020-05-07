// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Alarm extends DataClass implements Insertable<Alarm> {
  final bool hasRang;
  final DateTime ringTime;
  final int id;
  Alarm({@required this.hasRang, @required this.ringTime, @required this.id});
  factory Alarm.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    return Alarm(
      hasRang:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}has_rang']),
      ringTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}ring_time']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
    );
  }
  factory Alarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Alarm(
      hasRang: serializer.fromJson<bool>(json['hasRang']),
      ringTime: serializer.fromJson<DateTime>(json['ringTime']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'hasRang': serializer.toJson<bool>(hasRang),
      'ringTime': serializer.toJson<DateTime>(ringTime),
      'id': serializer.toJson<int>(id),
    };
  }

  @override
  AlarmsCompanion createCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      hasRang: hasRang == null && nullToAbsent
          ? const Value.absent()
          : Value(hasRang),
      ringTime: ringTime == null && nullToAbsent
          ? const Value.absent()
          : Value(ringTime),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
    );
  }

  Alarm copyWith({bool hasRang, DateTime ringTime, int id}) => Alarm(
        hasRang: hasRang ?? this.hasRang,
        ringTime: ringTime ?? this.ringTime,
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('Alarm(')
          ..write('hasRang: $hasRang, ')
          ..write('ringTime: $ringTime, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(hasRang.hashCode, $mrjc(ringTime.hashCode, id.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Alarm &&
          other.hasRang == this.hasRang &&
          other.ringTime == this.ringTime &&
          other.id == this.id);
}

class AlarmsCompanion extends UpdateCompanion<Alarm> {
  final Value<bool> hasRang;
  final Value<DateTime> ringTime;
  final Value<int> id;
  const AlarmsCompanion({
    this.hasRang = const Value.absent(),
    this.ringTime = const Value.absent(),
    this.id = const Value.absent(),
  });
  AlarmsCompanion.insert({
    this.hasRang = const Value.absent(),
    @required DateTime ringTime,
    this.id = const Value.absent(),
  }) : ringTime = Value(ringTime);
  AlarmsCompanion copyWith(
      {Value<bool> hasRang, Value<DateTime> ringTime, Value<int> id}) {
    return AlarmsCompanion(
      hasRang: hasRang ?? this.hasRang,
      ringTime: ringTime ?? this.ringTime,
      id: id ?? this.id,
    );
  }
}

class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, Alarm> {
  final GeneratedDatabase _db;
  final String _alias;
  $AlarmsTable(this._db, [this._alias]);
  final VerificationMeta _hasRangMeta = const VerificationMeta('hasRang');
  GeneratedBoolColumn _hasRang;
  @override
  GeneratedBoolColumn get hasRang => _hasRang ??= _constructHasRang();
  GeneratedBoolColumn _constructHasRang() {
    return GeneratedBoolColumn('has_rang', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _ringTimeMeta = const VerificationMeta('ringTime');
  GeneratedDateTimeColumn _ringTime;
  @override
  GeneratedDateTimeColumn get ringTime => _ringTime ??= _constructRingTime();
  GeneratedDateTimeColumn _constructRingTime() {
    return GeneratedDateTimeColumn(
      'ring_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  @override
  List<GeneratedColumn> get $columns => [hasRang, ringTime, id];
  @override
  $AlarmsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'alarms';
  @override
  final String actualTableName = 'alarms';
  @override
  VerificationContext validateIntegrity(AlarmsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.hasRang.present) {
      context.handle(_hasRangMeta,
          hasRang.isAcceptableValue(d.hasRang.value, _hasRangMeta));
    }
    if (d.ringTime.present) {
      context.handle(_ringTimeMeta,
          ringTime.isAcceptableValue(d.ringTime.value, _ringTimeMeta));
    } else if (isInserting) {
      context.missing(_ringTimeMeta);
    }
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alarm map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Alarm.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AlarmsCompanion d) {
    final map = <String, Variable>{};
    if (d.hasRang.present) {
      map['has_rang'] = Variable<bool, BoolType>(d.hasRang.value);
    }
    if (d.ringTime.present) {
      map['ring_time'] = Variable<DateTime, DateTimeType>(d.ringTime.value);
    }
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    return map;
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(_db, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final int tag;
  final String name;
  final DateTime dueDate;
  final bool isCompleted;
  Task(
      {@required this.id,
      @required this.tag,
      @required this.name,
      @required this.dueDate,
      @required this.isCompleted});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      tag: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      dueDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      isCompleted: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_completed']),
    );
  }
  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<int>(json['tag']),
      name: serializer.fromJson<String>(json['name']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<int>(tag),
      'name': serializer.toJson<String>(name),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  @override
  TasksCompanion createCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      isCompleted: isCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(isCompleted),
    );
  }

  Task copyWith(
          {int id, int tag, String name, DateTime dueDate, bool isCompleted}) =>
      Task(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        name: name ?? this.name,
        dueDate: dueDate ?? this.dueDate,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('name: $name, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          tag.hashCode,
          $mrjc(
              name.hashCode, $mrjc(dueDate.hashCode, isCompleted.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.tag == this.tag &&
          other.name == this.name &&
          other.dueDate == this.dueDate &&
          other.isCompleted == this.isCompleted);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<int> tag;
  final Value<String> name;
  final Value<DateTime> dueDate;
  final Value<bool> isCompleted;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.name = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    @required int tag,
    @required String name,
    @required DateTime dueDate,
    this.isCompleted = const Value.absent(),
  })  : tag = Value(tag),
        name = Value(name),
        dueDate = Value(dueDate);
  TasksCompanion copyWith(
      {Value<int> id,
      Value<int> tag,
      Value<String> name,
      Value<DateTime> dueDate,
      Value<bool> isCompleted}) {
    return TasksCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  GeneratedIntColumn _tag;
  @override
  GeneratedIntColumn get tag => _tag ??= _constructTag();
  GeneratedIntColumn _constructTag() {
    return GeneratedIntColumn('tag', $tableName, false,
        $customConstraints: 'REFERENCES tags(id)');
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 2, maxTextLength: 100);
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedDateTimeColumn _dueDate;
  @override
  GeneratedDateTimeColumn get dueDate => _dueDate ??= _constructDueDate();
  GeneratedDateTimeColumn _constructDueDate() {
    return GeneratedDateTimeColumn(
      'due_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  GeneratedBoolColumn _isCompleted;
  @override
  GeneratedBoolColumn get isCompleted =>
      _isCompleted ??= _constructIsCompleted();
  GeneratedBoolColumn _constructIsCompleted() {
    return GeneratedBoolColumn('is_completed', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, tag, name, dueDate, isCompleted];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(TasksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.tag.present) {
      context.handle(_tagMeta, tag.isAcceptableValue(d.tag.value, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.dueDate.present) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableValue(d.dueDate.value, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (d.isCompleted.present) {
      context.handle(_isCompletedMeta,
          isCompleted.isAcceptableValue(d.isCompleted.value, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, name};
  @override
  Task map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Task.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TasksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.tag.present) {
      map['tag'] = Variable<int, IntType>(d.tag.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.dueDate.present) {
      map['due_date'] = Variable<DateTime, DateTimeType>(d.dueDate.value);
    }
    if (d.isCompleted.present) {
      map['is_completed'] = Variable<bool, BoolType>(d.isCompleted.value);
    }
    return map;
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final int tag;
  final String evName;
  final String description;
  final DateTime endDate;
  final DateTime startDate;
  final bool isHappened;
  Event(
      {@required this.id,
      @required this.tag,
      @required this.evName,
      @required this.description,
      @required this.endDate,
      @required this.startDate,
      @required this.isHappened});
  factory Event.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Event(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      tag: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag']),
      evName:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}ev_name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      endDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}end_date']),
      startDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}start_date']),
      isHappened: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_happened']),
    );
  }
  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<int>(json['tag']),
      evName: serializer.fromJson<String>(json['evName']),
      description: serializer.fromJson<String>(json['description']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      isHappened: serializer.fromJson<bool>(json['isHappened']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<int>(tag),
      'evName': serializer.toJson<String>(evName),
      'description': serializer.toJson<String>(description),
      'endDate': serializer.toJson<DateTime>(endDate),
      'startDate': serializer.toJson<DateTime>(startDate),
      'isHappened': serializer.toJson<bool>(isHappened),
    };
  }

  @override
  EventsCompanion createCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      evName:
          evName == null && nullToAbsent ? const Value.absent() : Value(evName),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      isHappened: isHappened == null && nullToAbsent
          ? const Value.absent()
          : Value(isHappened),
    );
  }

  Event copyWith(
          {int id,
          int tag,
          String evName,
          String description,
          DateTime endDate,
          DateTime startDate,
          bool isHappened}) =>
      Event(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        evName: evName ?? this.evName,
        description: description ?? this.description,
        endDate: endDate ?? this.endDate,
        startDate: startDate ?? this.startDate,
        isHappened: isHappened ?? this.isHappened,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('evName: $evName, ')
          ..write('description: $description, ')
          ..write('endDate: $endDate, ')
          ..write('startDate: $startDate, ')
          ..write('isHappened: $isHappened')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          tag.hashCode,
          $mrjc(
              evName.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(endDate.hashCode,
                      $mrjc(startDate.hashCode, isHappened.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.tag == this.tag &&
          other.evName == this.evName &&
          other.description == this.description &&
          other.endDate == this.endDate &&
          other.startDate == this.startDate &&
          other.isHappened == this.isHappened);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<int> tag;
  final Value<String> evName;
  final Value<String> description;
  final Value<DateTime> endDate;
  final Value<DateTime> startDate;
  final Value<bool> isHappened;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.evName = const Value.absent(),
    this.description = const Value.absent(),
    this.endDate = const Value.absent(),
    this.startDate = const Value.absent(),
    this.isHappened = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    @required int tag,
    @required String evName,
    @required String description,
    @required DateTime endDate,
    @required DateTime startDate,
    this.isHappened = const Value.absent(),
  })  : tag = Value(tag),
        evName = Value(evName),
        description = Value(description),
        endDate = Value(endDate),
        startDate = Value(startDate);
  EventsCompanion copyWith(
      {Value<int> id,
      Value<int> tag,
      Value<String> evName,
      Value<String> description,
      Value<DateTime> endDate,
      Value<DateTime> startDate,
      Value<bool> isHappened}) {
    return EventsCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      evName: evName ?? this.evName,
      description: description ?? this.description,
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      isHappened: isHappened ?? this.isHappened,
    );
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  GeneratedIntColumn _tag;
  @override
  GeneratedIntColumn get tag => _tag ??= _constructTag();
  GeneratedIntColumn _constructTag() {
    return GeneratedIntColumn('tag', $tableName, false,
        $customConstraints: 'REFERENCES tags(id)');
  }

  final VerificationMeta _evNameMeta = const VerificationMeta('evName');
  GeneratedTextColumn _evName;
  @override
  GeneratedTextColumn get evName => _evName ??= _constructEvName();
  GeneratedTextColumn _constructEvName() {
    return GeneratedTextColumn('ev_name', $tableName, false,
        minTextLength: 2, maxTextLength: 100);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        minTextLength: 2, maxTextLength: 255);
  }

  final VerificationMeta _endDateMeta = const VerificationMeta('endDate');
  GeneratedDateTimeColumn _endDate;
  @override
  GeneratedDateTimeColumn get endDate => _endDate ??= _constructEndDate();
  GeneratedDateTimeColumn _constructEndDate() {
    return GeneratedDateTimeColumn(
      'end_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  GeneratedDateTimeColumn _startDate;
  @override
  GeneratedDateTimeColumn get startDate => _startDate ??= _constructStartDate();
  GeneratedDateTimeColumn _constructStartDate() {
    return GeneratedDateTimeColumn(
      'start_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isHappenedMeta = const VerificationMeta('isHappened');
  GeneratedBoolColumn _isHappened;
  @override
  GeneratedBoolColumn get isHappened => _isHappened ??= _constructIsHappened();
  GeneratedBoolColumn _constructIsHappened() {
    return GeneratedBoolColumn('is_happened', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, tag, evName, description, endDate, startDate, isHappened];
  @override
  $EventsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'events';
  @override
  final String actualTableName = 'events';
  @override
  VerificationContext validateIntegrity(EventsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.tag.present) {
      context.handle(_tagMeta, tag.isAcceptableValue(d.tag.value, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (d.evName.present) {
      context.handle(
          _evNameMeta, evName.isAcceptableValue(d.evName.value, _evNameMeta));
    } else if (isInserting) {
      context.missing(_evNameMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.endDate.present) {
      context.handle(_endDateMeta,
          endDate.isAcceptableValue(d.endDate.value, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (d.startDate.present) {
      context.handle(_startDateMeta,
          startDate.isAcceptableValue(d.startDate.value, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (d.isHappened.present) {
      context.handle(_isHappenedMeta,
          isHappened.isAcceptableValue(d.isHappened.value, _isHappenedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, evName};
  @override
  Event map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Event.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(EventsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.tag.present) {
      map['tag'] = Variable<int, IntType>(d.tag.value);
    }
    if (d.evName.present) {
      map['ev_name'] = Variable<String, StringType>(d.evName.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.endDate.present) {
      map['end_date'] = Variable<DateTime, DateTimeType>(d.endDate.value);
    }
    if (d.startDate.present) {
      map['start_date'] = Variable<DateTime, DateTimeType>(d.startDate.value);
    }
    if (d.isHappened.present) {
      map['is_happened'] = Variable<bool, BoolType>(d.isHappened.value);
    }
    return map;
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  final int color;
  Tag({@required this.id, @required this.name, @required this.color});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Tag(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
    };
  }

  @override
  TagsCompanion createCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  Tag copyWith({int id, String name, int color}) => Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, color.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> color;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required int color,
  })  : name = Value(name),
        color = Value(color);
  TagsCompanion copyWith(
      {Value<int> id, Value<String> name, Value<int> color}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 2, maxTextLength: 255);
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, color];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(TagsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, name};
  @override
  Tag map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.color.present) {
      map['color'] = Variable<int, IntType>(d.color.value);
    }
    return map;
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final int id;
  final int tasksValue;
  final int tag;
  final String projectName;
  final String projectDescription;
  final DateTime createdAt;
  final bool isFinished;
  Project(
      {@required this.id,
      @required this.tasksValue,
      @required this.tag,
      @required this.projectName,
      @required this.projectDescription,
      @required this.createdAt,
      @required this.isFinished});
  factory Project.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Project(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      tasksValue: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}tasks_value']),
      tag: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag']),
      projectName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}project_name']),
      projectDescription: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}project_description']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      isFinished: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_finished']),
    );
  }
  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<int>(json['id']),
      tasksValue: serializer.fromJson<int>(json['tasksValue']),
      tag: serializer.fromJson<int>(json['tag']),
      projectName: serializer.fromJson<String>(json['projectName']),
      projectDescription:
          serializer.fromJson<String>(json['projectDescription']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tasksValue': serializer.toJson<int>(tasksValue),
      'tag': serializer.toJson<int>(tag),
      'projectName': serializer.toJson<String>(projectName),
      'projectDescription': serializer.toJson<String>(projectDescription),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isFinished': serializer.toJson<bool>(isFinished),
    };
  }

  @override
  ProjectsCompanion createCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tasksValue: tasksValue == null && nullToAbsent
          ? const Value.absent()
          : Value(tasksValue),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      projectName: projectName == null && nullToAbsent
          ? const Value.absent()
          : Value(projectName),
      projectDescription: projectDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(projectDescription),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      isFinished: isFinished == null && nullToAbsent
          ? const Value.absent()
          : Value(isFinished),
    );
  }

  Project copyWith(
          {int id,
          int tasksValue,
          int tag,
          String projectName,
          String projectDescription,
          DateTime createdAt,
          bool isFinished}) =>
      Project(
        id: id ?? this.id,
        tasksValue: tasksValue ?? this.tasksValue,
        tag: tag ?? this.tag,
        projectName: projectName ?? this.projectName,
        projectDescription: projectDescription ?? this.projectDescription,
        createdAt: createdAt ?? this.createdAt,
        isFinished: isFinished ?? this.isFinished,
      );
  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('tasksValue: $tasksValue, ')
          ..write('tag: $tag, ')
          ..write('projectName: $projectName, ')
          ..write('projectDescription: $projectDescription, ')
          ..write('createdAt: $createdAt, ')
          ..write('isFinished: $isFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          tasksValue.hashCode,
          $mrjc(
              tag.hashCode,
              $mrjc(
                  projectName.hashCode,
                  $mrjc(projectDescription.hashCode,
                      $mrjc(createdAt.hashCode, isFinished.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.tasksValue == this.tasksValue &&
          other.tag == this.tag &&
          other.projectName == this.projectName &&
          other.projectDescription == this.projectDescription &&
          other.createdAt == this.createdAt &&
          other.isFinished == this.isFinished);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> id;
  final Value<int> tasksValue;
  final Value<int> tag;
  final Value<String> projectName;
  final Value<String> projectDescription;
  final Value<DateTime> createdAt;
  final Value<bool> isFinished;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.tasksValue = const Value.absent(),
    this.tag = const Value.absent(),
    this.projectName = const Value.absent(),
    this.projectDescription = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isFinished = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    @required int tasksValue,
    @required int tag,
    @required String projectName,
    @required String projectDescription,
    @required DateTime createdAt,
    this.isFinished = const Value.absent(),
  })  : tasksValue = Value(tasksValue),
        tag = Value(tag),
        projectName = Value(projectName),
        projectDescription = Value(projectDescription),
        createdAt = Value(createdAt);
  ProjectsCompanion copyWith(
      {Value<int> id,
      Value<int> tasksValue,
      Value<int> tag,
      Value<String> projectName,
      Value<String> projectDescription,
      Value<DateTime> createdAt,
      Value<bool> isFinished}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      tasksValue: tasksValue ?? this.tasksValue,
      tag: tag ?? this.tag,
      projectName: projectName ?? this.projectName,
      projectDescription: projectDescription ?? this.projectDescription,
      createdAt: createdAt ?? this.createdAt,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProjectsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _tasksValueMeta = const VerificationMeta('tasksValue');
  GeneratedIntColumn _tasksValue;
  @override
  GeneratedIntColumn get tasksValue => _tasksValue ??= _constructTasksValue();
  GeneratedIntColumn _constructTasksValue() {
    return GeneratedIntColumn(
      'tasks_value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  GeneratedIntColumn _tag;
  @override
  GeneratedIntColumn get tag => _tag ??= _constructTag();
  GeneratedIntColumn _constructTag() {
    return GeneratedIntColumn('tag', $tableName, false,
        $customConstraints: 'REFERENCES tags(id)');
  }

  final VerificationMeta _projectNameMeta =
      const VerificationMeta('projectName');
  GeneratedTextColumn _projectName;
  @override
  GeneratedTextColumn get projectName =>
      _projectName ??= _constructProjectName();
  GeneratedTextColumn _constructProjectName() {
    return GeneratedTextColumn('project_name', $tableName, false,
        minTextLength: 2, maxTextLength: 100);
  }

  final VerificationMeta _projectDescriptionMeta =
      const VerificationMeta('projectDescription');
  GeneratedTextColumn _projectDescription;
  @override
  GeneratedTextColumn get projectDescription =>
      _projectDescription ??= _constructProjectDescription();
  GeneratedTextColumn _constructProjectDescription() {
    return GeneratedTextColumn('project_description', $tableName, false,
        minTextLength: 2, maxTextLength: 255);
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isFinishedMeta = const VerificationMeta('isFinished');
  GeneratedBoolColumn _isFinished;
  @override
  GeneratedBoolColumn get isFinished => _isFinished ??= _constructIsFinished();
  GeneratedBoolColumn _constructIsFinished() {
    return GeneratedBoolColumn('is_finished', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        tasksValue,
        tag,
        projectName,
        projectDescription,
        createdAt,
        isFinished
      ];
  @override
  $ProjectsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'projects';
  @override
  final String actualTableName = 'projects';
  @override
  VerificationContext validateIntegrity(ProjectsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.tasksValue.present) {
      context.handle(_tasksValueMeta,
          tasksValue.isAcceptableValue(d.tasksValue.value, _tasksValueMeta));
    } else if (isInserting) {
      context.missing(_tasksValueMeta);
    }
    if (d.tag.present) {
      context.handle(_tagMeta, tag.isAcceptableValue(d.tag.value, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (d.projectName.present) {
      context.handle(_projectNameMeta,
          projectName.isAcceptableValue(d.projectName.value, _projectNameMeta));
    } else if (isInserting) {
      context.missing(_projectNameMeta);
    }
    if (d.projectDescription.present) {
      context.handle(
          _projectDescriptionMeta,
          projectDescription.isAcceptableValue(
              d.projectDescription.value, _projectDescriptionMeta));
    } else if (isInserting) {
      context.missing(_projectDescriptionMeta);
    }
    if (d.createdAt.present) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableValue(d.createdAt.value, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (d.isFinished.present) {
      context.handle(_isFinishedMeta,
          isFinished.isAcceptableValue(d.isFinished.value, _isFinishedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, projectName};
  @override
  Project map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Project.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProjectsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.tasksValue.present) {
      map['tasks_value'] = Variable<int, IntType>(d.tasksValue.value);
    }
    if (d.tag.present) {
      map['tag'] = Variable<int, IntType>(d.tag.value);
    }
    if (d.projectName.present) {
      map['project_name'] = Variable<String, StringType>(d.projectName.value);
    }
    if (d.projectDescription.present) {
      map['project_description'] =
          Variable<String, StringType>(d.projectDescription.value);
    }
    if (d.createdAt.present) {
      map['created_at'] = Variable<DateTime, DateTimeType>(d.createdAt.value);
    }
    if (d.isFinished.present) {
      map['is_finished'] = Variable<bool, BoolType>(d.isFinished.value);
    }
    return map;
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(_db, alias);
  }
}

class SubTask extends DataClass implements Insertable<SubTask> {
  final int id;
  final int tag;
  final int project;
  final String name;
  final bool isEnd;
  final DateTime createdDate;
  SubTask(
      {@required this.id,
      @required this.tag,
      @required this.project,
      @required this.name,
      @required this.isEnd,
      @required this.createdDate});
  factory SubTask.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return SubTask(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      tag: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag']),
      project:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}project']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      isEnd: boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_end']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
    );
  }
  factory SubTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SubTask(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<int>(json['tag']),
      project: serializer.fromJson<int>(json['project']),
      name: serializer.fromJson<String>(json['name']),
      isEnd: serializer.fromJson<bool>(json['isEnd']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<int>(tag),
      'project': serializer.toJson<int>(project),
      'name': serializer.toJson<String>(name),
      'isEnd': serializer.toJson<bool>(isEnd),
      'createdDate': serializer.toJson<DateTime>(createdDate),
    };
  }

  @override
  SubTasksCompanion createCompanion(bool nullToAbsent) {
    return SubTasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      project: project == null && nullToAbsent
          ? const Value.absent()
          : Value(project),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      isEnd:
          isEnd == null && nullToAbsent ? const Value.absent() : Value(isEnd),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
    );
  }

  SubTask copyWith(
          {int id,
          int tag,
          int project,
          String name,
          bool isEnd,
          DateTime createdDate}) =>
      SubTask(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        project: project ?? this.project,
        name: name ?? this.name,
        isEnd: isEnd ?? this.isEnd,
        createdDate: createdDate ?? this.createdDate,
      );
  @override
  String toString() {
    return (StringBuffer('SubTask(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('project: $project, ')
          ..write('name: $name, ')
          ..write('isEnd: $isEnd, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          tag.hashCode,
          $mrjc(
              project.hashCode,
              $mrjc(name.hashCode,
                  $mrjc(isEnd.hashCode, createdDate.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SubTask &&
          other.id == this.id &&
          other.tag == this.tag &&
          other.project == this.project &&
          other.name == this.name &&
          other.isEnd == this.isEnd &&
          other.createdDate == this.createdDate);
}

class SubTasksCompanion extends UpdateCompanion<SubTask> {
  final Value<int> id;
  final Value<int> tag;
  final Value<int> project;
  final Value<String> name;
  final Value<bool> isEnd;
  final Value<DateTime> createdDate;
  const SubTasksCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.project = const Value.absent(),
    this.name = const Value.absent(),
    this.isEnd = const Value.absent(),
    this.createdDate = const Value.absent(),
  });
  SubTasksCompanion.insert({
    this.id = const Value.absent(),
    @required int tag,
    @required int project,
    @required String name,
    this.isEnd = const Value.absent(),
    this.createdDate = const Value.absent(),
  })  : tag = Value(tag),
        project = Value(project),
        name = Value(name);
  SubTasksCompanion copyWith(
      {Value<int> id,
      Value<int> tag,
      Value<int> project,
      Value<String> name,
      Value<bool> isEnd,
      Value<DateTime> createdDate}) {
    return SubTasksCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      project: project ?? this.project,
      name: name ?? this.name,
      isEnd: isEnd ?? this.isEnd,
      createdDate: createdDate ?? this.createdDate,
    );
  }
}

class $SubTasksTable extends SubTasks with TableInfo<$SubTasksTable, SubTask> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubTasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  GeneratedIntColumn _tag;
  @override
  GeneratedIntColumn get tag => _tag ??= _constructTag();
  GeneratedIntColumn _constructTag() {
    return GeneratedIntColumn('tag', $tableName, false,
        $customConstraints: 'REFERENCES tags(id)');
  }

  final VerificationMeta _projectMeta = const VerificationMeta('project');
  GeneratedIntColumn _project;
  @override
  GeneratedIntColumn get project => _project ??= _constructProject();
  GeneratedIntColumn _constructProject() {
    return GeneratedIntColumn('project', $tableName, false,
        $customConstraints: 'REFERENCES projects(id)');
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 5, maxTextLength: 150);
  }

  final VerificationMeta _isEndMeta = const VerificationMeta('isEnd');
  GeneratedBoolColumn _isEnd;
  @override
  GeneratedBoolColumn get isEnd => _isEnd ??= _constructIsEnd();
  GeneratedBoolColumn _constructIsEnd() {
    return GeneratedBoolColumn('is_end', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn('created_date', $tableName, false,
        defaultValue: Constant(DateTime.now()));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, tag, project, name, isEnd, createdDate];
  @override
  $SubTasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sub_tasks';
  @override
  final String actualTableName = 'sub_tasks';
  @override
  VerificationContext validateIntegrity(SubTasksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.tag.present) {
      context.handle(_tagMeta, tag.isAcceptableValue(d.tag.value, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (d.project.present) {
      context.handle(_projectMeta,
          project.isAcceptableValue(d.project.value, _projectMeta));
    } else if (isInserting) {
      context.missing(_projectMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.isEnd.present) {
      context.handle(
          _isEndMeta, isEnd.isAcceptableValue(d.isEnd.value, _isEndMeta));
    }
    if (d.createdDate.present) {
      context.handle(_createdDateMeta,
          createdDate.isAcceptableValue(d.createdDate.value, _createdDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, name};
  @override
  SubTask map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SubTask.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SubTasksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.tag.present) {
      map['tag'] = Variable<int, IntType>(d.tag.value);
    }
    if (d.project.present) {
      map['project'] = Variable<int, IntType>(d.project.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.isEnd.present) {
      map['is_end'] = Variable<bool, BoolType>(d.isEnd.value);
    }
    if (d.createdDate.present) {
      map['created_date'] =
          Variable<DateTime, DateTimeType>(d.createdDate.value);
    }
    return map;
  }

  @override
  $SubTasksTable createAlias(String alias) {
    return $SubTasksTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AlarmsTable _alarms;
  $AlarmsTable get alarms => _alarms ??= $AlarmsTable(this);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  $EventsTable _events;
  $EventsTable get events => _events ??= $EventsTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  $ProjectsTable _projects;
  $ProjectsTable get projects => _projects ??= $ProjectsTable(this);
  $SubTasksTable _subTasks;
  $SubTasksTable get subTasks => _subTasks ??= $SubTasksTable(this);
  AlarmDao _alarmDao;
  AlarmDao get alarmDao => _alarmDao ??= AlarmDao(this as AppDatabase);
  TaskDao _taskDao;
  TaskDao get taskDao => _taskDao ??= TaskDao(this as AppDatabase);
  EventDao _eventDao;
  EventDao get eventDao => _eventDao ??= EventDao(this as AppDatabase);
  TagDao _tagDao;
  TagDao get tagDao => _tagDao ??= TagDao(this as AppDatabase);
  SubTaskDao _subTaskDao;
  SubTaskDao get subTaskDao => _subTaskDao ??= SubTaskDao(this as AppDatabase);
  ProjectDao _projectDao;
  ProjectDao get projectDao => _projectDao ??= ProjectDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [alarms, tasks, events, tags, projects, subTasks];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$AlarmDaoMixin on DatabaseAccessor<AppDatabase> {
  $AlarmsTable get alarms => db.alarms;
}
mixin _$EventDaoMixin on DatabaseAccessor<AppDatabase> {
  $EventsTable get events => db.events;
  $TagsTable get tags => db.tags;
}
mixin _$ProjectDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProjectsTable get projects => db.projects;
  $SubTasksTable get subTasks => db.subTasks;
  $TagsTable get tags => db.tags;
}
mixin _$SubTaskDaoMixin on DatabaseAccessor<AppDatabase> {
  $SubTasksTable get subTasks => db.subTasks;
}
mixin _$TagDaoMixin on DatabaseAccessor<AppDatabase> {
  $TagsTable get tags => db.tags;
}
mixin _$TaskDaoMixin on DatabaseAccessor<AppDatabase> {
  $TasksTable get tasks => db.tasks;
  $TagsTable get tags => db.tags;
}
