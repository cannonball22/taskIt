import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_it/features/home/presentation/pages/bottom_navigation.screen.dart';
import 'package:task_it/theme.dart';
import 'package:task_it/util.dart';
import 'core/Services/App/app.service.dart';
import 'features/authentication/domain/repositories/AuthService.dart';
import 'core/Services/Firebase/firebase.service.dart';
import 'features/authentication/presentation/pages/sign_in.screen.dart';
import 'features/authentication/presentation/pages/sign_up.screen.dart';
import 'features/home/presentation/bloc/Home Bloc/home.bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await App.initialize(AppEnvironment.dev);

  await FirebaseService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        // BlocProvider(
        //   create: (_) => TaskBloc(taskRepo: TaskRepo()),
        // ),
        // BlocProvider(
        //   create: (_) => TeamBloc(TeamRepo: TeamRepo()),
        // ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            textTheme: textTheme,
            colorScheme: MaterialTheme.lightScheme().toColorScheme(),
          ),
          // highContrastTheme: ThemeData(
          //   useMaterial3: true,
          //   textTheme: textTheme,
          //   colorScheme: MaterialTheme.lightHighContrastScheme().toColorScheme(),
          // ),
          // darkTheme: ThemeData(
          //   useMaterial3: true,
          //   textTheme: textTheme,
          //   colorScheme: MaterialTheme.darkScheme().toColorScheme(),
          // ),
          // highContrastDarkTheme: ThemeData(
          //   useMaterial3: true,
          //   textTheme: textTheme,
          //   colorScheme: MaterialTheme.darkHighContrastScheme().toColorScheme(),
          // ),
          home: StreamBuilder(
            stream: AuthService().isUserLoggedIn(),
            builder: (builder, snapshot) {
              if (snapshot.hasData) {
                return const BottomNavigationScreen();
              } else {
                return const SignInScreen();
              }
            },
          ),
          routes: <String, WidgetBuilder>{
            '/signInScreen': (BuildContext context) => const SignInScreen(),
            '/signUpScreen': (BuildContext context) => const SignUpScreen(),
          }),
    );
  }
}
