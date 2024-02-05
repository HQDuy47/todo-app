import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/widgets/todo_noti.dart';
import 'package:todo_app/screens/home.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: Home(),
    );
  }
}

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();

//   @override
//   void initState() {
//     super.initState();
//     Noti.initialize(flutterLocalNotificationsPlugin);
//     Noti.createNotificationChannel(flutterLocalNotificationsPlugin);
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );

//     if (picked != null && picked != selectedTime) {
//       setState(() {
//         selectedTime = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFF3ac3cb), Color(0xFFf85187)],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.blue.withOpacity(0.5),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   _selectDate(context);
//                 },
//                 child: const Text("Select Date"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   _selectTime(context);
//                 },
//                 child: const Text("Select Time"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   DateTime scheduledDate = DateTime(
//                     selectedDate.year,
//                     selectedDate.month,
//                     selectedDate.day,
//                     selectedTime.hour,
//                     selectedTime.minute,
//                   );

//                   Noti.scheduleNotification(
//                     id: 1,
//                     title: "Scheduled Notification",
//                     body: "This notification is scheduled.",
//                     scheduledDate: scheduledDate,
//                     fln: flutterLocalNotificationsPlugin,
//                   );
//                 },
//                 child: const Text("Schedule Notification"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
