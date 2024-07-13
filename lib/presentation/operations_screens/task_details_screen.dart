import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasky/constants/colors/colors.dart';
import 'package:tasky/constants/daimentions.dart';
import 'package:tasky/constants/strings.dart';
import 'package:tasky/presentation/custom_widgets/bit_text_widget.dart';
import 'package:tasky/presentation/custom_widgets/description_text_widget.dart';
import 'package:tasky/presentation/custom_widgets/drop_down_menu.dart';
import 'package:tasky/presentation/custom_widgets/text_form_field_widget.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  Daimentions? daimentions;
  TextEditingController? date_controller;
  List<String> state = [
    "choose your state",
    "waiting",
    "inprogress",
    "Finshed",
  ];
  List<String> priority = [
    "choose your priority",
    "meduim Priority",
    "small Priority",
    "high Priority",
  ];
  String dropdownValue_state = "choose your state";
  String dropdownValue_priority = "choose your priority";

  @override
  void initState() {
    date_controller = TextEditingController();
    daimentions = Daimentions(context: context);
    // TODO: implement initState
    super.initState();
  }

  Future<void> _selectedData() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (_picked != null) {
      setState(() {
        date_controller!.text = _picked.toString().split(" ")[0];
        debugPrint(date_controller!.text);
      });
    }
  }

  @override
  void dispose() {
    date_controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagesManegar.right_black_arrow),
                  scale: 1.7),
            ),
          ),
        ),
        title: big_text(
          text: "Add new task",
          font_size: 20,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: daimentions!.height / 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagesManegar.grocery_online),
                    ),
                  ),
                ),
                big_text(
                  text: "Grocery Shopping App",
                ),
                SizedBox(
                  height: daimentions!.Height20,
                ),
                description_text(
                  textAlign: TextAlign.start,
                  text:
                      """this application is designed for super shops By using\nthis application is designed for super shops By using \nthis application is designed for super shops By using""",
                  color: ColorsManeger.light_grey,
                  bold: false,
                ),
                SizedBox(
                  height: daimentions!.Height20,
                ),
                TextFormFieldWidget(
                  have_label: true,
                  text_edting_controller: date_controller,
                  label_text: "end date",
                  have_border: false,
                  read_only: true,
                  filled_color: ColorsManeger.field_color,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: ColorsManeger.purble,
                      size: 30,
                    ),
                    onPressed: () {
                      _selectedData();
                    },
                  ),
                ),
                // drop down menu
                // DropDownMenu(
                //   have_suffix_icon: false,
                //   list: state,
                //   dropdownValue: dropdownValue_state,
                //   valid_compare_value: dropdownValue_state,
                //   valid_return_value: "state can not be empty",
                // ),
                SizedBox(
                  height: daimentions!.Height20,
                ),
                // DropDownMenu(
                //   list: priority,
                //   dropdownValue: dropdownValue_priority,
                //   valid_compare_value: dropdownValue_priority,
                //   valid_return_value: "priority must be chosen",
                // ),
                SizedBox(
                  height: daimentions!.Height20,
                ),
                Container(
                  height: daimentions!.height / 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagesManegar.qr_image),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
