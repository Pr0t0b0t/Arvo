// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String name;
  final DateTime dueDate;
  final bool isCompleted;
  Task(
      {@required this.id,
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
      'name': serializer.toJson<String>(name),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  @override
  TasksCompanion createCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      isCompleted: isCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(isCompleted),
    );
  }

  Task copyWith({int id, String name, DateTime dueDate, bool isCompleted}) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        dueDate: dueDate ?? this.dueDate,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(dueDate.hashCode, isCompleted.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.name == this.name &&
          other.dueDate == this.dueDate &&
          other.isCompleted == this.isCompleted);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> dueDate;
  final Value<bool> isCompleted;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required DateTime dueDate,
    this.isCompleted = const Value.absent(),
  })  : name = Value(name),
        dueDate = Value(dueDate);
  TasksCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<DateTime> dueDate,
      Value<bool> isCompleted}) {
    return TasksCompanion(
      id: id ?? this.id,
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
  List<GeneratedColumn> get $columns => [id, name, dueDate, isCompleted];
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
  final String evName;
  final String description;
  final DateTime endDate;
  final DateTime startDate;
  final bool isHappened;
  Event(
      {@required this.id,
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
          String evName,
          String description,
          DateTime endDate,
          DateTime startDate,
          bool isHappened}) =>
      Event(
        id: id ?? this.id,
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
          evName.hashCode,
          $mrjc(
              description.hashCode,
              $mrjc(endDate.hashCode,
                  $mrjc(startDate.hashCode, isHappened.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.evName == this.evName &&
          other.description == this.description &&
          other.endDate == this.endDate &&
          other.startDate == this.startDate &&
          other.isHappened == this.isHappened);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> evName;
  final Value<String> description;
  final Value<DateTime> endDate;
  final Value<DateTime> startDate;
  final Value<bool> isHappened;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.evName = const Value.absent(),
    this.description = const Value.absent(),
    this.endDate = const Value.absent(),
    this.startDate = const Value.absent(),
    this.isHappened = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    @required String evName,
    @required String description,
    @required DateTime endDate,
    @required DateTime startDate,
    this.isHappened = const Value.absent(),
  })  : evName = Value(evName),
        description = Value(description),
        endDate = Value(endDate),
        startDate = Value(startDate);
  EventsCompanion copyWith(
      {Value<int> id,
      Value<String> evName,
      Value<String> description,
      Value<DateTime> endDate,
      Value<DateTime> startDate,
      Value<bool> isHappened}) {
    return EventsCompanion(
      id: id ?? this.id,
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
      [id, evName, description, endDate, startDate, isHappened];
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  $EventsTable _events;
  $EventsTable get events => _events ??= $EventsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, events];
}
