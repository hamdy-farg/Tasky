// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

import 'package:tasky/constants/Screens.dart';
import 'package:tasky/constants/colors/colors.dart';
import 'package:tasky/constants/daimentions.dart';
import 'package:tasky/constants/strings.dart';
import 'package:tasky/presentation/custom_widgets/bit_text_widget.dart';
import 'package:tasky/presentation/custom_widgets/description_text_widget.dart';
import 'package:tasky/presentation/custom_widgets/wid_buttom_widget.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  Daimentions? daimentions;
  @override
  void initState() {
    daimentions = Daimentions(context: context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: daimentions!.Width10,
            vertical: daimentions!.Height30,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: daimentions!.height / 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagesManegar.first_hero),
                    ),
                  ),
                ),
                big_text(
                  text: "Task Management &\n To-Do List",
                ),
                SizedBox(
                  height: daimentions!.Height10,
                ),
                description_text(
                  bold: true,
                  color: ColorsManeger.light_grey,
                  text:
                      """This productive tool is designed to help\n you better manage your task \n project-wise conveniently!""",
                  font_size: 15,
                ),
                SizedBox(
                  height: daimentions!.Height40,
                ),
                wid_button_widget(
                  daimentions: daimentions,
                  text: "Let's Start  ",
                  on_tap: () {
                    Navigator.pushReplacementNamed(
                        context, Screens.login_screen);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
