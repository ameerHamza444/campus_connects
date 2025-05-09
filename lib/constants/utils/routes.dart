import 'package:campus_connects/models/user_model.dart';
import 'package:campus_connects/view/admin/all_student_screen.dart';
import 'package:campus_connects/view/admin/announcement_management.dart';
import 'package:campus_connects/view/admin/clubnactivity_screen.dart';
import 'package:campus_connects/view/admin/event_screen.dart';
import 'package:campus_connects/view/user/announcement_screen.dart';
import 'package:campus_connects/view/admin/department_management.dart';
import 'package:campus_connects/view/admin/faculty_management.dart';
import 'package:campus_connects/view/user/clubnactivity_signup.dart';
import 'package:campus_connects/view/user/login_screen.dart';
import 'package:campus_connects/view/navbar_screen.dart';
import 'package:campus_connects/view/admin/notification_management_screen.dart';
import 'package:campus_connects/view/user/map_navigation_screen.dart';
import 'package:campus_connects/view/user/notification_screen.dart';
import 'package:campus_connects/view/admin/register_screen.dart';
import 'package:campus_connects/view/user/splash_screen.dart';
import 'package:campus_connects/view/admin/student_management_screen.dart';
import 'package:flutter/material.dart';


class AppRoutes {

  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String navBarScreen = '/navBarScreen';
  static const String studentnavBarScreen = '/studentnavBarScreen';
  static const String facultyScreen = '/facultyScreen';
  static const String studentScreen = '/studentScreen';
  static const String departmentScreen = '/departmentScreen';
  static const String announcementScreen = '/announcementScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String splashScreen = '/splashScreen';
  static const String announcementMsgScreen = '/announcementMsgScreen';
  static const String notifyScreen = '/notifyScreen';
  static const String allStudentScreen = '/allStudentScreen';
  static const String addEventScreen = '/addEventScreen';
  static const String clubNactitvitySignUpScreen = '/clubNactitvitySignUpScreen';
  static const String clubNactitvityScreen = '/clubNactitvityScreen';
  static const String mapNnavigationScreen = '/mapNnavigationScreen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen(),
    facultyScreen: (context) => const FacultyManagementScreen(),
    studentScreen: (context) => const StudentManagementScreen(),
    departmentScreen: (context) => const DepartmentManagementScreen(),
    announcementScreen: (context) => const AnnouncementManagementScreen(),
    notificationScreen: (context) => const NotificationScreen(),
    notifyScreen: (context) => const NotifyScreen(),
    announcementMsgScreen: (context) => const AnnouncementScreen(),
    splashScreen: (context) => const SplashScreen(),
    allStudentScreen: (context) => const AllStudentScreen(),
    addEventScreen: (context) => const AddEventScreen(),
    clubNactitvitySignUpScreen: (context) => const ClubnActivitySignup(),
    clubNactitvityScreen: (context) => const ClubnactivityScreen(),
    mapNnavigationScreen: (context) => const MapNavigationScreen(),

  };


  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      case navBarScreen:
        final userModel = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => CustomAdminNavigationBar(
            userModel: userModel,
          ),
        );
    // Handle other routes here if needed
      default:
      // If there is no such named route, return null
      // assert(false, 'Need to implement ${settings.name}');
        return null;
    }
  }
  static Route<dynamic>? onGeneratesRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      // case studentnavBarScreen:
      //   final userModel = settings.arguments as UserModel;
      //   return MaterialPageRoute(
      //     builder: (_) => CustomStudentNavigationBar(
      //       userModel: userModel,
      //     ),
      //   );
    // Handle other routes here if needed
      default:
      // If there is no such named route, return null
      // assert(false, 'Need to implement ${settings.name}');
        return null;
    }
  }
  // static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case propertyDetailScreen:
  //       final propertyId = settings.arguments as DefaultDetailArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => PropertyDetailScreen(
  //           id: propertyId.valueId,
  //         ),
  //       );
  //     case mapInfoScreen:
  //       final listModel = settings.arguments as ListPropertyFormModel;
  //       return MaterialPageRoute(
  //         builder: (_) => MapInfoFormScreen(
  //           listPropertyFormModel: listModel,
  //         ),
  //       );
  //
  //     case propertyInfoFormScreen:
  //       final defaultModel = settings.arguments as DefaultPropertyFormArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => PropertyInfoFormScreen(
  //           listPropertyFormModel: defaultModel.listPropertyFormModel,
  //           mapInfoFormModel: defaultModel.mapInfoFormModel,
  //         ),
  //       );
  //
  //     case roomFormScreen:
  //       final defaultModel = settings.arguments as DefaultRoomFormArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => RoomFormScreen(
  //           listPropertyFormModel: defaultModel.listPropertyFormModel,
  //           mapInfoFormModel: defaultModel.mapInfoFormModel,
  //           propertyFormModel: defaultModel.propertyFormModel,
  //         ),
  //       );
  //
  //     case financialInfoFormScreen:
  //       final defaultModel = settings.arguments as DefaultFinancialFormArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => FinancialInfoFormScreen(
  //           listPropertyFormModel: defaultModel.listPropertyFormModel,
  //           mapInfoFormModel: defaultModel.mapInfoFormModel,
  //           propertyFormModel: defaultModel.propertyFormModel,
  //           roomModel: defaultModel.roomModel,
  //         ),
  //       );
  //
  //     case showingInfoFormScreen:
  //       final defaultModel = settings.arguments as DefaultShowingFormArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => ShowingInfoFormScreen(
  //           listPropertyFormModel: defaultModel.listPropertyFormModel,
  //           mapInfoFormModel: defaultModel.mapInfoFormModel,
  //           propertyFormModel: defaultModel.propertyFormModel,
  //           roomModel: defaultModel.roomModel,
  //           financialInfoFormModel: defaultModel.financialInfoFormModel,
  //         ),
  //       );
  //
  //     case remarkFormScreen:
  //       final defaultModel = settings.arguments as DefaultRemarkFormArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => RemarkFormScreen(
  //           listPropertyFormModel: defaultModel.listPropertyFormModel,
  //           mapInfoFormModel: defaultModel.mapInfoFormModel,
  //           propertyFormModel: defaultModel.propertyFormModel,
  //           roomModel: defaultModel.roomModel,
  //           financialInfoFormModel: defaultModel.financialInfoFormModel,
  //           showingInfoFormModel: defaultModel.showingInfoFormModel,
  //         ),
  //       );
  //
  //     case imagesFormScreen:
  //       final defaultModel = settings.arguments as DefaultImageFormArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => ImagesFormScreen(
  //           listPropertyFormModel: defaultModel.listPropertyFormModel,
  //           mapInfoFormModel: defaultModel.mapInfoFormModel,
  //           propertyFormModel: defaultModel.propertyFormModel,
  //           roomModel: defaultModel.roomModel,
  //           financialInfoFormModel: defaultModel.financialInfoFormModel,
  //           showingInfoFormModel: defaultModel.showingInfoFormModel,
  //           remarkModel: defaultModel.remarkModel,
  //         ),
  //       );
  //     case remodelScreen:
  //       final imageId = settings.arguments as DefaultDetailArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => RemodelScreen(
  //           imageId: imageId.valueId,
  //         ),
  //       );
  //     case remodelImageByIdScreen:
  //       final imageId = settings.arguments as DefaultDetailArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => RemodelByImageIDScreen(
  //           imageId: imageId.valueId,
  //         ),
  //       );
  //     case remodelResultScreen:
  //       final result = settings.arguments as RemodelResultArgument;
  //       return MaterialPageRoute(
  //         builder: (_) => RemodelResultScreen(
  //           responseModel: result.result,
  //         ),
  //       );
  //     case profileScreen:
  //       final result = settings.arguments as SignResponseModel;
  //       return MaterialPageRoute(
  //         builder: (_) => ProfileScreen(
  //           user: result,
  //         ),
  //       );
  //     case bottomBar:
  //       final user = settings.arguments as SignResponseModel;
  //       return MaterialPageRoute(
  //         builder: (_) => BottomNavBarScreen(
  //           user: user,
  //         ),
  //       );
  //     case settingScreen:
  //       final user = settings.arguments as SignResponseModel;
  //       return MaterialPageRoute(
  //         builder: (_) => SettingScreen(
  //           user: user,
  //         ),
  //       );
  //     // Handle other routes here if needed
  //     default:
  //       // If there is no such named route, return null
  //       //assert(false, 'Need to implement ${settings.name}');
  //       return null;
  //   }
  // }
}
