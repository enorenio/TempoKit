import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempokit/util/bloc/utility_bloc.dart';
import 'package:tempokit/util/routes/global_router.gr.dart';
import 'injection_container.dart';
import 'util/bloc/auth_bloc.dart';
import 'util/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String _getDefaultRoute(AuthState state) {
    if (DEBUG) {
      return Routes.debugPage;
    }
    if (state is Authenticated) {
      return Routes.wrapperPage;
    } else {
      return Routes.initialPage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<UtilityBloc>(
          create: (_) => sl<UtilityBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'TempoKit',
        theme: themeData,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => ExtendedNavigator<GlobalRouter>(
            router: GlobalRouter(),
            initialRoute: _getDefaultRoute(state),
          ),
        ),
      ),
    );
  }
}
