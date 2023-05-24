import 'package:flutter/material.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invite Page")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          inviteCoordinator(),
          inviteTeacher(),
        ],
      ),
    );
  }

  Widget inviteCoordinator() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(

        onPressed: () {},
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

  Widget inviteTeacher() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: ElevatedButton(
        onPressed: () {},
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
}
