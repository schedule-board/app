import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Schedule Board';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: LandingPage(title: appTitle),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        children: [
          Card(
              child: ListTile(
            isThreeLine: true,
            leading: Icon(Icons.timelapse),
            title: Text('Course Name'),
            subtitle: Text('Day , Start time - End time'),
            onTap: () {},
          )),
          Card(
              child: ListTile(
            isThreeLine: true,
            leading: Icon(Icons.timelapse),
            title: Text('Course Name'),
            subtitle: Text('Day , Start time - End time'),
            onTap: () {},
          )),
          Card(
              child: ListTile(
            isThreeLine: true,
            leading: Icon(Icons.timelapse),
            title: Text('Course Name'),
            subtitle: Text('Day , Start time - End time'),
            onTap: () {},
          )),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Schedule board'),
            ),
            ListTile(
              title: const Text('Invite'),
              onTap: () {
                context.push('/inviteScreen');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Select class'),
              onTap: () {
                context.push('/selectClassScreen');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('MY School'),
              onTap: () {
                context.push('/mySchoolScreen');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                context.push('/profileScreen');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Manage Courses'),
              onTap: () {
                context.push('/manageCoursesScreen');

                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Manage Classes'),
              onTap: () {
                context.push('/manageClassesScreen');

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
