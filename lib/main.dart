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

// import 'announcement.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter(
    initialLocation: '/ProfilePage',
    initialExtra: GoRoute(
      path: '/landingpage',
      builder: (context, state) => LandingPage(
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
        path: '/schoolDetailPage',
        builder: (context, state) => SchoolDetailPage(),
      ),
      GoRoute(
        path: '/invitePage',
        builder: (context, state) => InvitePage(),
      ),
      GoRoute(
        path: '/ProfilePage',
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        )
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
