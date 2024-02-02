import 'package:flutter/material.dart';

class MyTime extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;

  const MyTime({Key? key, required this.onTimeSelected}) : super(key: key);

  @override
  State<MyTime> createState() => _MyTimeState();
}

class _MyTimeState extends State<MyTime> {
  TimeOfDay? _timeOfDay; // Declare _timeOfDay as nullable

  @override
  void initState() {
    super.initState();
    _timeOfDay = null; // Initialize as null
  }

  void _showTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _timeOfDay ?? TimeOfDay.now(), // Use current time if null
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
      child: Row(
        children: [
          const Icon(Icons.access_time),
          const SizedBox(width: 8),
          Text(
            _timeOfDay != null ? _timeOfDay!.format(context) : "Pick Time",
          ),
        ],
      ),
    );
  }
}
