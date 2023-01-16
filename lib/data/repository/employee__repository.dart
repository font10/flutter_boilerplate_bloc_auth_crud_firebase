import 'package:boilerplate_auth_crud_firestore_bloc/models/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class EmployeeRepository {
  
  final CollectionReference _ref = FirebaseFirestore.instance.collection( 'Employees' );
  
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> addEmployee( Employee empl ) async {
    empl.docId = _ref.doc().id;     
    
    try {
      await _ref.doc(empl.docId)
        .set( empl.toMap() )
        .then(( value ) {
          print( 'Employee added' );
        }) .catchError(( e ) {
          print( e );
        });
    } on FirebaseException catch ( e ) {
      if ( kDebugMode ) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Employee>> getPlaces() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Employees').get();
    return snapshot.docs
        .map( (docSnapshot) => Employee.fromDocumentSnapshot( docSnapshot ) )
        .toList();
  }

  Future<List<Employee>> getPlacesByUser() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Employees').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    return snapshot.docs
        .map( (docSnapshot) => Employee.fromDocumentSnapshot( docSnapshot ) )
        .toList();
  }

  Future<void> updateEmployee( Employee place ) async {
    try {
      await _ref.doc(place.docId).update( place.toMap() );
    } on FirebaseException catch ( e ) {
      if ( kDebugMode ) {
        print("Update failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteEmployee( Employee place ) async {
    try {
      await _ref.doc(place.docId).delete();
    } on FirebaseException catch ( e ) {
      if ( kDebugMode ) {
        print("Delete failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
