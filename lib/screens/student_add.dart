import 'package:flutter/material.dart';
import 'package:form_yapisi/models/students.dart';
import 'package:form_yapisi/validations/student_validator.dart';

// ignore: must_be_immutable
class StudentAdd extends StatefulWidget {
  List<Student> students;
  StudentAdd(List<Student> students) {
    this.students = students;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  List<Student> students;
  var student = Student.withoutInfo();
  var formKey = GlobalKey<FormState>();
  _StudentAddState(List<Student> students) {
    this.students = students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni Öğrenci Ekleme"),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                buildFirstName(),
                buildLastName(),
                buildGrade(),
                buildSubmitButton()
              ],
            ),
          ),
        ));
  }

  buildFirstName() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Ad", hintText: "Mustafa"),
      validator: validateFirstName,
      onSaved: (String value) {
        student.firstName = value;
      },
    );
  }

  buildLastName() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Soyad", hintText: "Akil"),
      validator: validateLastName,
      onSaved: (String value) {
        student.lastName = value;
      },
    );
  }

  buildGrade() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Not", hintText: "65"),
      validator: validateGrade,
      onSaved: (String value) {
        student.grade = int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          students.add(student);
          Navigator.pop(context);
        }
      },
    );
  }
}
