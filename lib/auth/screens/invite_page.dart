import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/repository/auth_repository.dart';
import 'package:schedule/auth/states/auth_state.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invite Page")),
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.user!.role == "owner") inviteCoordinator(context),
            if (state.user!.role == "owner" || state.user!.role == "coordinator") inviteTeacher(context),
            const SizedBox(height: 40),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is InviteCoordinatorState) {
                  return Center(child: Text("Invite code: ${state.invitationCode}", style: TextStyle(fontSize: 30)));
                }
                return LinearProgressIndicator();
              },
            ),
          ],
        );
      }),
    );
  }

  Widget inviteCoordinator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: () {
          AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
          authBloc.add(InviteCoordinatorEvent(authBloc.state.school!.id));
        },
        child: const Text(
          "Invite Coordinator",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget inviteTeacher(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          "Invite Teacher",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
