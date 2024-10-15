import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_bhm_app_bloc/routes/router.dart';
import 'package:the_bhm_app_bloc/screens/splash_screen.dart';
import 'package:the_bhm_app_bloc/services/notification_service.dart';
import 'package:the_bhm_app_bloc/state/auth/auth_bloc.dart';
import 'package:the_bhm_app_bloc/state/auth/auth_provider.dart';
import 'package:the_bhm_app_bloc/state/complain_status/complain_status_bloc.dart';
import 'package:the_bhm_app_bloc/state/complain_status/complain_status_provider.dart';
import 'package:the_bhm_app_bloc/state/complaint/complaint_bloc.dart';
import 'package:the_bhm_app_bloc/state/home/home_bloc.dart';
import 'package:the_bhm_app_bloc/state/home/home_provider.dart';
import 'package:the_bhm_app_bloc/state/mess_menu/mess_menu_bloc.dart';
import 'package:the_bhm_app_bloc/state/mess_menu/mess_menu_provider.dart';
import 'package:the_bhm_app_bloc/state/notification/notification_bloc.dart';
import 'package:the_bhm_app_bloc/state/notification/notification_provider.dart';
import 'package:the_bhm_app_bloc/state/prevpayment/prevpayment_bloc.dart';
import 'package:the_bhm_app_bloc/state/prevpayment/prevpayment_provider.dart';
import 'package:the_bhm_app_bloc/state/qr/qr_bloc.dart';
import 'package:the_bhm_app_bloc/state/qr/qr_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<SharedPreferencesWithCache> _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{'access_token'},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferencesWithCache>(
      future: _prefs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while initializing
          return const MaterialApp(home: SplashScreen()

              // Scaffold(
              //   body: Center(child: CircularProgressIndicator()),
              // ),
              );
        } else if (snapshot.hasError) {
          // Handle initialization error
          return const MaterialApp(home: SplashScreen()

              //  Scaffold(
              //   body: Center(
              //     child: Text('Error initializing app: ${snapshot.error}'),
              //   ),
              // ),
              );
        } else {
          // Initialization successful, provide BLoCs
          final prefs = snapshot.data!;
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                lazy: false,
                create: (context) => AuthBloc(
                  AuthProvider(),
                  prefs,
                )..add(const AuthEventCheck()),
              ),
              BlocProvider<HomeBloc>(
                create: (context) =>
                    HomeBloc(HomeProvider())..add(HomeEventImagesFetch()),
              ),
              BlocProvider<QRBloc>(
                create: (context) => QRBloc(QRProvider())..add(QREventFetch()),
              ),
              BlocProvider<PrevPaymentBloc>(
                create: (context) => PrevPaymentBloc(PrevpaymentProvider())
                  ..add(PrevpaymentEventFetch()),
              ),
              BlocProvider<MessMenuBloc>(
                create: (context) =>
                    MessMenuBloc(MessMenuProvider())..add(MessMenuEventFetch()),
              ),
              BlocProvider<ComplaintBloc>(
                create: (context) => ComplaintBloc(),
              ),
              BlocProvider<ComplainStatusBloc>(
                create: (context) =>
                    ComplainStatusBloc(ComplainStatusProvider())
                      ..add(ComplainStatusEventFetch()),
              ),
              BlocProvider<NotificationBloc>(
                create: (context) => NotificationBloc(NotificationProvider())
                  ..add(FetchNotifications()),
              ),
            ],
            child: MaterialApp.router(
              scaffoldMessengerKey: NotificationService.messengerKey,
              title: "The BHM App",
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              builder: (context, child) {
                return BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    routerState.changeAuthState(state);
                  },
                  child: child,
                );
              },
            ),
          );
        }
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:the_bhm_app_bloc/routes/router.dart';
// import 'package:the_bhm_app_bloc/services/notification_service.dart';
// import 'package:the_bhm_app_bloc/state/auth/auth_bloc.dart';
// import 'package:the_bhm_app_bloc/state/auth/auth_provider.dart';
// import 'package:the_bhm_app_bloc/state/notification/notification_bloc.dart';
// import 'package:the_bhm_app_bloc/state/notification/notification_provider.dart';
// import 'package:the_bhm_app_bloc/state/qr/qr_bloc.dart';
// import 'package:the_bhm_app_bloc/state/qr/qr_provider.dart';

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   final Future<SharedPreferencesWithCache> _prefs =
//       SharedPreferencesWithCache.create(
//           cacheOptions: const SharedPreferencesWithCacheOptions(
//               allowList: <String>{'access_token'}));

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider<AuthBloc>(
//             lazy: false,
//             create: (context) => AuthBloc(
//               AuthProvider(),
//               _prefs,
//             )..add(const AuthEventCheck()),
//           ),
//           BlocProvider(
//             create: (context) => QRBloc(QRProvider())..add(QREventFetch()),
//           ),
//           BlocProvider(
//             create: (context) => NotificationBloc(NotificationProvider())
//               ..add(FetchNotifications()),
//           ),
//         ],
//         child: MaterialApp.router(
//           scaffoldMessengerKey: NotificationService.messengerKey,
//           title: "The BHM App",
//           debugShowCheckedModeBanner: false,
//           routerConfig: router,
//           builder: (context, child) {
//             return BlocListener<AuthBloc, AuthState>(
//               listener: (context, state) {
//                 routerState.changeAuthState(state);
//               },
//               child: child,
//             );
//           },
//         ));
//   }
// }
