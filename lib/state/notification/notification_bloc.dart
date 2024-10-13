import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/notification.dart';
import 'package:the_bhm_app_bloc/state/notification/notification_provider.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationProvider notificationProvider;

  NotificationBloc(this.notificationProvider) : super(NotificationInitial()) {
    on<LoadAllNotifications>(
      (event, emit) async {
        try {
          emit(NotificationLoading());
          final allNotifications =
              await notificationProvider.getAllNotifications();
          emit(NotificationsLoaded(allNotifications));
        } catch (e) {
          emit(NotificationError("Failed to load notifications"));
        }
      },
    );
    on<FetchNotifications>(
      (event, emit) async {
        try {
          await notificationProvider.fetchNotificationFromApi();
          add(LoadAllNotifications());
        } catch (e) {
          return;
        }
      },
    );

    on<NotificationClicked>(
      (event, emit) async {
        await notificationProvider
            .onClickANotification(event.notificationId + 1);
        add(LoadAllNotifications());
      },
    );

    on<CloseNotificationDatabase>(
      (event, emit) async {
        await notificationProvider.onCloseDatabase();
      },
    );
  }
}
