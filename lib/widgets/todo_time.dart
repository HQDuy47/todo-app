import 'package:flutter/material.dart';

class MyTime extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;

  const MyTime({Key? key, required this.onTimeSelected}) : super(key: key);

  @override
  State<MyTime> createState() => _MyTimeState();
}

class _MyTimeState extends State<MyTime> {
  TimeOfDay? _timeOfDay;

  @override
  void initState() {
    super.initState();
    _timeOfDay = null;
  }

  void _showTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _timeOfDay ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeOfDay = pickedTime;
      });
      widget.onTimeSelected(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _showTimePicker,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(180, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.access_time,
            color: Color.fromARGB(255, 95, 95, 95),
          ),
          const SizedBox(width: 8),
          Text(
            _timeOfDay != null ? _timeOfDay!.format(context) : "Pick Time",
            style: const TextStyle(
              color: Color.fromARGB(255, 95, 95, 95),
            ),
          ),
        ],
      ),
    );
  }
}
