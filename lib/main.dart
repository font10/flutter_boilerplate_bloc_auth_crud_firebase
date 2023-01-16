import 'package:boilerplate_auth_crud_firestore_bloc/bloc/auth/auth_bloc.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/bloc/employee/bloc/employee_bloc.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/components/main_page.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/data/repository/auth_repository.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/data/repository/employee__repository.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/firebase_options.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/screens/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: ( context ) => AuthRepository(),
        ),
        RepositoryProvider(
          create: ( context ) => EmployeeRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ( context ) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: ( context ) => EmployeeBloc(
              employeeRepository: RepositoryProvider.of<EmployeeRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ( context, snapshot ) {
              //* If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
              if ( snapshot.hasData ) {
                return const MainPage();
              }
              //* Otherwise, they're not signed in. Show the sign in page.
              return SignIn();
            }),
        ),
      ),
    );
  }
}
