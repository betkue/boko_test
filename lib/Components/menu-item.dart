import 'package:boko_test/utils/color.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String icon;
  final String text;
  final String subtitle;
  final bool verified;

  MenuItem(
      {required this.icon,
      required this.text,
      required this.subtitle,
      this.verified = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.asset('assets/$icon', height: 35),
        title: Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: TextStyle(
                    color: verified ? greenColor : gray2Color,
                    fontWeight: FontWeight.bold),
              )
            : null,
        trailing: const Icon(
          Icons.chevron_right,
          color: gray2Color,
          weight: 10,
        ),
        onTap: () {
          // Handle navigation or action here
        },
      ),
    );
  }
}
