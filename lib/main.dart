import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/application/auth/bloc/auth_bloc.dart';
import 'package:schedule/application/auth/screens/join_as_owner_page.dart';
import 'package:schedule/application/auth/screens/join_as_student_page.dart';
import 'package:schedule/application/auth/screens/login_page.dart';
import 'package:schedule/class/screens/class_detail_page.dart';
import 'package:schedule/class/screens/create_class_page.dart';
import 'package:schedule/course/screens/course_detail_page.dart';
import 'package:schedule/course/screens/create_course_page.dart';
import 'package:schedule/schedule/landing_page.dart';
import 'package:schedule/ui/subject_detail.dart';
import 'application/auth/screens/join_with_code_page.dart';
import 'application/auth/screens/signup_screen.dart';
import 'school/screens/school_detail_page.dart';
import 'application/auth/screens/invite_page.dart';
import 'application/auth/screens/profile_page.dart';
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
  Widget build(BuildContext context) {
    return Container();
  }
}
