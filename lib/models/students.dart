class Student {
  var id;
  var firstName;
  var lastName;
  var grade;
  // ignore: unused_field
  var _statue;
  var icon;

  Student.withId(this.id, this.firstName, this.lastName, this.grade);
  Student(this.firstName, this.lastName, this.grade);
  // ignore: empty_constructor_bodies
  Student.withoutInfo() {}

  String get getStatue {
    var _statue = "";
    if (grade >= 50) {
      _statue = "Başarıyla Geçtiniz.";
    } else if (grade >= 40) {
      _statue = "Bütünlemeye Girmelisiniz.";
    } else {
      _statue = "Kaldınız.";
    }
    return _statue;
  }
}
