import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_bhm_app_bloc/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:the_bhm_app_bloc/state/auth/auth_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Future<SharedPreferencesWithCache> _prefs;
  AuthBloc(AuthProvider authProvider, this._prefs)
      : super(const AuthStateUninitialized()) {
    on<AuthEventCheck>((state, emit) async {
      try {
        final SharedPreferencesWithCache prefs = await _prefs;
        await prefs.setString("access_token", "dummytoken");
        final token = prefs.getString('access_token');
        if (token != null) {
          emit(AuthStateLoggedIn(user: UserProfile(name: "rk", entryNo: "20")));
        } else {
          add(const AuthEventLogout());
        }
      } catch (e) {
        emit(AuthStateError(exception: Exception(e)));
      }
    });
    on<AuthEventLogout>((event, emit) async {
      final SharedPreferencesWithCache prefs = await _prefs;
      await prefs.remove("access_token");
      emit(const AuthStateLoggedOut());
    });
  }
}
