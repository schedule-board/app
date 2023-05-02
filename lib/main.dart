import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/blocs/auth_bloc.dart';
import 'package:schedule/ui/signup.dart';
import 'package:schedule/ui/subject_detail.dart';
import 'package:schedule/ui/announce.dart';

// import 'announcement.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(),)
      ],
      child: MaterialApp(
        title: 'Schedule Board',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            const SignUpView(), // this will be changed. we're doing this temporarily tot test the SubjectDetailPage
      ),
    );
  }
}
