import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'utility_event.dart';
part 'utility_state.dart';

class UtilityBloc extends Bloc<UtilityEvent, UtilityState> {
  @override
  UtilityState get initialState => DefaultState();

  @override
  Stream<UtilityState> mapEventToState(UtilityEvent event) async* {
    if (event is NetworkErrorEvent) {
      yield NetworkErrorState(message: 'No Internet Connection');
    }
  }

  static listener(context, state) {
    if (state is NetworkErrorState) {
      print('NetworkErrorState listened');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFFB00020),
          action: SnackBarAction(
            label: 'RETRY',
            textColor: Colors.white,
            onPressed: () {
              print('Retry pressed');
            },

          ),
          content: Text(
            state.message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
