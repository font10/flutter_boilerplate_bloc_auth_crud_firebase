import 'package:boilerplate_auth_crud_firestore_bloc/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Functions {

  static void authenticateWithEmailAndPassword(context, formkey, email, pass) {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(email, pass),
      );
    }
  }

  static void createAccountWithEmailAndPassword(context, formkey, email, pass) {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          email,
          pass,
        ),
      );
    }
  }

}