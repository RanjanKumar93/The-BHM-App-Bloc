import 'package:the_bhm_app_bloc/models/notification.dart';
import 'package:the_bhm_app_bloc/services/local_database_service.dart';

class NotificationProvider {
  final NotificationDatabaseService _notificationDatabaseService =
      NotificationDatabaseService.instance;

  Future<List<NotificationModel>> getAllNotifications() async {
    try {
      final allNotifications =
          await _notificationDatabaseService.getAllNotifications();
      return allNotifications;
    } catch (e) {
      throw Exception("Error fetching notifications");
    }
  }

  Future<void> fetchNotificationFromApi() async {
    try {
      // Simulate data fetched from API
      final dataFromApi = [
        NotificationModel(
          name: "Sheersh Shah",
          role: "Design Rep",
          imgUrl: "https://placehold.co/200",
          title: "title",
          body: "I am under the water. everyone is fake. Hehe",
          isUnread: true,
          isStar: false,
        ),
        NotificationModel(
          name: "Sheersh Shah",
          role: "Design Rep",
          imgUrl: "https://placehold.co/200",
          title: "title",
          body: "I am under the water. everyone is fake. Hehe",
          isUnread: true,
          isStar: false,
        ),
        NotificationModel(
          name: "Sheersh Shah",
          role: "Design Rep",
          imgUrl: "https://placehold.co/200",
          title: "title",
          body: "I am under the water. everyone is fake. Hehe",
          isUnread: true,
          isStar: false,
        ),
        NotificationModel(
          name: "Sheersh Shah",
          role: "Design Rep",
          imgUrl: "https://placehold.co/200",
          title: "title",
          body: "I am under the water. everyone is fake. Hehe",
          isUnread: true,
          isStar: false,
        ),
        NotificationModel(
          name: "Sheersh Shah",
          role: "Design Rep",
          imgUrl: "https://placehold.co/200",
          title: "title",
          body: "I am under the water. everyone is fake. Hehe",
          isUnread: true,
          isStar: false,
        ),
        NotificationModel(
          name: "Sheersh Shah",
          role: "Design Rep",
          imgUrl: "https://placehold.co/200",
          title: "title",
          body: "I am under the water. everyone is fake. Hehe",
          isUnread: true,
          isStar: false,
        ),
      ];

      // Add each notification to the local database
      // for (var notification in dataFromApi) {
      //   await _notificationDatabaseService.addNotification(
      //     name: notification.name ?? "--",
      //     role: notification.role ?? "--",
      //     imgUrl: notification.imgUrl ?? "--",
      //     title: notification.title ?? "--",
      //     body: notification.body ?? "--",
      //     isUnread: notification.isUnread,
      //     isStar: notification.isStar,
      //   );
      // }
    } catch (e) {
      // Handle any errors
      throw Exception("Error fetching notifications: $e");
    }
  }

  Future<void> onClickANotification(int id) async {
    await _notificationDatabaseService.updateIsUnread(id, true);
    // await _notificationDatabaseService.deleteAllNotifications();
  }

  Future<void> onCloseDatabase() async {
    await _notificationDatabaseService.closeDatabase();
  }
}
