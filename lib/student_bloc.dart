import 'dart:async';
import 'package:flutter/material.dart';
import 'student.dart';

class StudentBloc {
  final List<Student> _studentList = [
    Student(1, 'Fadi', 85,
        'https://images.pexels.com/photos/39866/entrepreneur-startup-start-up-man-39866.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    Student(2, 'Ali', 50,
        'https://images.pexels.com/photos/837358/pexels-photo-837358.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    Student(3, 'Ahmed', 35,
        'https://images.pexels.com/photos/9965370/pexels-photo-9965370.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
    Student(4, 'Abdo', 5,
        'https://images.pexels.com/photos/2941090/pexels-photo-2941090.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
  ];

  // Stream Controllers

  final _studentListStreamController = StreamController<List<Student>>();
  final _studentScoreIncrementStreamController = StreamController<Student>();
  final _studentScoreDecrementStreamController = StreamController<Student>();


  // Stram and Sink

  Stream<List<Student>> get studentListStream => _studentListStreamController.stream;
  StreamSink<List<Student>> get studentListSink => _studentListStreamController.sink;
  StreamSink<Student> get studentScoreIncrement => _studentScoreIncrementStreamController.sink;
  StreamSink<Student> get studentScoreDecrement => _studentScoreDecrementStreamController.sink;

  // Constructor

  StudentBloc(){
    _studentListStreamController.add(_studentList);
    _studentScoreIncrementStreamController.stream.listen(_incrementScore);
    _studentScoreDecrementStreamController.stream.listen(_decrementScore);
  }

  // Core Functions

  _incrementScore(Student student){
    double score = student.score;
    double incrementValue = 0.5;
    if(student.score<100)
      {
        _studentList[student.id-1].score = score+incrementValue;
      }
    studentListSink.add(_studentList);
  }
  _decrementScore(Student student){
    double score = student.score;
    double decrementValue = -0.5;
    if(student.score>0)
    {
      _studentList[student.id-1].score = score+decrementValue;
    }
    studentListSink.add(_studentList);
  }


  //Dispose


  void dispose()
  {
     _studentListStreamController.close();
     _studentScoreIncrementStreamController.close();
     _studentScoreDecrementStreamController.close();
  }
}
