import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';

import 'package:tempokit/model/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // data and constructor

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield Uninitialized();
    } else {
      yield Loading();
    }
    
    if (event is LoginAttempt) {
      // check with api call
      // return eithe authenticated or error
    }

    if (event is LogoutAttempt) {
      //...
    }

    if (event is RegistrationAttempt) {
      //...
    }
  }


}