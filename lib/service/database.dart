import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Alarms extends Table {
  BoolColumn get hasRang => boolean().withDefault(Constant(false))();
  DateTimeColumn get ringTime => dateTime()();
  IntColumn get id => integer().autoIncrement()();
  //TextColumn get label => text().withLength(min: 2,max: 50)();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 2, max: 255)();
  IntColumn get color => integer()();

  @override
  Set<Column> get primaryKey => {id, name};
}

class Tasks extends Table {
  //Primary key
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tag => integer().customConstraint('REFERENCES tags(id)')();
  TextColumn get name => text().withLength(min: 2, max: 100)();
  DateTimeColumn get dueDate => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id, name};
}

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tag => integer().customConstraint('REFERENCES tags(id)')();
  TextColumn get evName => text().withLength(min: 2, max: 100)();
  TextColumn get description => text().withLength(min: 2, max: 255)();
  DateTimeColumn get endDate => dateTime()();
  DateTimeColumn get startDate => dateTime()();
  BoolColumn get isHappened => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id, evName};
}

class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tasksValue => integer()();
  IntColumn get tag => integer().customConstraint('REFERENCES tags(id)')();
  TextColumn get projectName => text().withLength(min: 2, max: 100)();
  TextColumn get projectDescription => text().withLength(min: 2, max: 255)();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isFinished => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id, projectName};
}

class SubTasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tag => integer().customConstraint('REFERENCES tags(id)')();
  IntColumn get project =>
      integer().customConstraint('REFERENCES projects(id)')();
  TextColumn get name => text().withLength(min: 5, max: 150)();
  BoolColumn get isEnd => boolean().withDefault(Constant(false))();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id, name};
}

class ProjectWithTagAndSubTask {
  final Project project;
  final SubTask subTasks;
  final Tag tag;

  ProjectWithTagAndSubTask(
      {@required this.project, @required this.subTasks, @required this.tag});
}

class TaskWithTag {
  final Task task;
  final Tag tag;

  TaskWithTag({@required this.task, @required this.tag});
}

class EventWithTag {
  final Event event;
  final Tag tag;

  EventWithTag({@required this.event, @required this.tag});
}

class ProjectWithTag {
  final Project project;
  final Tag tag;

  ProjectWithTag({@required this.project, @required this.tag});
}

@UseMoor(
    tables: [Alarms, Tasks, Events, Tags, Projects, SubTasks],
    daos: [AlarmDao, TaskDao, EventDao, TagDao, SubTaskDao, ProjectDao])
class AppDatabase extends _$AppDatabase with ChangeNotifier {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));
  @override
  //final AppDatabase db;

  @override
  // TODOimplement schemaVersion
  int get schemaVersion => 2;

  @override
  // TODOimplement migration
  MigrationStrategy get migration =>
      MigrationStrategy(onUpgrade: (migrator, from, to) async {
        if (from == 1) {
          await migrator.addColumn(tasks, tasks.tag);
          await migrator.addColumn(events, events.tag);
          await migrator.addColumn(projects, projects.tag);
          //await migrator.addColumn(projects, projects.)
          await migrator.createTable(tags);
        }
      }, beforeOpen: (detail) async {
        await customStatement('PRAGMA foreign_keys = ON');
        // await into(tags).insert(
        //   TagsCompanion(
        //     name: const Value("Standard"),
        //     color: Value(4283215696),
        //   ),
        // );
        // await into(tags).insert(
        //   TagsCompanion(
        //     name: const Value("Coding"),
        //     color: Value(4286141768),
        //   ),
        // );
        // await into(tags).insert(
        //   TagsCompanion(
        //     name: const Value("Important"),
        //     color: Value(4294198070),
        //   ),
        // );
      }, onCreate: (Migrator m) {
        into(tags).insert(
          TagsCompanion(
            name: const Value("Standard"),
            color: Value(4283215696),
          ),
        );
        into(tags).insert(
          TagsCompanion(
            name: const Value("Coding"),
            color: Value(4286141768),
          ),
        );
        into(tags).insert(
          TagsCompanion(
            name: const Value("Important"),
            color: Value(4294198070),
          ),
        );
        return m.createAll();
      });

  /// Queries <>
}

@UseDao(tables: [Alarms])
class AlarmDao extends DatabaseAccessor<AppDatabase> with _$AlarmDaoMixin {
  AlarmDao(AppDatabase db) : super(db);

  Future insertAlarm(Insertable<Alarm> alarm) => into(alarms).insert(alarm);
  Future updateAlarm(Insertable<Alarm> alarm) => update(alarms).replace(alarm);
  Stream<List<Alarm>> watchAlarm() => select(alarms).watch();
}

