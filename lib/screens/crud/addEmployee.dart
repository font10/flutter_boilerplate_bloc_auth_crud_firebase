import 'package:boilerplate_auth_crud_firestore_bloc/bloc/employee/bloc/employee_bloc.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/models/employee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _workController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _workController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.only( top:30, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                return value != null
                    ? 'Enter a valid name'
                    : null;
              },
            ),const SizedBox( height: 20 ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: const InputDecoration(
                hintText: "Age",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                return value != null
                    ? 'Enter a valid work'
                    : null;
              },
            ),
            const SizedBox( height: 20 ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _workController,
              decoration: const InputDecoration(
                hintText: "Work",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                return value != null
                    ? 'Enter a valid work'
                    : null;
              },
            ),
            SizedBox( height: 20 ),
            ElevatedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser!;

                Employee empl = Employee(
                  name: _nameController.text,
                  age: int.parse(_ageController.text),
                  work: _workController.text,
                  docId: '',
                  userId: user.uid.toString(),
                );
    
                BlocProvider.of<EmployeeBloc>(context).add(AddEmployeeRequested(empl));
                Navigator.pop(context, true);
              }, 
              child: Text('Add Employee')
            )
          ],
        ),
      ),
    );
  }
}