import 'package:flutter/material.dart';
import 'package:tasky/constants/colors/colors.dart';
import 'package:tasky/constants/daimentions.dart';
import 'package:tasky/constants/strings.dart';
import 'package:tasky/presentation/custom_widgets/bit_text_widget.dart';

class wid_button_widget extends StatelessWidget {
  void Function()? on_tap;
  String text;
  bool is_icon;
  wid_button_widget({
    this.is_icon = true,
    required this.on_tap,
    required this.text,
    super.key,
    required this.daimentions,
  });

  final Daimentions? daimentions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: daimentions!.height / 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: ColorsManeger.purble,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: on_tap,
          borderRadius: BorderRadius.circular(10),
          splashColor: Color.fromARGB(255, 180, 141, 168),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              big_text(
                text: text,
                color: Colors.white,
                font_size: 20,
              ),
              is_icon
                  ? Image(
                      image: AssetImage(
                        ImagesManegar.arrow_icon,
                      ),
                      height: 25,
                      width: 25,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