//Event Data Accesssor Objects
@UseDao(
  tables: [Events, Tags],
  queries: {'_valueOfElements': 'SELECT COUNT (*) FROM events'},
)
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  final AppDatabase appDatabase;

  EventDao(this.appDatabase) : super(appDatabase);

  Stream<List<EventWithTag>> watchUnCompletedEvents() {
    return (select(events)
          ..orderBy(
            [
              (t) => OrderingTerm.asc(t.startDate.day),
              (t) => OrderingTerm(expression: t.startDate.hour),
              (t) => OrderingTerm(expression: t.evName),
            ],
          ))
        .join(
          [
            leftOuterJoin(tags, tags.id.equalsExp(events.tag)),
          ],
        )
        .watch()
        .map((rows) => rows.map((row) {
              return EventWithTag(
                event: row.readTable(events),
                tag: row.readTable(tags),
              );
            }).toList());
  }

  Stream<List<EventWithTag>> specificDayEvents(DateTime selectedDate) {
    return (select(events)
          ..orderBy(
            [
              (t) => OrderingTerm(
                  expression: t.startDate.hour, mode: OrderingMode.desc),
              (t) => OrderingTerm(expression: t.evName),
              (t) => OrderingTerm.asc(t.startDate.day)
            ],
          )
          ..where((t) => t.startDate.day.equals(selectedDate.day)))
        .join(
          [
            leftOuterJoin(tags, tags.id.equalsExp(events.tag)),
          ],
        )
        .watch()
        .map((rows) => rows.map((row) {
              return EventWithTag(
                event: row.readTable(events),
                tag: row.readTable(tags),
              );
            }).toList());
  }

  // Stream<List<Event>> watchCompletedEvents() {
  //   return (select(events)
  //         ..orderBy(
  //           [
  //             (t) => OrderingTerm(
  //                 expression: t.startDate, mode: OrderingMode.desc),
  //             (t) => OrderingTerm(expression: t.evName),
  //           ],
  //         )
  //         ..where(
  //           (t) => t.isHappened.equals(true),
  //         ))
  //       .watch();
  // }

  Future insertEvent(Insertable<Event> event) => into(events).insert(event);
  Future updateEvent(Insertable<Event> event) => update(events).replace(event);
  Future deleteEvent(Insertable<Event> event) => delete(events).delete(event);
}

@UseDao(tables: [Projects, SubTasks, Tags])
class ProjectDao extends DatabaseAccessor<AppDatabase> with _$ProjectDaoMixin {
  final AppDatabase db;

  ProjectDao(this.db) : super(db);

  Stream<List<ProjectWithTagAndSubTask>> watchEachProjectSubTaskWithTag() {
    return (select(subTasks)
          ..orderBy([
            (t) => OrderingTerm.desc(t.createdDate),
            (t) => OrderingTerm.asc(t.name)
          ]))
        .join([
          // leftOuterJoin(
          //   projects,
          //   projects.id.equalsExp(subTasks.project),
          // ),
          innerJoin(projects, projects.id.equalsExp(subTasks.project)),
          innerJoin(tags, tags.id.equalsExp(subTasks.tag))
        ])
        .watch()
        .map((rows) => rows.map((row) {
              return ProjectWithTagAndSubTask(
                project: row.readTable(projects),
                tag: row.readTable(tags),
                subTasks: row.readTable(subTasks),
              );
            }).toList());
  }
}

@UseDao(tables: [SubTasks])
class SubTaskDao extends DatabaseAccessor<AppDatabase> with _$SubTaskDaoMixin {
  final AppDatabase db;
  SubTaskDao(this.db) : super(db);

  Future insertTag(Insertable<SubTask> subTask) =>
      into(subTasks).insert(subTask);
  Stream<List<SubTask>> watchTags() => select(subTasks).watch();
}

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  final AppDatabase db;

  TagDao(this.db) : super(db);

  Future insertTag(Insertable<Tag> tag) => into(tags).insert(tag);
  Stream<List<Tag>> watchTags() => select(tags).watch();
}

@UseDao(
  tables: [Tasks, Tags],
)
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase database;

  TaskDao(this.database) : super(database);

  Stream<List<TaskWithTag>> watchUnCompletedTasks() {
    return (select(tasks)
          ..orderBy(
            [
              (t) => OrderingTerm.desc(t.dueDate),
              (t) => OrderingTerm(expression: t.name)
            ],
          ))
        .join(
          [
            leftOuterJoin(tags, tags.id.equalsExp(tasks.tag)),
          ],
        )
        .watch()
        .map((rows) => rows.map((row) {
              return TaskWithTag(
                task: row.readTable(tasks),
                tag: row.readTable(tags),
              );
            }).toList());
  }

  // Stream<List<Task>> watchCompletedTasks() {
  //   return (select(tasks)
  //         ..orderBy(
  //           [(t) => OrderingTerm(expression: t.dueDate)],
  //         )
  //         ..where(
  //           (t) => t.isCompleted.equals(true),
  //         ))
  //       .watch();
  // }

  Future<List<Task>> getAllTasks() => select(tasks).get();
  Future insertTask(Insertable<Task> task) => into(tasks).insert(task);
  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);
  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);
}
