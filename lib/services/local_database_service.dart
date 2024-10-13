import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_bhm_app_bloc/models/notification.dart';

class NotificationDatabaseService {
  static final NotificationDatabaseService instance =
      NotificationDatabaseService._constructor();
  static Database? _db;

  final String _notificationTableName = "notifications";
  final String _notificationIdColumnName = "id";
  final String _notificationNameColumnName = "name";
  final String _notificationRoleColumnName = "role";
  final String _notificationImgUrlColumnName = "imgUrl";
  final String _notificationTitleColumnName = "title";
  final String _notificationBodyColumnName = "body";
  final String _notificationIsUnreadColumnName = "isUnread";
  final String _notificationIsStarColumnName = "isStar";

  NotificationDatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getNotificationDatabase();
    return _db!;
  }

  Future<Database> getNotificationDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_notificationTableName (
          $_notificationIdColumnName INTEGER PRIMARY KEY,
          $_notificationNameColumnName TEXT NOT NULL,
          $_notificationRoleColumnName TEXT NOT NULL,
          $_notificationImgUrlColumnName TEXT NOT NULL,
          $_notificationTitleColumnName TEXT NOT NULL,
          $_notificationBodyColumnName TEXT NOT NULL,
          $_notificationIsUnreadColumnName BOOL NOT NULL,
          $_notificationIsStarColumnName BOOL NOT NULL
        )
        ''');
      },
    );
    return database;
  }

  Future<int> addNotification({
    required String name,
    required String role,
    required String imgUrl,
    required String title,
    required String body,
    required bool isUnread,
    required bool isStar,
  }) async {
    final db = await database;
    final notificationData = {
      _notificationNameColumnName: name,
      _notificationRoleColumnName: role,
      _notificationImgUrlColumnName: imgUrl,
      _notificationTitleColumnName: title,
      _notificationBodyColumnName: body,
      _notificationIsUnreadColumnName: isUnread ? 1 : 0,
      _notificationIsStarColumnName: isStar ? 1 : 0,
    };
    return await db.insert(_notificationTableName, notificationData);
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(_notificationTableName);

    return List.generate(maps.length, (i) {
      return NotificationModel(
        name: maps[i][_notificationNameColumnName],
        role: maps[i][_notificationRoleColumnName],
        imgUrl: maps[i][_notificationImgUrlColumnName],
        title: maps[i][_notificationTitleColumnName],
        body: maps[i][_notificationBodyColumnName],
        isUnread: maps[i][_notificationIsUnreadColumnName] == 1,
        isStar: maps[i][_notificationIsStarColumnName] == 1,
      );
    }).reversed.toList();
  }

  Future<int> deleteNotification(int id) async {
    final db = await database;
    return await db.delete(
      _notificationTableName,
      where: '$_notificationIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotifications() async {
    final db = await database;
    return await db.delete(_notificationTableName);
  }

  // Function to update the isUnread field for a particular notification
  Future<int> updateIsUnread(int id, bool isUnread) async {
    final db = await database;
    return await db.update(
      _notificationTableName,
      {
        _notificationIsUnreadColumnName:
            isUnread ? 0 : 1, // Store as 1 or 0 for SQLite BOOL
      },
      where: '$_notificationIdColumnName = ?',
      whereArgs: [id],
    );
  }

  // Function to update the isStar field for a particular notification
  Future<int> updateIsStar(int id, bool isStar) async {
    final db = await database;
    return await db.update(
      _notificationTableName,
      {
        _notificationIsStarColumnName:
            isStar ? 1 : 0, // Store as 1 or 0 for SQLite BOOL
      },
      where: '$_notificationIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    if (_db != null) {
      await _db!.close();
      _db = null; // Reset _db to ensure it can be reopened if needed
    }
  }
}
