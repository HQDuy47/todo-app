import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDate extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const MyDate({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  State<MyDate> createState() => _MyDateState();
}

class _MyDateState extends State<MyDate> {
  // ignore: prefer_final_fields
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          setState(() {
            _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          });
          widget.onDateSelected(pickedDate);
        }
      },
      child: Row(
        children: [
          const Icon(Icons.calendar_today),
          const SizedBox(width: 8),
          Text(
            _dateController.text.isNotEmpty
                ? _dateController.text
                : "Pick Date",
          ),
        ],
      ),
    );
  }
}
