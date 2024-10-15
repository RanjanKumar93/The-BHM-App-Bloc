import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/notification.dart';
import 'package:the_bhm_app_bloc/state/notification/notification_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Loading all notifications on initialization
    context.read<NotificationBloc>().add(LoadAllNotifications());
  }

  @override
  void dispose() {
    // Dispose TabController when not needed
    _tabController.dispose();

    super.dispose();
  }

  Future<void> _refreshNotifications() async {
    // Dispatching the event to reload notifications
    context.read<NotificationBloc>().add(FetchNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TabBar(
                dividerHeight: 0,
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                tabs: [
                  Tab(
                    child: Container(
                      width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text("All"),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 120,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text("Unread"),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text("Star"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationInitial || state is NotificationLoading) {
            return Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[200], // Background color
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (state is NotificationsLoaded) {
            // All notifications
            final allNotifications = state.notifications;

            // Unread notifications
            final unreadNotifications = allNotifications
                .where((notification) => notification.isUnread)
                .toList();

            // Starred notifications
            final starredNotifications = allNotifications
                .where((notification) => notification.isStar)
                .toList();

            return TabBarView(
              controller: _tabController,
              children: [
                RefreshIndicator(
                  onRefresh: _refreshNotifications,
                  child: Container(
                    color: Colors.grey[200],
                    child: _buildNotificationList(allNotifications),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: _refreshNotifications,
                  child: Container(
                    color: Colors.grey[200],
                    child: _buildNotificationList(unreadNotifications),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: _refreshNotifications,
                  child: Container(
                    color: Colors.grey[200],
                    child: _buildNotificationList(starredNotifications),
                  ),
                ),
              ],
            );
          } else if (state is NotificationError) {
            return RefreshIndicator(
              onRefresh: _refreshNotifications,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                      color: Colors.grey[200],
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 200),
                        child: Center(child: Text(state.message)),
                      ));
                },
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _refreshNotifications,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 200.0),
                      child:
                          Center(child: Text("Failed to get notifications.")),
                    ));
              },
            ),
          );
        },
      ),
    );
  }

  // Method to build notification list
  Widget _buildNotificationList(List notifications) {
    if (notifications.isEmpty) {
      return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 200.0),
                child: Center(child: Text("No notifications available")),
              ));
        },
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final NotificationModel notification = notifications[index];
        return InkWell(
          onTap: () {
            // Dispatch NotificationClicked event when the notification is tapped
            context
                .read<NotificationBloc>()
                .add(NotificationClicked(notificationId: index));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Icon(Icons.image, size: 40),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notification ${index + 1}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(notification.body ?? "No Body"),
                      const SizedBox(height: 5),
                      Text(
                        "${notification.name} • ${notification.role}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
