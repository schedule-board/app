import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/screens/join_as_owner_page.dart';
import 'package:schedule/auth/screens/join_as_student_page.dart';
import 'package:schedule/auth/screens/login_page.dart';
import 'package:schedule/class/screens/class_detail_page.dart';
import 'package:schedule/class/screens/create_class_page.dart';
import 'package:schedule/course/screens/course_detail_page.dart';
import 'package:schedule/course/screens/create_course_page.dart';
import 'package:schedule/schedule/landing_page.dart';
import 'package:schedule/ui/subject_detail.dart';
import 'auth/screens/join_with_code_page.dart';
import 'auth/screens/signup_screen.dart';
import 'school/screens/school_detail_page.dart';
import 'auth/screens/invite_page.dart';
import 'auth/screens/profile_page.dart';
import 'class/screens/class_list_page.dart';
import 'course/screens/course_list_page.dart';
import "course/bloc/bloc.dart";
import 'course/repository/course_repository.dart';
import 'course/data_provider/course_provider.dart';
import 'class/screens/select_class_page.dart';
import 'class/bloc/class_bloc.dart'; 
import 'class/repository/class_repository.dart';
import 'class/data_provider/class_provider.dart';


// import 'announcement.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter(
    initialLocation: '/courseList',
    initialExtra: GoRoute(
      path: '/landingpage',
      builder: (context, state) => const LandingPage(
        title: 'Schedule board',
      ),
    ),
    routes: [
      // a route for the root of the app
      GoRoute(
        path: '/',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/classList',
        builder: (context, state) => ClassListPage(),
      ),
      GoRoute(
        path: '/courseList',
        builder: (context, state) => CourseListPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/createCourse',
        builder: (context, state) => CreateCoursePage(),
      ),
      GoRoute(
        path: '/createClass',
        builder: (context, state) => CreateClassPage(),
      ),
      GoRoute(
        path: '/classDetail',
        builder: (context, state) => ClassDetailPage(),
      ),
      GoRoute(
        path: '/JoinAsOwner',
        builder: (context, state) => JoinAsOwnerPage(),
      ),

      GoRoute(
        path: '/joinAsStudent',
        builder: (context, state) => JoinAsStudentPage(),
      ),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/joinWithCode',
        builder: (context, state) => JoinWithCodeScreen(),
      ),
      GoRoute(
        path: '/schoolDetail',
        builder: (context, state) => SchoolDetailPage(),
      ),
      GoRoute(
        path: '/invite',
        builder: (context, state) => InvitePage(),
      ),
      GoRoute(
        path: '/Profile',
        builder: (context, state) => ProfilePage(),
      ),

      GoRoute(
        path: '/landing',
        builder: (context, state) => const LandingPage(
          title: 'Schedule board',
        ),
      ),
      GoRoute(
        path: '/courseDetail',
        builder: (context, state) => CourseDetailPage(),
      ),
      GoRoute(
        path: '/SelectClass',
        builder: (context, state) => SelectClassPage(),
      ),
      // GoRoute(
      //   path: '/joinAsOwner',
      //   builder: (context, state) => JoinAsOwnerScreen(),
      // ),
      // GoRoute(
      //   path: '/joinAsStudent',
      //   builder: (context, state) => JoinAsStudentScreen(),
      // ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    CourseRepository courseRepository = CourseRepository(CourseProvider());
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<CourseBloc>(
          create: (context) => CourseBloc(courseRepository),
        ),
        BlocProvider<ClassBloc>(
          create: (context) => ClassBloc(ClassRepository(ClassProvider())),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Schedule Board',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
