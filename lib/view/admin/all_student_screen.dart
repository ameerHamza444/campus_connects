

import 'dart:developer';

import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/models/student_management_model.dart';
import 'package:campus_connects/models/user_model.dart';
import 'package:campus_connects/viewModel/student_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllStudentScreen extends StatefulWidget {
  const AllStudentScreen({super.key});

  @override
  State<AllStudentScreen> createState() => _AllStudentScreenState();
}

class _AllStudentScreenState extends State<AllStudentScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,

        /// todo: will work on them later
        title: Text("All Students"),
      ),
      body: SafeArea(
        child: Expanded(
          child: FutureBuilder(
            future: Provider.of<StudentViewModel>(context, listen: true).getAllStudentsCalling(context),
            builder: (context, snapshot) {
              log("data snapshot: ${snapshot.data}");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }
              // Handle errors
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              // Ensure data is not null
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text(
                    'No data available',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              }
              // Access the documents from the snapshot
              var data = (snapshot.data as QuerySnapshot).docs;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    StudentManagementModel studentModel = StudentManagementModel.fromDocumentSnapshot(documentsnapshot: data[index]
                    );
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap:() {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Student Details'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Name: ${studentModel.studentName}'),
                                      Text('Department: ${studentModel.departmentName}'),
                                      Text('Advisor: ${studentModel.advisor}'),
                                      Text('Semester: ${studentModel.semester}'),
                                      Text('Grades: ${studentModel.grades}'),
                                      Text('CGPA: ${studentModel.cgpa}'),
                                      Text('DOB: ${studentModel.dob}'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );

                        },
                        style: ListTileStyle.list,
                        tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        title: Text(
                            "${studentModel.studentName}",
                            style: Theme.of(context).textTheme.titleMedium
                        ),
                        trailing: SizedBox(
                          width: mediaQueryData.width * 0.07,
                          height: mediaQueryData.height,
                          child: IconButton(
                            onPressed: () {
                              Provider.of<StudentViewModel>(context, listen: false).deleteStudentCalling(
                                context,
                                studentId: studentModel.id,
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
