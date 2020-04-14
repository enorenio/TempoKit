import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';

import 'package:tempokit/model/user.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';

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
      print('LoginAttempt');
      // check with api call
      // return either authenticated or error
      User _user = User(
        uEmail: 'morshnev.aleksey@gmail.com',
        fullName: 'Aleksey Morshnev',
        password: '12345',
        workType: 'dev',
      );
      if(event.uEmail == _user.uEmail && event.password == _user.password){
        ExtendedNavigator.ofRouter<GlobalRouter>().pushNamed(Routes.wrapperPage);
        yield Authenticated(user: _user);
      } else {
        //... error showing
        // yield Error();
      }
    }

    if (event is LogoutAttempt) {
      //...
      yield Uninitialized();
    }

    if (event is RegistrationAttempt) {
      //...
      yield Authenticated();
    }
  }
}
