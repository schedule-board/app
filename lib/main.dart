import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/screens/join_as_student_page.dart';
import 'package:schedule/auth/screens/login_page.dart';
import 'package:schedule/ui/landing_page.dart';
import 'package:schedule/ui/signup.dart';
import 'package:schedule/ui/subject_detail.dart';
import 'package:schedule/course/screens/screens.dart';

import 'auth/screens/joinwithcode_screen.dart';
import 'auth/screens/signup_screen.dart';

// import 'announcement.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter(
    initialLocation: '/login',
    initialExtra: GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
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
        path: '/landing',
        builder: (context, state) => LandingPage(),
      ),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/subjectDetail',
        builder: (context, state) => const SubjectDetailPage(),
      ),
      GoRoute(
        path: '/createCourse',
        builder: (context, state) => CreateCourseScreen(),
      ),
      GoRoute(
        path: '/JoinAsOwner',
        builder: (context, state) =>  JoinAsOwner(),
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
        routerConfig: router,
        title: 'Schedule Board',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
