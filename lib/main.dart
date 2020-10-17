import 'package:flutter/material.dart';
import 'package:form_yapisi/models/students.dart';
import 'package:form_yapisi/screens/student_add.dart';
import 'package:form_yapisi/screens/student_edit.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = "Öğrenci Takip Sistemi";
  Student selectedStudent = Student.withId(0, "", "", 0);
  List<Student> students = [
    Student.withId(1, "Mustafa", "Akil", 85),
    Student.withId(2, "Berna", "Dost", 45),
    Student.withId(3, "Ömer", "Arık", 30)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ListTile(
                      title: Text(
                          students[i].firstName + " " + students[i].lastName),
                      subtitle: Text("Aldığı Not:" +
                          students[i].grade.toString() +
                          " [" +
                          students[i].getStatue +
                          "]"),
                      trailing: buildStatusIcon(students[i].grade),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://media.istockphoto.com/vectors/user-icon-flat-style-isolated-on-white-background-vector-id1084418050"),
                      ),
                      onTap: () {
                        setState(() {
                          selectedStudent = students[i];
                        });
                      },
                    );
                  })),
          Text("Seçili Öğrenci: " +
              selectedStudent.firstName +
              " " +
              selectedStudent.lastName),
          Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Yeni"),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentAdd(students)));
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: RaisedButton(
                  color: Colors.amberAccent,
                  child: Row(
                    children: [
                      Icon(Icons.update),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Güncelle"),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentEdit(selectedStudent)));
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: RaisedButton(
                  color: Colors.lightGreenAccent,
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Sil"),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      students.remove(selectedStudent);
                    });
                    String sonuc = "Silindi: " +
                        selectedStudent.firstName +
                        " " +
                        selectedStudent.lastName;
                    sonucGoster(context, sonuc);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String sonucHesapla(int not) {
    String sonuc = "";
    if (not >= 50) {
      sonuc = "Geçtiniz!";
    } else if (not >= 40) {
      sonuc = "Bütünlemeye Kaldınız!";
    } else {
      sonuc = "Kaldınız!";
    }
    return sonuc;
  }

  void sonucGoster(BuildContext context, String sonuc) {
    var alert = AlertDialog(
      title: Text("SONUÇ:"),
      content: Text(sonuc),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildStatusIcon(var grade) {
    if (grade >= 50) {
      return Icon(Icons.done_all);
    } else if (grade >= 40) {
      return Icon(Icons.done);
    } else {
      return Icon(Icons.clear);
    }
  }
}
