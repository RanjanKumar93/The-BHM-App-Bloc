import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_bhm_app_bloc/routes/router.dart';

void Function()? goBackToDash;

class DrawerWrapper extends StatefulWidget {
  const DrawerWrapper(
      {super.key, required this.child, required this.routerState});

  final Widget child;
  final GoRouterState routerState;

  @override
  State<DrawerWrapper> createState() => _DrawerWrapperState();
}

class _DrawerWrapperState extends State<DrawerWrapper> {
  // Navigation items and routes
  final List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      label: 'Mess Menu',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.qr_code),
      label: 'QR Code',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.warning),
      label: 'Complain',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.attach_money),
      label: 'Rebate',
    ),
  ];

  void onTap(int index) {
    // Navigate to the appropriate page based on the index
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go('/mess');
        break;
      case 2:
        GoRouter.of(context).go('/qr');
        break;
      case 3:
        GoRouter.of(context).go('/complain');
        break;
      case 4:
        GoRouter.of(context).go('/rebate');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentIndex = 0; // Default to 'Home'

    // Get the current path to set the active bottom navigation index
    final String path = widget.routerState.fullPath ?? '/';
    bool hideBottomNav = path.contains('/notification');

    bool hideAppBar = path.contains("/notification");

    // Set the currentIndex based on the active route
    final firstRoute = path.split('/')[1];
    switch (firstRoute) {
      case 'mess':
        currentIndex = 1;
        break;
      case 'qr':
        currentIndex = 2;
        break;
      case 'complain':
        currentIndex = 3;
        break;
      case 'rebate':
        currentIndex = 4;
        break;
    }

    return Scaffold(
      appBar: hideAppBar
          ? AppBar(
              backgroundColor: const Color.fromARGB(255, 18, 77, 114),
              toolbarHeight: 0,
            )
          : AppBar(
              backgroundColor: const Color.fromARGB(255, 18, 77, 114),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "BHM",
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        tooltip: 'Notifications',
                        color: Colors.white,
                        onPressed: () {
                          // Handle notification button press
                          GoRouter.of(context).go('/notification');
                        },
                      ),
                      const SizedBox(
                          width: 8), // Add spacing between icon and avatar
                      InkWell(
                        onTap: () {
                          // Define the action when CircleAvatar is pressed
                          GoRouter.of(context).go('/profile');
                        },
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
      key: drawerKey,
      body: widget.child,
      bottomNavigationBar: hideBottomNav
          ? null
          : BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: onTap, // Call onTap with the index when an item is tapped
              items: bottomNavItems,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
            ),
    );
  }
}
