import 'package:campus_connects/models/user_model.dart';
import 'package:campus_connects/view/user/announcement_screen.dart';
import 'package:campus_connects/view/user/discussion_form.dart';
import 'package:campus_connects/view/user/event_calender.dart';
import 'package:campus_connects/view/admin/home_screen.dart';
import 'package:campus_connects/view/admin/profile_screen.dart';
import 'package:campus_connects/view/user/student_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:campus_connects/constants/app_export.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomAdminNavigationBar extends StatefulWidget {
  final UserModel userModel;
  const CustomAdminNavigationBar({super.key, required this.userModel});

  @override
  State<CustomAdminNavigationBar> createState() =>
      _CustomAdminNavigationBarState();
}

class _CustomAdminNavigationBarState extends State<CustomAdminNavigationBar> {
  PersistentTabController? controller;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    // UserModel? arguments = ModalRoute.of(context)!.settings.arguments as UserModel?;
    // if (kDebugMode) {
    //   print("userDetails from navBar: $arguments");
    // }
    print("User Model: ${widget.userModel.toJson()}");
    var user = widget.userModel;
    return user.role == "admin"
        ? PopScope(
            canPop: false,
            child: PersistentTabView(
              controller: controller,
              backgroundColor: Theme.of(context).colorScheme.surface,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: true,
              navBarHeight: 60,
              tabs: [
                /// todo: Home
                PersistentTabConfig(
                  screen: HomeScreen(),
                  item: ItemConfig(
                    icon: Icon(
                      Icons.home,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    inactiveIcon: Icon(
                      Icons.home,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    activeForegroundColor:
                        Theme.of(context).colorScheme.primary,
                    inactiveForegroundColor: Theme.of(context).iconTheme.color!,
                    title: "Home",
                    textStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  navigatorConfig: NavigatorConfig(
                    routes: AppRoutes.routes,
                    onGenerateRoute: (settings) =>
                        AppRoutes.onGenerateRoute(settings),
                    // onGenerateRoute: (settings) {
                    //   return AppRoutes.onGenerateRoute(settings);
                    // }
                  ),
                ),

                /// todo: Calender
                // PersistentTabConfig(
                //   screen: EventCalenderScreen(),
                //   item: ItemConfig(
                //     icon: Icon(
                //       Icons.calendar_month_outlined,
                //       color: Theme.of(context).colorScheme.primary,
                //     ),
                //     inactiveIcon: Icon(
                //       Icons.calendar_today_outlined,
                //       color: Theme.of(context).iconTheme.color,
                //     ),
                //     activeForegroundColor: Theme.of(context).colorScheme.primary,
                //     inactiveForegroundColor: Theme.of(context).iconTheme.color!,
                //     title: "Calender",
                //     textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   navigatorConfig: NavigatorConfig(
                //       routes: AppRoutes.routes,
                //     onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
                //       // onGenerateRoute: (settings) {
                //       //   return AppRoutes.onGenerateRoute(settings);
                //       // }
                //       ),
                // ),
                /// todo: Discussion Form
                // PersistentTabConfig(
                //   screen: DiscussionFormScreen(),
                //   item: ItemConfig(
                //     icon: Icon(
                //       Icons.chat_outlined,
                //       color: Theme.of(context).colorScheme.primary,
                //     ),
                //     inactiveIcon: Icon(
                //       Icons.mark_unread_chat_alt_outlined,
                //       color: Theme.of(context).iconTheme.color,
                //     ),
                //     activeForegroundColor: Theme.of(context).colorScheme.primary,
                //     inactiveForegroundColor: Theme.of(context).iconTheme.color!,
                //     title: "Form",
                //     textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   navigatorConfig: NavigatorConfig(
                //       routes: AppRoutes.routes,
                //     onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
                //       // onGenerateRoute: (settings) {
                //       //   return AppRoutes.onGenerateRoute(settings);
                //       // }
                //       ),
                // ),

                /// todo: profile
                PersistentTabConfig(
                  screen: ProfileScreen(),
                  item: ItemConfig(
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    inactiveIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    activeForegroundColor:
                        Theme.of(context).colorScheme.primary,
                    inactiveForegroundColor: Theme.of(context).iconTheme.color!,
                    title: "Me",
                    textStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  navigatorConfig: NavigatorConfig(
                    routes: AppRoutes.routes,
                    onGenerateRoute: (settings) =>
                        AppRoutes.onGenerateRoute(settings),
                    // onGenerateRoute: (settings) {
                    //   return AppRoutes.onGenerateRoute(settings);
                    // }
                  ),
                ),
              ],
              navBarBuilder: (navBarConfig) => Style2BottomNavBar(
                navBarConfig: navBarConfig,
                navBarDecoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          )
        : PopScope(
            canPop: false,
            child: PersistentTabView(
              controller: controller,
              backgroundColor: Theme.of(context).colorScheme.surface,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: true,
              navBarHeight: 60,
              tabs: [
                /// todo: Home
                PersistentTabConfig(
                  screen: AnnouncementScreen(),
                  item: ItemConfig(
                    icon: Icon(
                      Icons.notifications_active,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    inactiveIcon: Icon(
                      Icons.notifications_active_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    activeForegroundColor:
                        Theme.of(context).colorScheme.primary,
                    inactiveForegroundColor: Theme.of(context).iconTheme.color!,
                    title: "Notify",
                    textStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  navigatorConfig: NavigatorConfig(
                    routes: AppRoutes.routes,
                    onGenerateRoute: (settings) =>
                        AppRoutes.onGeneratesRoute(settings),
                    // onGenerateRoute: (settings) {
                    //   return AppRoutes.onGenerateRoute(settings);
                    // }
                  ),
                ),

                /// todo: Calender
                PersistentTabConfig(
                  screen: EventCalenderScreen(),
                  item: ItemConfig(
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    inactiveIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    activeForegroundColor:
                        Theme.of(context).colorScheme.primary,
                    inactiveForegroundColor: Theme.of(context).iconTheme.color!,
                    title: "Calender",
                    textStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  navigatorConfig: NavigatorConfig(
                    routes: AppRoutes.routes,
                    onGenerateRoute: (settings) =>
                        AppRoutes.onGeneratesRoute(settings),
                    // onGenerateRoute: (settings) {
                    //   return AppRoutes.onGenerateRoute(settings);
                    // }
                  ),
                ),

                /// todo: Discussion Form
                PersistentTabConfig(
                  screen: DiscussionFormScreen(userId: user.id!,),
                  item: ItemConfig(
                    icon: Icon(
                      Icons.chat_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    inactiveIcon: Icon(
                      Icons.mark_unread_chat_alt_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    activeForegroundColor:
                        Theme.of(context).colorScheme.primary,
                    inactiveForegroundColor: Theme.of(context).iconTheme.color!,
                    title: "Form",
                    textStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  navigatorConfig: NavigatorConfig(
                    routes: AppRoutes.routes,
                    onGenerateRoute: (settings) =>
                        AppRoutes.onGeneratesRoute(settings),
                    // onGenerateRoute: (settings) {
                    //   return AppRoutes.onGenerateRoute(settings);
                    // }
                  ),
                ),

                /// todo: profile
                PersistentTabConfig(
                  screen: StudentProfileScreen(userId: user.id!,),
                  item: ItemConfig(
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    inactiveIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    activeForegroundColor:
                        Theme.of(context).colorScheme.primary,
                    inactiveForegroundColor: Theme.of(context).iconTheme.color!,
                    title: "You",
                    textStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  navigatorConfig: NavigatorConfig(
                    routes: AppRoutes.routes,
                    onGenerateRoute: (settings) =>
                        AppRoutes.onGeneratesRoute(settings),
                    // onGenerateRoute: (settings) {
                    //   return AppRoutes.onGenerateRoute(settings);
                    // }
                  ),
                ),
              ],
              navBarBuilder: (navBarConfig) => Style2BottomNavBar(
                navBarConfig: navBarConfig,
                navBarDecoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          );
  }
}
