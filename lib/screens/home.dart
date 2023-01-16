import 'package:boilerplate_auth_crud_firestore_bloc/bloc/auth/auth_bloc.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/bloc/employee/bloc/employee_bloc.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/screens/auth/sign_in.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/screens/crud/addEmployee.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/widgets/employee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EmployeeBloc>(context).add( GetEmployees());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEmployeeScreen())), 
            icon: const Icon( Icons.add )
          ),
          IconButton(
            onPressed: () => context.read<AuthBloc>().add(SignOutRequested()),
            icon: const Icon( Icons.door_back_door )
          )
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false,
            );
          }
          // TODO: implement listener
        },
        child: Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: BlocBuilder<EmployeeBloc, EmployeeState>(
                    builder: ( context, state ) {
                      if( state is EmployeesLoaded ) {
                        var places = state.data;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: places.length,
                          itemBuilder: ( context, index ) {
                            return InkWell(
                              child: EmployeeCard( doc: places[index] ),
                            );
                          }
                        );
                      } else if( state is LoadingState ) {
                        return const Center( child: CircularProgressIndicator() );
                      } else {
                        return Container();
                      }
                    }
                  ),
                ),
                /*Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 15),
                  child: GestureDetector(
                    onTap: () => context.read<AuthBloc>().add(
                        SignOutRequested()), //Navigator.push(context, MaterialPageRoute( builder: (context) => SearchPage() ) ),
                    child: const Icon(
                      Icons.door_back_door_outlined,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        )
      ),
    );
  }
}
