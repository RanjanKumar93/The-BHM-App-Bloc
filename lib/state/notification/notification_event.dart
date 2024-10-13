part of 'notification_bloc.dart';

sealed class NotificationEvent {}

class LoadAllNotifications extends NotificationEvent {}

class FetchNotifications extends NotificationEvent {}

class CloseNotificationDatabase extends NotificationEvent {}

class NotificationClicked extends NotificationEvent {
  final int notificationId;

  NotificationClicked({required this.notificationId});
}
