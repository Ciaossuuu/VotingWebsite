import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference students =
      FirebaseFirestore.instance.collection('MyStudents');

  Future<void> createData(String studentName, String studentID,
      String studentCourse, double studentGPA) async {
    return students
        .doc(studentName)
        .set({
          'studentName': studentName,
          'studentID': studentID,
          'studentCourse': studentCourse,
          'studentGPA': studentGPA
        })
        .then((value) => print('$studentName Added'))
        .catchError((error) => print("Failed to add lesson: $error"));
  }

  Future<void> updateData(String studentName, String studentID,
      String studentCourse, double studentGPA) {
    return students
        .doc(studentName)
        .update({
          'studentName': studentName,
          'studentID': studentID,
          'studentCourse': studentCourse,
          'studentGPA': studentGPA
        })
        .then((value) => print('$studentName Updated'))
        .catchError((error) => print("Failed to add lesson: $error"));
  }

  Future<void> deleteData(String studentName) {
    students
        .doc(studentName)
        .delete()
        .then((value) => print("$studentName Deleted"))
        .catchError((error) => print("Failed to delete lesson: $error"));
  }
}
