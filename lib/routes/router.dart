import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_bhm_app_bloc/components/drawer_wrapper.dart';
import 'package:the_bhm_app_bloc/models/router_state.dart';
import 'package:the_bhm_app_bloc/screens/complain.dart';
import 'package:the_bhm_app_bloc/screens/home/home.dart';
import 'package:the_bhm_app_bloc/screens/home/payment.dart';
import 'package:the_bhm_app_bloc/screens/home/prev_payment.dart';
import 'package:the_bhm_app_bloc/screens/login.dart';
import 'package:the_bhm_app_bloc/screens/mess_menu.dart';
import 'package:the_bhm_app_bloc/screens/notification.dart';
import 'package:the_bhm_app_bloc/screens/profile.dart';
import 'package:the_bhm_app_bloc/screens/qr.dart';
import 'package:the_bhm_app_bloc/screens/rebate.dart';
import 'package:the_bhm_app_bloc/screens/splash_screen.dart';
import 'package:the_bhm_app_bloc/state/auth/auth_bloc.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final drawerKey = GlobalKey<ScaffoldState>();

RouterState routerState = RouterState();

GoRouter router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return DrawerWrapper(
          routerState: state,
          child: child,
        );
      },
      routes: [
        GoRoute(
            path: "/",
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'notification',
                builder: (context, state) => const NotificationScreen(),
              ),
              GoRoute(
                path: 'payment',
                builder: (context, state) => const PaymentScreen(),
              ),
              GoRoute(
                path: 'prevpayment',
                builder: (context, state) => const PrevPaymentScreen(),
              ),
            ]),
        GoRoute(
          path: "/mess",
          builder: (context, state) => const MessMenuScreen(),
        ),
        GoRoute(
          path: "/qr",
          builder: (context, state) => const QRScreen(),
        ),
        GoRoute(
          path: "/complain",
          builder: (context, state) => const ComplainScreen(),
        ),
        GoRoute(
          path: "/rebate",
          builder: (context, state) => const RebateScreen(),
        ),
        GoRoute(
          path: "/profile",
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
  refreshListenable: routerState,
  redirect: (context, state) {
    if (routerState.redir != null) {
      return routerState.redir;
    }
    AuthState authState = routerState.authState;
    if (authState is AuthStateUninitialized) {
      if (state.fullPath != "/splash") {
        return "/splash";
      }
      return null;
    }
    if (authState is AuthStateInitial) {
      if (state.fullPath == '/login') {
        return null;
      }
      return '/login';
    }
    if (authState is AuthStateLoggedIn &&
        (state.fullPath == '/login' || state.fullPath == '/splash')) {
      return '/';
    }

    if (authState is AuthStateLoggedOut &&
        (state.fullPath != '/login' && state.fullPath != '/splash')) {
      return '/login';
    }

    return null;
  },
);
