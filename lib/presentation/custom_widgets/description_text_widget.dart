import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class description_text extends StatelessWidget {
  String text;
  double font_size;
  Color color;
  bool bold;
  TextAlign? textAlign;
  description_text({
    Key? key,
    this.textAlign = TextAlign.center,
    required this.text,
    this.font_size = 12,
    required this.color,
    required this.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: font_size.sp,
          color: color,
          fontWeight: bold ? FontWeight.bold : null),
      textAlign: textAlign,
    );
  }
}
