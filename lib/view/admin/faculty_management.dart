import 'dart:developer';

import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/constants/utils/color_utils.dart';
import 'package:campus_connects/constants/utils/size_utils.dart';
import 'package:campus_connects/models/announcements_management_model.dart';
import 'package:campus_connects/models/faculty_management_model.dart';
import 'package:campus_connects/viewModel/announcement_view_model.dart';
import 'package:campus_connects/viewModel/department_view_model.dart';
import 'package:campus_connects/viewModel/faculty_view_model.dart';
import 'package:campus_connects/widgets/custom_elevated_button.dart';
import 'package:campus_connects/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FacultyManagementScreen extends StatefulWidget {
  const FacultyManagementScreen({super.key});

  @override
  State<FacultyManagementScreen> createState() =>
      _FacultyManagementScreenState();
}

class _FacultyManagementScreenState extends State<FacultyManagementScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedDepartment;

  TextEditingController facultyNameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  FocusNode facultyNameFocusNode = FocusNode();
  FocusNode departmentFocusNode = FocusNode();
  FocusNode addButtonFocusNode = FocusNode();
  FocusNode updateButtonFocusNode = FocusNode();
  FocusNode deleteButtonFocusNode = FocusNode();



  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).size;
    var facultyViewModel = Provider.of<FacultyViewModel>(context);
    final departmentProvider = Provider.of<DepartmentViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: facultyNameController,
                focusNode: facultyNameFocusNode,
                margin: getMargin(left: 7, top: 21),
                contentPadding:
                    getPadding(left: 16, top: 25, right: 16, bottom: 18),
                hintText: "Faculty Name",
                autofocus: false,
                fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                validator: RequiredValidator(errorText: "Required *").call,
                // onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
              ),
              // CustomTextFormField(
              //   controller: departmentController,
              //   focusNode: departmentFocusNode,
              //   margin: getMargin(left: 7, top: 21),
              //   contentPadding:
              //       getPadding(left: 16, top: 25, right: 16, bottom: 18),
              //   hintText: "Department",
              //   autofocus: false,
              //   fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              //   hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              //   textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              //   validator: RequiredValidator(errorText: "Required *").call,
              //   //  onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
              // ),
              SizedBox(height: 10,),
              SizedBox(
                width: mediaQueryData.width * 0.8,
                height: mediaQueryData.height * 0.08,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Select Department'),
                  value: _selectedDepartment,
                  items: departmentProvider.departmemtNames.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(value,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDepartment = newValue;
                    });
                    departmentController.text = _selectedDepartment!;
                    print('Selected department: $_selectedDepartment');
                  },
                ),
              ),
              // CustomTextFormField(
              //   controller: departmentController,
              //   focusNode: departmentFocusNode,
              //   margin: getMargin(left: 7, top: 21),
              //   contentPadding:
              //   getPadding(left: 16, top: 25, right: 16, bottom: 18),
              //   hintText: "Department",
              //   autofocus: false,
              //   fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              //   hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              //   textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              //   validator: RequiredValidator(errorText: "Required *").call,
              //   //  onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
              // ),
              const SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                height: mediaQueryData.height * 0.075,
                width: mediaQueryData.width * 0.7,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    facultyViewModel.createFacultyCalling(context, facultyName: facultyNameController.text, departmentName: departmentController.text);
                  } else {
                    Constants.toastMessage("Please enter the valid fields");
                  }
                  // Provider.of<FacultyViewModel>(context, listen: false).addToList(
                  //     facultyNameController.text, departmentController.text);
                },
                text: "ADD FACULTY",
                focusNode: addButtonFocusNode,
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                buttonTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: ColorUtils().whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<FacultyViewModel>(context, listen: true).getAllFacultyCalling(context),
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
                          FacultyManagementModel facultyModel = FacultyManagementModel.fromDocumentSnapshot(documentsnapshot: data[index]
                          );
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              style: ListTileStyle.list,
                              tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              title: Text(
                                "${facultyModel.facultyName}",
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                "${facultyModel.departmentName}",
                                style: Theme.of(context).textTheme.titleSmall
                              ),
                              trailing: SizedBox(
                                width: mediaQueryData.width * 0.07,
                                height: mediaQueryData.height,
                                child: IconButton(
                                  onPressed: () {
                                    Provider.of<FacultyViewModel>(context, listen: false).deleteFacultyCalling(
                                      context,
                                      facultyId: facultyModel.id,
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
              )
              // Expanded(
              //   child: Consumer<FacultyViewModel>(
              //       builder: (context, consumer, child) {
              //     return consumer.model.isEmpty
              //         ? Center(
              //             child: Text("No Data Available"),
              //           )
              //         : ListView.builder(
              //             shrinkWrap: true,
              //             physics: const NeverScrollableScrollPhysics(),
              //             itemCount: consumer.model.length,
              //             itemBuilder: (context, index) {
              //               return Padding(
              //                 padding: const EdgeInsets.symmetric(vertical: 8.0),
              //                 child: ListTile(
              //                   style: ListTileStyle.list,
              //                   tileColor: Theme.of(context)
              //                       .colorScheme
              //                       .primary
              //                       .withOpacity(0.1),
              //                   title: Text(
              //                     consumer.model[index].facultyName!,
              //                     style: Theme.of(context).textTheme.titleMedium,
              //                   ),
              //                   subtitle: Text(
              //                     consumer.model[index].departmentName!,
              //                     style: Theme.of(context).textTheme.titleSmall,
              //                   ),
              //                   trailing: SizedBox(
              //                     width: mediaQueryData.width * 0.3,
              //                     height: mediaQueryData.height,
              //                     child: Row(
              //                       children: [
              //                         IconButton(
              //                           onPressed: () {
              //                             consumer.updateFromList(
              //                                 index,
              //                                 facultyNameController.text,
              //                                 departmentController.text);
              //                           },
              //                           icon: Icon(Icons.edit),
              //                         ),
              //                         SizedBox(width: 10),
              //                         IconButton(
              //                           onPressed: () {
              //                             consumer.removeFromList(index);
              //                           },
              //                           icon: Icon(Icons.delete),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             });
              //   }),
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
