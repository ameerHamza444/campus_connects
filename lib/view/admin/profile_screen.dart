import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/viewModel/auth_view_model.dart';
import 'package:campus_connects/widgets/custom_setting_field.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,

          /// todo: will work on them later
          actions: [
            //
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Admin",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "admin@gmail.com",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SettingFields(
                        icon: Icons.help_outline,
                        title: "Help & Feedback",
                        onTap: () {
                          //
                        },
                      ),
                      SettingFields(
                        icon: Icons.privacy_tip_outlined,
                        title: "Privacy",
                        onTap: () {
                          //
                        },
                      ),
                      SettingFields(
                        icon: Icons.app_registration,
                        title: "Register Student",
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.registerScreen);
                        },
                      ),
                      SettingFields(
                        icon: Icons.logout,
                        title: "Sign out",
                        onTap: () {
                          Provider.of<AuthViewModel>(context, listen: false).signOutUser(context);
                        },
                      ),

                      Provider.of<AuthViewModel>(context).isSignOut ? const LinearProgressIndicator() : const SizedBox.shrink(),
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
