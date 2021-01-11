import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:votingweb/Services/services.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String studentName, studentID, studentCourse;
  double studentGPA;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id) {
    this.studentID = id;
  }

  getCourse(studCourse) {
    this.studentCourse = studCourse;
  }

  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white30,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            width: size.width * .4,
            height: size.height * .85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('LIST OF STUDENTS',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 9, 5, 9),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Name",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          )),
                      onChanged: (String name) {
                        getStudentName(name);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 9, 5, 9),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Student ID",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          )),
                      onChanged: (String id) {
                        getStudentID(id);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 9, 5, 9),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Course",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          )),
                      onChanged: (String course) {
                        getCourse(course);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 9, 5, 9),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "GPA",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          )),
                      onChanged: (String gpa) {
                        getStudentGPA(gpa);
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text('Add'),
                        textColor: Colors.white,
                        onPressed: () {
                          _formKey.currentState.validate();
                          DatabaseService().createData(studentName, studentID,
                              studentCourse, studentGPA);
                        },
                      ),
                      RaisedButton(
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text('Update'),
                        textColor: Colors.white,
                        onPressed: () {
                          DatabaseService().updateData(studentName, studentID,
                              studentCourse, studentGPA);
                        },
                      ),
                      RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text('Delete'),
                        textColor: Colors.white,
                        onPressed: () {
                          DatabaseService().deleteData(studentName);
                        },
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Expanded(
                          child: Text('Name'),
                        ),
                        Expanded(
                          child: Text('Student ID'),
                        ),
                        Expanded(
                          child: Text('Course'),
                        ),
                        Expanded(
                          child: Text('GPA'),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('MyStudents')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data.documents[index];
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:
                                          Text(documentSnapshot['studentName']),
                                    ),
                                    Expanded(
                                      child:
                                          Text(documentSnapshot['studentID']),
                                    ),
                                    Expanded(
                                      child: Text(
                                          documentSnapshot['studentCourse']),
                                    ),
                                    Expanded(
                                      child: Text(documentSnapshot['studentGPA']
                                          .toString()),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: CircularProgressIndicator(),
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
