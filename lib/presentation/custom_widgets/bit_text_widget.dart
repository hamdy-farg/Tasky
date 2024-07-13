// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class big_text extends StatelessWidget {
  Color color;
  String text;
  double font_size;
  TextAlign textAlign;
  big_text({
    Key? key,
    this.color = Colors.black,
    required this.text,
    this.font_size = 25,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: font_size.sp,
          color: color,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
      textAlign: textAlign,
    );
  }
}
