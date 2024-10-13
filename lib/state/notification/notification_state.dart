part of 'notification_bloc.dart';

sealed class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationsLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationsLoaded(this.notifications);
}

class NotificationLoading extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}