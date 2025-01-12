import 'package:flutter/material.dart';

class AdditionalItems extends StatelessWidget {
  final String info;
  final Icon icon;
  final String value;
  const AdditionalItems(
      {required this.info, required this.icon, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          icon,
          SizedBox(height: 8),
          Text(info, style: TextStyle(fontSize: 14)),
          SizedBox(height: 8),
          Text(value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
