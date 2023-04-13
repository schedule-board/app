import 'dart:core';
import 'package:flutter/material.dart';
import 'package:schedule/models/announcementsmodel.dart';


class AnnouncePage extends StatefulWidget {
  const AnnouncePage({Key? key}) : super(key: key);

  @override
  State<AnnouncePage> createState() => _AnnouncePageState();
}

class _AnnouncePageState extends State<AnnouncePage> {
  static List<AnnouncementsModel> announcementsList = [
    AnnouncementsModel(
        "Electronics",
        "we have quiz tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Electronics",
        "we have quiz tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Electronics",
        "we have lecture tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Computer Graphics",
        "we have Computer Graphics recap and quiz tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Electronics",
        "we have electronics tutor tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Chemistry",
        "we have chemistry quiz tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Physics",
        "we have physics tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Astronomy",
        "we have astronomy quiz tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Geography",
        "we have geography quiz tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Biology",
        "we have biology tomorrow the quiz will be composed of multiple choices.",
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
    AnnouncementsModel(
        "Electronics",
        "we have quiz tomorrow the quiz will be composed of multiple choices.",
        "images/photo1.jpg"),
    AnnouncementsModel(
        "Electronics",
        "we have quiz tomorrow the quiz will be composed of multiple choices.",
        "images/photo1.jpg"),
  ];
  List<AnnouncementsModel> displayList = List.from(announcementsList);
  void updateList(String value) {
    setState(() {
      displayList = announcementsList
          .where((element) => element.announcementDescription!
              .toLowerCase()!
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TopRow(pageTitle: "Announcements  "),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              onChanged: (value) => {
                updateList(value),
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.purple.shade100,
                hintText: 'Enter a search term',
                prefixIcon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 30.0,
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30.0,
                ),
                suffixIconColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: ((context, index) => Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          title: Text(displayList[index].announcementTitle!),
                          subtitle: Text(
                            displayList[index].announcementDescription!,
                          ),
                          leading: CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      100), // this radius should be way bigger than the width of the image. always.
                                  child: Image.asset('images/photo1.jpg')),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  final String pageTitle;
  const TopRow({
    super.key,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.indigo[100],
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        ),
        const Spacer(),
        Text(
          pageTitle,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
