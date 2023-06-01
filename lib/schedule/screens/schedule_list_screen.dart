// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:schedule/schedule/data_provider/schedule_provider.dart';
// import 'package:schedule/schedule/repository/schedule_repository.dart';
// import '../bloc/bloc.dart';

// class ScheduleScreen extends StatelessWidget {
//   final scheduleRepository = ScheduleRepository(ScheduleProvider());

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ScheduleBloc(scheduleRepository),
//       child: ParentWidget(),
//     );
//   }
// }

// class ParentWidget extends StatelessWidget {
//   const ParentWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Schedule List"),
//       ),
//       body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: BlocBuilder<ScheduleBloc, ScheduleState>(
//               builder: (context, state) {
//             if (state is LoadScheduleEvent) {
//               return const Center(child: CircularProgressIndicator());
//             }
// // 
//             if (state is ScheduleOperationSuccess) {
//               return ListView.builder(
//                 itemCount: state.schedules.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(state.schedules[index].className ?? 'title'),
//                     subtitle: Text(
//                         "${state.schedules[index].dayOfTheWeek ?? 'Day:'}${state.schedules[index].startTime ?? 'starting time:'} - ${state.schedules[index].endTime ?? 'endtime'}"),
//                     // Add more widgets to display other properties if desired
//                   );
//                 },
//               );
//             }

//             if (state is ScheduleOperationFailureState) {
//               return Center(child: Text(state.error.toString()));
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           })),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           BlocProvider.of<ScheduleBloc>(context).add(LoadScheduleEvent());
//         },
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//     );
//   }
// }
