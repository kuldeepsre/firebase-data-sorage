import 'package:flutter/material.dart';

import 'FirebaseService.dart';
import 'model/student_model.dart';


class StudentProvider extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();

  Stream<List<StudentModel>> get students =>
      _service.getStudents();

  Future<void> addStudent(StudentModel student) async {
    await _service.addStudent(student);
  }

  Future<void> deleteStudent(String id) async {
    await _service.deleteStudent(id);
  }

  Future<void> updateStudent(StudentModel student) async {
    await _service.updateStudent(student);
  }
}