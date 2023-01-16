import 'package:boilerplate_auth_crud_firestore_bloc/bloc/employee/bloc/employee_bloc.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/models/employee.dart';
import 'package:boilerplate_auth_crud_firestore_bloc/screens/crud/updateEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeCard extends StatelessWidget {
  final Employee doc;
  const EmployeeCard({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const SizedBox(height: 15);
    return GestureDetector(
      //onTap: () => Navigator.push(context, MaterialPageRoute( builder: (context) => DetailsEmployee( doc: doc ) ) ),
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Text(
                          doc.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          )
                        ),
                      ),
                      SizedBox( width: 6 ),
                      Text(
                          doc.age.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15
                          )                                //overflow: TextOverflow.ellipsis,
                        ),
                      
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        doc.work,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute( builder: (context) => UpdateEmployeeScreen( empl: doc ) ) ), 
                        icon: Icon( Icons.edit )
                      ),
                      IconButton(
                        onPressed: () => BlocProvider.of<EmployeeBloc>(context).add(DeleteEmployeeRequested( doc )), 
                        icon: Icon( Icons.delete, color: Colors.red )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
