import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

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
    tables: [Tasks, Events, Tags, Projects, SubTasks],
    daos: [TaskDao, EventDao, TagDao, SubTaskDao, ProjectDao])
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
        await into(tags).insert(
          TagsCompanion(
            name: const Value("Important"),
            color: Value(4294198070),
          ),
        );
        await into(tags).insert(
          TagsCompanion(
            name: const Value("Standard"),
            color: Value(4283215696),
          ),
        );
        await into(tags).insert(
          TagsCompanion(
            name: const Value("Coding"),
            color: Value(4286141768),
          ),
        );
      }, onCreate: (Migrator m) {
        return m.createAll();
      });

  /// Queries <>
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

//Event Data Accesssor Objects
@UseDao(tables: [Events, Tags])
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  final AppDatabase appDatabase;

  EventDao(this.appDatabase) : super(appDatabase);

  Stream<List<EventWithTag>> watchUnCompletedEvents() {
    return (select(events)
          ..orderBy(
            [
              (t) => OrderingTerm(
                  expression: t.startDate, mode: OrderingMode.desc),
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

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  final AppDatabase db;

  TagDao(this.db) : super(db);

  Future insertTag(Insertable<Tag> tag) => into(tags).insert(tag);
  Stream<List<Tag>> watchTags() => select(tags).watch();
}

@UseDao(tables: [SubTasks])
class SubTaskDao extends DatabaseAccessor<AppDatabase> with _$SubTaskDaoMixin {
  final AppDatabase db;
  SubTaskDao(this.db) : super(db);

  Future insertTag(Insertable<SubTask> subTask) =>
      into(subTasks).insert(subTask);
  Stream<List<SubTask>> watchTags() => select(subTasks).watch();
}
