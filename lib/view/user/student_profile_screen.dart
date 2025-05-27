import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/view/user/clubnactivity_signup.dart';
import 'package:campus_connects/viewModel/auth_view_model.dart';
import 'package:campus_connects/viewModel/student_view_model.dart';
import 'package:campus_connects/widgets/custom_setting_field.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentProfileScreen extends StatefulWidget {
  final String userId;

  const StudentProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Provider.of<StudentViewModel>(context, listen: false)
    //     .getCurrentStudentCalling(context, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentViewModel>(context, listen: false).getCurrentStudentCalling(context, widget.userId);
    Provider.of<StudentViewModel>(context, listen: false).getCurrentUsserCalling(context, widget.userId);
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,

          /// todo: will work on them later
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: CircleAvatar(
                      //     radius: 35,
                      //     backgroundColor: Theme.of(context).colorScheme.primary,
                      //   ),
                      // ),
                      Expanded(
                        flex: 3,
                        child: Consumer<StudentViewModel>(
                            builder: (context, consumer, c) {
                          return consumer.isLoadingCurrentStudent == true
                              ? const LinearProgressIndicator()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      consumer.userModel!.name ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      consumer.userModel!.email ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                );
                        }),
                      )
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Consumer<StudentViewModel>(
                          builder: (context, consumer, c) {
                        return SettingFields(
                          icon: Icons.info_outline_rounded,
                          title: "Student Information",
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Student Details'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Name: ${consumer.studentManagementModel!.studentName}'),
                                      Text(
                                          'Department: ${consumer.studentManagementModel!.departmentName}'),
                                      Text(
                                          'Advisor: ${consumer.studentManagementModel!.advisor}'),
                                      Text(
                                          'Semester: ${consumer.studentManagementModel!.semester}'),
                                      Text(
                                          'Grades: ${consumer.studentManagementModel!.grades}'),
                                      Text(
                                          'CGPA: ${consumer.studentManagementModel!.cgpa}'),
                                      Text(
                                          'DOB: ${consumer.studentManagementModel!.dob}'),
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
                        );
                      }),
                      SettingFields(
                        icon: Icons.local_activity_outlined,
                        title: "Clubs & Activity Sign-Up",
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  contentPadding: const EdgeInsets.all(20),
                                  title: const Text("Clubs & Activity Sign-Up"),
                                  children: [
                                    const Text(
                                        "Please Register In Current Activity or Club"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  AppRoutes
                                                      .clubNactitvitySignUpScreen);
                                            },
                                            child: const Text("Enroll Now")),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel")),
                                      ],
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                      SettingFields(
                        icon: Icons.quick_contacts_dialer_outlined,
                        title: "Emergency Contact",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                contentPadding: const EdgeInsets.all(20),
                                title: const Text("Emergency Contact"),
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final Uri emailUri = Uri(
                                        scheme: 'mailto',
                                        path: 'admin@gmail.com',
                                        query:
                                            'subject=Emergency&body=Hello, I need help',
                                      );
                                      if (await canLaunchUrl(emailUri)) {
                                        await launchUrl(emailUri);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Could not open email app')),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "E-mail: admin@gmail.com",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () async {
                                      final Uri phoneUri = Uri(
                                        scheme: 'tel',
                                        path: '+923123456789',
                                      );
                                      if (await canLaunchUrl(phoneUri)) {
                                        await launchUrl(phoneUri);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Could not make a call')),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "Phone: +92312-3456789",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SettingFields(
                        icon: Icons.map_outlined,
                        title: "Campus Map & Navigation",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.mapNnavigationScreen);
                        },
                      ),
                      SettingFields(
                        icon: Icons.logout,
                        title: "Sign out",
                        onTap: () {
                          Provider.of<AuthViewModel>(context, listen: false)
                              .signOutUser(context);
                        },
                      ),
                      Provider.of<AuthViewModel>(context).isSignOut
                          ? const LinearProgressIndicator()
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     margin: const EdgeInsets.only(
                //       bottom: 25,
                //     ),
                //     child: RichText(
                //       text: TextSpan(
                //           text: "Version",
                //           style:
                //               Theme.of(context).textTheme.titleMedium!.copyWith(
                //                     color: Theme.of(context).colorScheme.primary,
                //                     fontWeight: FontWeight.bold,
                //                     letterSpacing: 1.7,
                //                   ),
                //           children: [
                //             TextSpan(
                //               text: "\t2.0.1",
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .titleMedium!
                //                   .copyWith(
                //                     fontWeight: FontWeight.bold,
                //                     letterSpacing: 1.2,
                //                   ),
                //             )
                //           ]),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}
