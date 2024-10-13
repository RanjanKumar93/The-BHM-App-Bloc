import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_bhm_app_bloc/routes/router.dart';
import 'package:the_bhm_app_bloc/services/notification_service.dart';
import 'package:the_bhm_app_bloc/state/auth/auth_bloc.dart';
import 'package:the_bhm_app_bloc/state/auth/auth_provider.dart';
import 'package:the_bhm_app_bloc/state/notification/notification_bloc.dart';
import 'package:the_bhm_app_bloc/state/notification/notification_provider.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<SharedPreferencesWithCache> _prefs =
      SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
              allowList: <String>{'access_token'}));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            lazy: false,
            create: (context) => AuthBloc(
              AuthProvider(),
              _prefs,
            )..add(const AuthEventCheck()),
          ),
          BlocProvider(
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
        ));
  }
}
