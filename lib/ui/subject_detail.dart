// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:schedule/dummy_data/dummy_schedule_data.dart';
// import 'package:schedule/schedule/models/schedule.dart';

// class SubjectDetailPage extends StatelessWidget {
//   const SubjectDetailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const TopRow(
//                   pageTitle: "Subject",
//                 ),
//                 const SizedBox(height: 20),
//                 _buildSubjectNameAndPicture(),
//                 const SizedBox(height: 40),
//                 const Text(
//                   "this is in this country is a sample course put into these designs for the mere purpose of "
//                   "making the designs complete and filing gaps. It just gives the UI a good look"
//                   "This course is a sample course put into these designs for the mere purpose of "
//                   "making the designs complete and filing gaps. It just gives the UI a good look",
//                 ),
//                 const SizedBox(height: 20),
//                 _buildSingleSubjectMiniSchedule(weeklySchedulesOfSubject),
//                 const SizedBox(height: 40),
//                 _buildStartEndRow(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Row _buildStartEndRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               "Started Jan 3",
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(
//               width: 150,
//               child: Divider(
//                 thickness: 3,
//                 color: Colors.black,
//               ),
//             ),
//             Text(
//               "Ends Jul 21",
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//         const SizedBox(width: 20),
//         CircularPercentIndicator(
//           radius: 54,
//           lineWidth: 6,
//           percent: 0.65,
//           center: const Text(
//             "65%",
//             style: TextStyle(fontSize: 24),
//           ),
//           progressColor: const Color.fromARGB(255, 179, 147, 216),
//         )
//       ],
//     );
//   }

//   Widget _buildSingleSubjectMiniSchedule(List<List<Schedule>> weeklySchedulesOfSubject) {
//     // let's find the biggest end value in the schedules 'cause that number decides how tall the display will be
//     Schedule latestSchedule = weeklySchedulesOfSubject[0][0];
//     for (List<Schedule> dailySchedulesOfSubject in weeklySchedulesOfSubject) {
//       for (Schedule schedule in dailySchedulesOfSubject) {
//         if (schedule.end.isGreaterThan(latestSchedule.end)) {
//           // we just found a new latest schedule
//           latestSchedule = schedule;
//         }
//       }
//     }

//     double hourToDpRatio = 6; // a ratio telling how many density independent pixels we use to represent 1 hour. (on this widget)
//     // the maxHeight will be the height of the maximum stripe in the widget. it depends on the end time of the latest schedule.
//     double maxHeight = (latestSchedule.end.hour + latestSchedule.end.minute / 60) * hourToDpRatio;

//     // we're defining this function in a function to automate building the "stripes" for each schedule.
//     Widget _buildSchedulesForDay(List<Schedule>? schedulesOfTheDay) {
//       if (schedulesOfTheDay == null) {
//         return Container();
//       }
//       return SizedBox(
//         height: maxHeight, // no matter which stripe we're drawing, all the stacks have the same height, determined by the latest schedule
//         width: 12, // this number is arbitrary. could be changed.
//         child: Stack(
//           children: [
//             for (Schedule schedule in schedulesOfTheDay)
//               Positioned(
//                 left: 2, // this depends on the width of the child container. but still arbitrary.
//                 top: schedule.start.inHours() * hourToDpRatio,
//                 child: Container(
//                   width: 10, // another arbitrary number
//                   height: schedule.lengthInHours() * hourToDpRatio,
//                   decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
//                 ),
//               )
//           ],
//         ),
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Column(
//             children: [
//               const Text(
//                 'M',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               _buildSchedulesForDay(
//                 weeklySchedulesOfSubject[0],
//               )
//             ],
//           ),
//           Column(
//             children: [
//               const Text(
//                 'T',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               _buildSchedulesForDay(
//                 weeklySchedulesOfSubject[1],
//               )
//             ],
//           ),
//           Column(
//             children: [
//               const Text(
//                 'W',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               _buildSchedulesForDay(
//                 weeklySchedulesOfSubject[2],
//               )
//             ],
//           ),
//           Column(
//             children: [
//               const Text(
//                 'T',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               _buildSchedulesForDay(
//                 weeklySchedulesOfSubject[3],
//               )
//             ],
//           ),
//           Column(
//             children: [
//               const Text(
//                 'F',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               _buildSchedulesForDay(
//                 weeklySchedulesOfSubject[4],
//               )
//             ],
//           ),
//           Column(
//             children: [
//               const Text(
//                 'S',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               _buildSchedulesForDay(
//                 weeklySchedulesOfSubject[5],
//               )
//             ],
//           ),
//           Column(
//             children: [
//               const Text(
//                 'S',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               _buildSchedulesForDay(
//                 weeklySchedulesOfSubject[6],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Wrap _buildSubjectNameAndPicture() {
//     return Wrap(
//       alignment: WrapAlignment.center,
//       crossAxisAlignment: WrapCrossAlignment.center,
//       spacing: 20,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: const [
//             Text(
//               "Electronics",
//               style: TextStyle(fontSize: 32),
//             ),
//             Text(
//               "by Aditya",
//               style: TextStyle(fontSize: 22),
//             ),
//           ],
//         ),
//         CircleAvatar(
//           radius: 56,
//           backgroundColor: Colors.blue,
//           child: Padding(
//             padding: const EdgeInsets.all(5),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(100), // this radius should be way bigger than the width of the image. always.
//               child: Image.network(
//                   "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class TopRow extends StatelessWidget {
//   final String pageTitle;
//   const TopRow({
//     super.key,
//     required this.pageTitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.indigo[100],
//           ),
//           child: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_rounded),
//           ),
//         ),
//         const Spacer(),
//         Text(
//           pageTitle,
//           style: const TextStyle(fontSize: 18),
//         ),
//       ],
//     );
//   }
// }
