import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  IconData icons;
  String title;
  String subtitle;

  WeatherTile({
    required this.icons,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icons, color: Colors.purpleAccent)],
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xff9e9e9e),
          fontSize: 18,
        ),
      ),
    );
  }
}
