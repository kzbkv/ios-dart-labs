class Student {
  String name;
  String surname;
  double averageGrade;

  Student(this.name, this.surname, this.averageGrade);
}

class StudentJournal {
  List<Student> students = [];

  void addStudent(Student student) {
    students.add(student);
    print('Студент ${student.name} ${student.surname} добавлен в журнал.');
  }

  void removeStudent(String name, String surname) {
    students.removeWhere((student) => student.name == name && student.surname == surname);
    print('Студент $name $surname удален из журнала.');
  }

  void displayStudents() {
    if (students.isEmpty) {
      print('Журнал пуст.');
    } else {
      print('Студенты в журнале:');
      for (var student in students) {
        print('${student.name} ${student.surname}, Средний балл: ${student.averageGrade}');
      }
    }
  }

  void displayStudentsByGradeDescending() {
    if (students.isEmpty) {
      print('Журнал пуст.');
    } else {
      students.sort((a, b) => b.averageGrade.compareTo(a.averageGrade));
      print('Студенты в журнале по убыванию среднего балла:');
      for (var student in students) {
        print('${student.name} ${student.surname}, Средний балл: ${student.averageGrade}');
      }
    }
  }

  double calculateAverageGrade() {
    if (students.isEmpty) {
      return 0.0;
    } else {
      double totalGrade = 0.0;
      for (var student in students) {
        totalGrade += student.averageGrade;
      }
      return totalGrade / students.length;
    }
  }

  Student getStudentWithHighestGrade() {
    if (students.isEmpty) {
      return Student('', '', 0.0);
    } else {
      students.sort((a, b) => b.averageGrade.compareTo(a.averageGrade));
      return students.first;
    }
  }
}

void main() {
  var journal = StudentJournal();

  journal.addStudent(Student('Иван', 'Иванов', 4.5));
  journal.addStudent(Student('Петр', 'Петров', 3.8));
  journal.addStudent(Student('Анна', 'Сидорова', 4.9));

  journal.displayStudents();

  print('\nСредний балл по всем студентам в журнале: ${journal.calculateAverageGrade()}');

  var studentWithHighestGrade = journal.getStudentWithHighestGrade();
  print('\nСтудент с самым высоким средним баллом: ${studentWithHighestGrade.name} ${studentWithHighestGrade.surname}, Средний балл: ${studentWithHighestGrade.averageGrade}');

  print('\nСтуденты в журнале по убыванию среднего балла:');
  journal.displayStudentsByGradeDescending();

  journal.removeStudent('Петр', 'Петров');

  journal.displayStudents();
}
