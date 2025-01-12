import 'package:flutter/material.dart';

class ForeCastItem extends StatelessWidget {
  final String time;
  final Icon icon;
  final String temperature;
  const ForeCastItem(
      {super.key,
      required this.time,
      required this.icon,
      required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 10,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(time,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            icon,
            const SizedBox(height: 8),
            Text(temperature,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
