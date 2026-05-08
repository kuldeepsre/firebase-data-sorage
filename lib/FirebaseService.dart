import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/student_model.dart';


class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String collection = "students";

  /// SAVE DATA
  Future<void> addStudent(StudentModel student) async {
    await _firestore
        .collection(collection)
        .doc(student.id)
        .set(student.toJson());
  }

  /// READ DATA
  Stream<List<StudentModel>> getStudents() {
    return _firestore.collection(collection).snapshots().map(
          (snapshot) {
        return snapshot.docs.map((doc) {
          return StudentModel.fromJson(doc.data());
        }).toList();
      },
    );
  }

  /// DELETE DATA
  Future<void> deleteStudent(String id) async {
    await _firestore.collection(collection).doc(id).delete();
  }

  /// UPDATE DATA
  Future<void> updateStudent(StudentModel student) async {
    await _firestore
        .collection(collection)
        .doc(student.id)
        .update(student.toJson());
  }
}