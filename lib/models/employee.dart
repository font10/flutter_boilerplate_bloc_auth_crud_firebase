import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {

  final String name;
  final int age;
  final String work;
  String? docId;
  final String? userId;

  Employee({
    required this.name,
    required this.age,
    required this.work,
    this.docId,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'work': work,
      'docId': docId,
      'userId': userId,
      //'imageURL': imageURL
    };
  }

  Employee.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : name = doc.data()!["name"],
      age = doc.data()!["age"],
      work = doc.data()!["work"],
      docId = doc.data()!["docId"],
      userId = doc.data()!["userId"];
      //imageURL = doc.data()!["imageURL"];

}
