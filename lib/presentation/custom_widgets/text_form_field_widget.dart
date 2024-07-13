import 'package:flutter/material.dart';
import 'package:tasky/constants/colors/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hint_text;
  final String? Function(String?)? validator;
  final TextEditingController? text_edting_controller;
  final bool secure;
  final IconButton? suffixIcon;
  final TextInputType? keybourdType;
  final int? max_line;
  final TextDirection text_direction;
  final bool read_only;
  final bool sizedBox;
  final String? label_text;
  final bool have_border;
  final Color? filled_color;
  final bool have_label;
  final Color? fill_color;
  TextFormFieldWidget(
      {Key? key,
      // ignore: non_constant_identifier_names
      this.fill_color = null,
      this.have_label = false,
      this.filled_color = Colors.white,
      this.have_border = true,
      this.label_text = null,
      this.sizedBox = true,
      this.text_direction = TextDirection.ltr,
      this.max_line = 1,
      this.keybourdType = null,
      this.hint_text,
      this.read_only = false,
      this.validator,
      this.text_edting_controller = null,
      this.suffixIcon = null,
      this.secure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: have_label
              ? EdgeInsets.only(
                  top: 10,
                )
              : null,
          decoration: have_label
              ? BoxDecoration(
                  color: fill_color == null
                      ? ColorsManeger.field_color
                      : fill_color,
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          child: TextFormField(
            style: TextStyle(
                color: fill_color == null
                    ? null
                    : Color.fromARGB(255, 185, 185, 185),
                fontWeight: fill_color == null ? null : FontWeight.bold),
            textDirection: text_direction,
            maxLines: max_line,
            readOnly: read_only,
            keyboardType: keybourdType,
            obscureText: secure,
            controller: text_edting_controller,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: filled_color,
              labelText: label_text,

              floatingLabelStyle: TextStyle(
                  backgroundColor: fill_color == null
                      ? ColorsManeger.field_color
                      : fill_color),
              suffixIcon: suffixIcon,
              hintText: "$hint_text",
              hintStyle: TextStyle(
                color: ColorsManeger.light_grey,
              ),
              labelStyle: TextStyle(
                  color: fill_color == null
                      ? Colors.black
                      : Color.fromARGB(255, 185, 185, 185)),

              // underline border
              border: have_border
                  ? UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: ColorsManeger.light_grey),
                    )
                  : null,

              // border when textformfield enabled
              enabledBorder: OutlineInputBorder(
                borderSide: have_border
                    ? BorderSide(
                        color: Color.fromARGB(255, 180, 178, 178), width: 1)
                    : BorderSide.none,
              ),

              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),

              // border when textformfield enabled
              focusedBorder: OutlineInputBorder(
                borderSide: have_border
                    ? BorderSide(
                        color: ColorsManeger.light_grey,
                      )
                    : BorderSide.none,
              ),
            ),
            cursorColor: Colors.black,
          ),
        ),
        sizedBox
            ? SizedBox(
                height: (MediaQuery.of(context).size.height) / 37,
              )
            : Container(),
      ],
    );
  }
}

