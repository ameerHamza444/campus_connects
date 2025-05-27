import 'dart:developer';

import 'package:campus_connects/constants/utils/color_utils.dart';
import 'package:campus_connects/constants/utils/size_utils.dart';
import 'package:campus_connects/models/student_management_model.dart';
import 'package:campus_connects/viewModel/department_view_model.dart';
import 'package:campus_connects/viewModel/student_view_model.dart';
import 'package:campus_connects/widgets/custom_elevated_button.dart';
import 'package:campus_connects/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:campus_connects/constants/app_export.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController studentNameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController advisorController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController gradesController = TextEditingController();
  TextEditingController cgpaController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  FocusNode studentNameFocusNode = FocusNode();
  FocusNode departmentFocusNode = FocusNode();
  FocusNode advisorFocusNode = FocusNode();
  FocusNode semesterFocusNode = FocusNode();
  FocusNode gradesFocusNode = FocusNode();
  FocusNode cgpaFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode addButtonFocusNode = FocusNode();
  FocusNode updateButtonFocusNode = FocusNode();
  FocusNode deleteButtonFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Provider.of<DepartmentViewModel>(context, listen: false).getAllDepartmentCalling(context);
    Provider.of<StudentViewModel>(context, listen: false).getAllUsersNamesCalling(context);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).size;
    // var studentViewModel = Provider.of<StudentViewModel>(context);
    // final departmentProvider = Provider.of<DepartmentViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Provider.of<StudentViewModel>(context, listen: false)
              //     .clearStudentNamesList();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.allStudentScreen);
              },
              child: Text(
                "Show All Students",
                style: Theme.of(context).textTheme.titleMedium,
              ))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: mediaQueryData.width * 0.8,
                  height: mediaQueryData.height * 0.08,
                  child: Consumer<StudentViewModel>(
                    builder: (context, consumer, child) {
                      print('Dropdown rebuild: ${consumer.studentNames}, selected: ${consumer.selectedStudentName}');
                      return DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Select Student'),
                        value: consumer.selectedStudentName.isNotEmpty ? consumer.selectedStudentName : null,
                        items: consumer.studentNames.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            consumer.setSelectedStudentName(newValue);
                            studentNameController.text = consumer.selectedStudentName;
                          }
                        },
                      );
                    },
                  ),
            
                ),
                SizedBox(
                  width: mediaQueryData.width * 0.8,
                  height: mediaQueryData.height * 0.08,
                  child: Consumer<DepartmentViewModel>(
                    builder: (context, consumer, child) {
                      return DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Select Department'),
                        value: consumer.selectedDepartment.isNotEmpty ? consumer.selectedDepartment : null,
                        items: consumer.departmemtNames.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            consumer.setSelectedDepartment(newValue);
                            departmentController.text = consumer.selectedDepartment;
                          }
                        },
                      );
                    }
                  ),
                ),
                CustomTextFormField(
                  controller: advisorController,
                  focusNode: advisorFocusNode,
                  margin: getMargin(left: 7, top: 21),
                  contentPadding:
                  getPadding(left: 16, top: 25, right: 16, bottom: 18),
                  hintText: "Advisor",
                  autofocus: false,
                  fillColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  validator: RequiredValidator(errorText: "Required *").call,
                  //  onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
                ),
                CustomTextFormField(
                  controller: semesterController,
                  focusNode: semesterFocusNode,
                  margin: getMargin(left: 7, top: 21),
                  contentPadding:
                  getPadding(left: 16, top: 25, right: 16, bottom: 18),
                  hintText: "Semester",
                  autofocus: false,
                  fillColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  validator: RequiredValidator(errorText: "Required *").call,
                  //  onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
                ),
                CustomTextFormField(
                  controller: gradesController,
                  focusNode: gradesFocusNode,
                  margin: getMargin(left: 7, top: 21),
                  contentPadding:
                  getPadding(left: 16, top: 25, right: 16, bottom: 18),
                  hintText: "Grades",
                  autofocus: false,
                  fillColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  validator: RequiredValidator(errorText: "Required *").call,
                  //  onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
                ),
                CustomTextFormField(
                  controller: cgpaController,
                  focusNode: cgpaFocusNode,
                  margin: getMargin(left: 7, top: 21),
                  contentPadding:
                  getPadding(left: 16, top: 25, right: 16, bottom: 18),
                  hintText: "CGPA",
                  autofocus: false,
                  fillColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  validator: RequiredValidator(errorText: "Required *").call,
                  //  onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
                ),
                CustomTextFormField(
                  controller: dobController,
                  focusNode: dobFocusNode,
                  margin: getMargin(left: 7, top: 21),
                  contentPadding:
                  getPadding(left: 16, top: 25, right: 16, bottom: 18),
                  hintText: "DOB",
                  autofocus: false,
                  fillColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  validator: RequiredValidator(errorText: "Required *").call,
                  //  onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
                ),


                SizedBox(
                  height: 20,
                ),
                Provider.of<StudentViewModel>(context, listen: false).isCreatingStudent == true ?
                    const SizedBox(child: LinearProgressIndicator())
                    :
                CustomElevatedButton(
                  height: mediaQueryData.height * 0.075,
                  width: mediaQueryData.width * 0.7,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<StudentViewModel>(context, listen: false).createStudentCalling(
                        context,
                        studentName: studentNameController.text,
                        departmentName: departmentController.text,
                        advisor: advisorController.text,
                        semester: semesterController.text,
                        grades: gradesController.text,
                        cgpa: cgpaController.text,
                        dob: dobController.text,
                      );
                    } else {
                      Constants.toastMessage("Please enter the valid fields");
                    }
                  },
                  text: "ADD STUDENT",
                  focusNode: addButtonFocusNode,
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  buttonTextStyle:
                      Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: ColorUtils().whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Expanded(
                //   child: FutureBuilder(
                //     future: Provider.of<StudentViewModel>(context, listen: true)
                //         .getAllStudentsCalling(context),
                //     builder: (context, snapshot) {
                //       log("data snapshot: ${snapshot.data}");
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //           child: CircularProgressIndicator(
                //             color: Theme.of(context).colorScheme.primary,
                //           ),
                //         );
                //       }
                //       // Handle errors
                //       if (snapshot.hasError) {
                //         return Center(
                //           child: Text('Error: ${snapshot.error}'),
                //         );
                //       }
                //
                //       // Ensure data is not null
                //       if (!snapshot.hasData || snapshot.data == null) {
                //         return Center(
                //           child: Text(
                //             'No data available',
                //             style: Theme.of(context).textTheme.titleMedium,
                //           ),
                //         );
                //       }
                //       // Access the documents from the snapshot
                //       var data = (snapshot.data as QuerySnapshot).docs;
                //       return Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 15, vertical: 20),
                //         child: ListView.builder(
                //           shrinkWrap: true,
                //           itemCount: data.length,
                //           itemBuilder: (context, index) {
                //             StudentManagementModel studentModel =
                //                 StudentManagementModel.fromDocumentSnapshot(
                //                     documentsnapshot: data[index]);
                //             return Padding(
                //               padding: const EdgeInsets.all(10.0),
                //               child: ListTile(
                //                 style: ListTileStyle.list,
                //                 tileColor: Theme.of(context)
                //                     .colorScheme
                //                     .primary
                //                     .withOpacity(0.1),
                //                 title: Text(
                //                   "${studentModel.studentName}",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .titleMedium!
                //                       .copyWith(
                //                         fontWeight: FontWeight.w700,
                //                       ),
                //                 ),
                //                 subtitle: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "${studentModel.departmentName}",
                //                       style:
                //                           Theme.of(context).textTheme.titleSmall,
                //                     ),
                //                     Text(
                //                       "${studentModel.advisor}",
                //                       style:
                //                           Theme.of(context).textTheme.titleSmall,
                //                     ),
                //                   ],
                //                 ),
                //                 trailing: SizedBox(
                //                   width: mediaQueryData.width * 0.07,
                //                   height: mediaQueryData.height,
                //                   child: IconButton(
                //                     onPressed: () {
                //                       Provider.of<StudentViewModel>(context,
                //                               listen: false)
                //                           .deleteStudentCalling(
                //                         context,
                //                         studentId: studentModel.id,
                //                       );
                //                     },
                //                     icon: Icon(Icons.delete),
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       );
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
