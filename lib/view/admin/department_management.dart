
import 'dart:developer';

import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/models/department_management_model.dart';
import 'package:campus_connects/viewModel/department_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:campus_connects/constants/utils/color_utils.dart';
import 'package:campus_connects/constants/utils/size_utils.dart';
import 'package:campus_connects/widgets/custom_elevated_button.dart';
import 'package:campus_connects/widgets/custom_text_form_field.dart';

class DepartmentManagementScreen extends StatefulWidget {
  const DepartmentManagementScreen({super.key});

  @override
  State<DepartmentManagementScreen> createState() =>
      _DepartmentManagementScreenState();
}

class _DepartmentManagementScreenState extends State<DepartmentManagementScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController departmentController = TextEditingController();

  FocusNode departmentFocusNode = FocusNode();
  FocusNode addButtonFocusNode = FocusNode();
  FocusNode updateButtonFocusNode = FocusNode();
  FocusNode deleteButtonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).size;
    var departmentViewModel = Provider.of<DepartmentViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<DepartmentViewModel>(context, listen: false).clearDartmentList();
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
                    controller: departmentController,
                    focusNode: departmentFocusNode,
                    margin: getMargin(left: 7, top: 21),
                    contentPadding:
                    getPadding(left: 16, top: 25, right: 16, bottom: 18),
                    hintText: "Department",
                    autofocus: false,
                    fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    validator: RequiredValidator(errorText: "Required *").call,
                    //  onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    height: mediaQueryData.height * 0.075,
                    width: mediaQueryData.width * 0.7,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        departmentViewModel.createDepartmentCalling(context, departmentName: departmentController.text);
                      } else {
                        Constants.toastMessage("Please enter the valid fields");
                      }
                      // Provider.of<DepartmentViewModel>(context, listen: false).addToList(
                      //     departmentController.text);
                    },
                    text: "ADD DEPARTMENT",
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
                      future: Provider.of<DepartmentViewModel>(context, listen: true).getAllDepartmentCallingForAdmin(context),
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
                              DepartmentManagementModel departmentModel = DepartmentManagementModel.fromDocumentSnapshot(documentsnapshot: data[index]
                              );
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  style: ListTileStyle.list,
                                  tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  title: Text(
                                  "${departmentModel.departmentName}",
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  ),
                                  trailing: SizedBox(
                                    width: mediaQueryData.width * 0.07,
                                    height: mediaQueryData.height,
                                    child: IconButton(
                                      onPressed: () {
                                        Provider.of<DepartmentViewModel>(context, listen: false).deleteDepartmentCalling(
                                          context,
                                          departmentId: departmentModel.id,
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
                  //   child: Consumer<DepartmentViewModel>(
                  //       builder: (context, consumer, child) {
                  //         return consumer.model.isEmpty
                  //             ? Center(
                  //           child: Text("No Data Available"),
                  //         )
                  //             : ListView.builder(
                  //             shrinkWrap: true,
                  //             physics: const ScrollPhysics(),
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
                  //                     consumer.model[index].departmentName!,
                  //                     style: Theme.of(context).textTheme.titleMedium,
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
                  //       }),
                  // ),
                ],
              ),
            ),
          )),
    );
  }
}



// class DepartmentManagementScreen extends StatefulWidget {
//   const DepartmentManagementScreen({super.key});
//
//   @override
//   State<DepartmentManagementScreen> createState() => _DepartmentManagementScreenState();
// }

// class _DepartmentManagementScreenState extends State<DepartmentManagementScreen> {
//
//   TextEditingController departmentController = TextEditingController();
//
//   FocusNode departmentFocusNode = FocusNode();
//   FocusNode addButtonFocusNode = FocusNode();
//   FocusNode updateButtonFocusNode = FocusNode();
//   FocusNode deleteButtonFocusNode = FocusNode();
//
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQueryData = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
//             child: Column(
//               children: [
//                 CustomTextFormField(
//                   controller: departmentController,
//                   focusNode: departmentFocusNode,
//                   margin: getMargin(left: 7, top: 21),
//                   contentPadding: getPadding(left: 16, top: 25, right: 16, bottom: 18),
//                   hintText: "Department",
//                   autofocus: false,
//                   fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//                   hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
//                   textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
//                   validator: RequiredValidator(errorText: "Required *").call,
//                   // onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 CustomElevatedButton(
//                   height: mediaQueryData.height * 0.075,
//                   width: mediaQueryData.width * 0.7,
//                   onTap: (){},
//                   // {
//                   //   loginModel.email = emailController.text;
//                   //   loginModel.password = passwordController.text;
//                   //   if (_formKey.currentState!.validate()) {
//                   //     authViewModel.loginApi(loginModel, context);
//                   //   } else {
//                   //     Constants.toastMessage("Please enter the valid fields");
//                   //   }
//                   // },
//                   text: "ADD DEPARTMENT",
//                   focusNode: addButtonFocusNode,
//                   buttonStyle: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   buttonTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     color: ColorUtils().whiteColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 CustomElevatedButton(
//                   height: mediaQueryData.height * 0.075,
//                   width: mediaQueryData.width * 0.7,
//                   onTap: () {},
//                   // {
//                   //   loginModel.email = emailController.text;
//                   //   loginModel.password = passwordController.text;
//                   //   if (_formKey.currentState!.validate()) {
//                   //     authViewModel.loginApi(loginModel, context);
//                   //   } else {
//                   //     Constants.toastMessage("Please enter the valid fields");
//                   //   }
//                   // },
//                   text: "UPDATE DEPARTMENT",
//                   focusNode: updateButtonFocusNode,
//                   buttonStyle: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   buttonTextStyle:
//                   Theme.of(context).textTheme.titleSmall!.copyWith(
//                     color: ColorUtils().whiteColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 CustomElevatedButton(
//                   height: mediaQueryData.height * 0.075,
//                   width: mediaQueryData.width * 0.7,
//                   onTap: () {},
//                   // {
//                   //   loginModel.email = emailController.text;
//                   //   loginModel.password = passwordController.text;
//                   //   if (_formKey.currentState!.validate()) {
//                   //     authViewModel.loginApi(loginModel, context);
//                   //   } else {
//                   //     Constants.toastMessage("Please enter the valid fields");
//                   //   }
//                   // },
//                   text: "DELETE DEPARTMENT",
//                   focusNode: deleteButtonFocusNode,
//                   buttonStyle: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   buttonTextStyle:
//                   Theme.of(context).textTheme.titleSmall!.copyWith(
//                     color: ColorUtils().whiteColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Expanded(
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: 3,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 8.0),
//                               child: ListTile(
//                                 style: ListTileStyle.list,
//                                 tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                                 title: Text(
//                                   'Department 1',
//                                   style: Theme.of(context).textTheme.titleMedium,
//                                 ),
//                               ),
//                             );
//                           })),
//                 ),
//               ],
//             ),
//           )
//       ),
//     );
//   }
// }
