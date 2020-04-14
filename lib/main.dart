import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'util/bloc/auth_bloc.dart';
import 'util/consts.dart';
import 'util/routes/router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'TempoKit',
        theme: themeData,
        builder: ExtendedNavigator<Router>(router: Router()),
      ),
    );
  }
}
