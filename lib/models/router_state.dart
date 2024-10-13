import 'package:flutter/material.dart';
import 'package:the_bhm_app_bloc/state/auth/auth_bloc.dart';

class RouterState extends ChangeNotifier {
  String? _redir;
  AuthState authState = const AuthStateUninitialized();

  String? get redir {
    final temp = _redir;
    _redir = null;
    return temp;
  }

  void changeRoute(String route) {
    _redir = route;
    notifyListeners();
  }

  void changeAuthState(AuthState state) {
    authState = state;
    notifyListeners();
  }
}
