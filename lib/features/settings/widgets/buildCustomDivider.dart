import 'package:flutter/material.dart';

// ✅ Hàm nằm ngoài class, ở trên đầu file hoặc cuối file
Widget buildCustomDivider({
  double height = 15,
  double thickness = 10,
  double indent = 0,
  double endIndent = 0,
  Color color = const Color(0xFFEFEFEF),
}) {
  return Divider(
    height: height,
    thickness: thickness,
    indent: indent,
    endIndent: endIndent,
    color: color,
  );
}
