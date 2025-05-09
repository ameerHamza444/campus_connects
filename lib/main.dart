import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/constants/theme/theme_provider.dart';
import 'package:campus_connects/viewModel/announcement_view_model.dart';
import 'package:campus_connects/viewModel/auth_view_model.dart';
import 'package:campus_connects/viewModel/clubnactivity_view_model.dart';
import 'package:campus_connects/viewModel/department_view_model.dart';
import 'package:campus_connects/viewModel/discussion_form_view_m.dart';
import 'package:campus_connects/viewModel/event_view_model.dart';
import 'package:campus_connects/viewModel/faculty_view_model.dart';
import 'package:campus_connects/viewModel/notification_view_model.dart';
import 'package:campus_connects/viewModel/student_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = await themeChangeProvider.darkThemePreference.getTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeChangeProvider,
      child: Consumer<ThemeProvider>(builder: (context, theme, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => FacultyViewModel()),
            ChangeNotifierProvider(create: (_) => AuthViewModel()),
            ChangeNotifierProvider(create: (_) => StudentViewModel()),
            ChangeNotifierProvider(create: (_) => DepartmentViewModel()),
            ChangeNotifierProvider(create: (_) => AnnouncementViewModel()),
            ChangeNotifierProvider(create: (_) => NotificationViewModel()),
            ChangeNotifierProvider(create: (_) => DiscussionFormViewModel()),
            ChangeNotifierProvider(create: (_) => EventViewModel()),
            ChangeNotifierProvider(create: (_) => ClubnactivityViewModel()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Campus Connect',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: AppRoutes.splashScreen,
            routes: AppRoutes.routes,
            onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
          ),
        );
      }),
    );
  }
}
