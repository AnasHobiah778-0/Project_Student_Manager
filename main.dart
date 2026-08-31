import 'dart:io';

List<Person> ListOFPersons= [];

abstract class Person{
  static int _counter=1;

  final int id;
  late String name ;
  late String department;



  Person({required this.id, required this.name, required this.department});
  
  void printDetail();


  static int generateID() {
    return _counter++;
  }

  bool hasID(int PersonID) {
    return this.id == PersonID;
  }

}

class Student extends Person{
   late int level;
   late double _average; 

    double get average => _average;

  set setAverage(double studentAverage) {
    if(studentAverage >=0 && studentAverage <=100) {
      _average = studentAverage;
    }else{
      throw Exception("Average Must be Between 0 And 100");
    }
  }

  Student({
    required super.id,
    required super.name,
    required super.department,
    required this.level,
    required double StudentAverage,  
  }) {
    this.setAverage = StudentAverage;
  }


  Student.Guest() : this.level = 1, this._average = 0, super(id: 0, name: 'Unknown', department: 'Unknown');

  @override
  void printDetail(){
    print('Student ID: ${super.id}| Name: ${super.name}| Department: ${super.department}| Level: ${this.level}| Average: ${this._average}');
  }
}

class Doctors extends Person{
  late int Salary;

  Doctors({
    required super.id,
    required super.name,
    required super.department,
    required this.Salary,
  });


  @override
  void printDetail(){
    print('Doctor ID: ${super.id}| Name: ${super.name}| Department: ${super.department}| Salary: ${this.Salary}');
  }
  
}

void main() {
    String addName ='Student Management';
    print(addName);

    bool work =true;
    while(work) {
    showMessage();
    String Number =stdin.readLineSync()?? "";
    switch(Number) {
      case '1':
        addStudent();
        break;
      case '2':
        removePerson();
        break;
      case '3':
        showPerson();
        break;
      case '4':
        findPerson();
        break;
      case '5':
        addGuestStudent();
        break;
      case '6':
        addDoctor();
        break;
      case '7':
      work =false;
      break;
      default:
        print('Invalid Number');
    }
    
    }
    
}

void showMessage() {
    print('Choose 1 to Add Student');
    print('Choose 2 to Remove Student');
    print('Choose 3 to Show Student');
    print('Choose 4 to Find Student');
    print('Choose 5 to Gust Student');
    print('Choose 6 to Add Doctor');
    print('Choose 7 to Stop The System');
    stdout.write("Choose Number:");
}

void addStudent() {
  stdout.write("Enter Name:");
  String fullName =stdin.readLineSync()?? "";

  stdout.write("Enter level:");
  int studentLevel =int.tryParse(stdin.readLineSync()?? "") ?? 1;
 
  stdout.write("Enter Department:");
  String studentDepartment =stdin.readLineSync()?? "";

  stdout.write("Enter Average:");
  double studentAVerage =double.tryParse(stdin.readLineSync()?? "") ?? 0.0;


  ListOFPersons.add(
    Student(
    id: Person.generateID(),
    name: fullName,
    level: studentLevel,
    department:  studentDepartment,
    StudentAverage: studentAVerage
  )
);

  print('Added Successful');
}

void addDoctor() {
  stdout.write("Enter Name:");
  String fullName =stdin.readLineSync()?? "";
 
  stdout.write("Enter Department:");
  String doctorDepartment =stdin.readLineSync()?? "";
  
  stdout.write("Enter Salary:");
  int doctorSalary =int.tryParse(stdin.readLineSync()?? "") ?? 0;

   try {
    ListOFPersons.add(
    Doctors(
    id: Person.generateID(),
    name: fullName,
    department:  doctorDepartment,
    Salary: doctorSalary
  ));
  }catch (e) {
  print(e);
}
   
  print('Student Add Successful');
}


void addGuestStudent() {
  ListOFPersons.add(Student.Guest());
  print('Guest Student Add Successfully');
}

void removePerson() {
  stdout.write("Enter ID:");
  int? id =int.tryParse(stdin.readLineSync()?? "");
  if(id ==null){
    print('Invalid');
    return;
  }
  ListOFPersons.removeWhere((Person)=>Person.hasID(id));
  print('Remove Done');
}

void showPerson() {
  if(ListOFPersons.isEmpty) {
    print('The List is Empty');
    return;
  }
  for(Person student in ListOFPersons){
      student.printDetail();
}
}

void findPerson() {
  if(ListOFPersons.isEmpty) {
    print('The List is Empty');
    return;
  }

  stdout.write("Enter ID:");
  int? id =int.tryParse(stdin.readLineSync()?? "");
  if(id ==null){
    print('Invalid');
    return;
  }
  for(Person student in ListOFPersons) {
       if(student.hasID(id))  {
          student.printDetail();
          return;
        }
    }
  
  print('Student is Not Found');
}
