import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Tasks extends Table {
  //Primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 2, max: 100)();
  DateTimeColumn get dueDate => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id, name};
}

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get evName => text().withLength(min: 2, max: 100)();
  TextColumn get description => text().withLength(min: 2, max: 255)();
  DateTimeColumn get endDate => dateTime()();
  DateTimeColumn get startDate => dateTime()();
  BoolColumn get isHappened => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id, evName};
}

class Projects extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tasksValue => integer()();
  TextColumn get projectName => text().withLength(min:2,max:100)();
  TextColumn get projectDescription => text().withLength(min: 2,max:255)();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isFinished => boolean().withDefault(Constant(false))();


  @override
  Set<Column> get primaryKey => {id, projectName};
}



@UseMoor(tables: [Tasks, Events])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  // TODOimplement schemaVersion
  int get schemaVersion => 1;

  /// Queries <>
  /// Task queries*/
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();
  Future<List<Task>> getAllTasks() => select(tasks).get();
  Future insertTask(Task task) => into(tasks).insert(task);
  Future updateTask(Task task) => update(tasks).replace(task);
  Future deleteTask(Task task) => delete(tasks).delete(task);

   /// Event queries*/
  Stream<List<Event>> watchAllEvents() => select(events).watch();
  Future insertEvent(Event event) => into(events).insert(event);
  Future updateEvent(Event event) => update(events).replace(event);
  Future deleteEvent(Event event) => delete(events).delete(event);
}
