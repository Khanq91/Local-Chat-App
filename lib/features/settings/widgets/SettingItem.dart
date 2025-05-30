import 'package:flutter/material.dart';
import 'buildCustomDivider.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color color;

  const SettingItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCustomDivider(),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon, color:color),
                SizedBox(width: 20),
                Text(
                  title,
                  style: TextStyle(fontSize: 16,color: color, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
