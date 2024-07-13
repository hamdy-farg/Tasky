import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/bussiness_logic/operation/add_todo/cubit/add_todo_cubit.dart';
import 'package:tasky/bussiness_logic/operation/profile/cubit/profile_cubit.dart';
import 'package:tasky/bussiness_logic/operation/todos/cubit/todo_cubit.dart';
import 'package:tasky/constants/colors/colors.dart';
import 'package:tasky/constants/daimentions.dart';
import 'package:tasky/constants/strings.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';
import 'package:tasky/presentation/custom_widgets/bit_text_widget.dart';
import 'package:tasky/presentation/custom_widgets/description_text_widget.dart';
import 'package:tasky/presentation/custom_widgets/drop_down_menu.dart';
import 'package:tasky/presentation/custom_widgets/text_form_field_widget.dart';
import 'package:tasky/presentation/custom_widgets/wid_buttom_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  Daimentions? daimentions;
  XFile image = XFile("path");
  List<String> priority = [
    "choose your priority",
    "low",
    "medium",
    "high",
  ];
  // declare text editing controllers
  TextEditingController? date_controller;
  TextEditingController? title_controller;
  TextEditingController? description_controller;
  GlobalKey<FormState>? form_key;

  // function to select date
  Future<void> _selectedData() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (_picked != null) {
      date_controller!.text = _picked.toString().split(" ")[0];
    }
  }

  @override
  void initState() {
    // initailize controllers
    date_controller = TextEditingController();
    title_controller = TextEditingController();
    description_controller = TextEditingController();
    //initailize daimentions
    daimentions = Daimentions(context: context);

    // form key
    form_key = GlobalKey();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // clear controllers
    date_controller!.dispose();
    title_controller!.dispose();
    description_controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  String priority_value = "choose your priority";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.read<AddTodoCubit>().return_to_init();
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 40,
          ),
          child: Form(
            key: form_key,
            // to change the state of todo (loading, success , failure).
            child: BlocConsumer<AddTodoCubit, AddTodoState>(
              listener: (context, state) {
                print(state);
                if (state is AddTodoSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("successfully added")));
                }
                if (state is AddTodoFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error_message)));
                }
                if (state is imageLoaded) image = state.image;
                // TODO: implement listener
              },
              builder: (context, state) {
                return state is AddTodoloading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DottedBorder(
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [3, 3],
                              color: ColorsManeger.purble,
                              // impelement three layer to get perfect onpress container
                              child: Container(
                                width: double.infinity,
                                height: daimentions!.height / 4,
                                // material to make the border of thee click rounded and put the color
                                child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    // to make the container clickable with splash
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery)
                                            .then((value) => context
                                                .read<AddTodoCubit>()
                                                .uplod_image(value!));
                                      },
                                      child:
                                          // to center content of container
                                          Center(
                                        // if image loading make circular indicator if it not go to another condition
                                        child: state is imageLoading
                                            ? CircularProgressIndicator()
                                            : (state is! imageLoaded)
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.image_rounded,
                                                        color: ColorsManeger
                                                            .purble,
                                                      ),
                                                      big_text(
                                                        text: " Add Img",
                                                        color: ColorsManeger
                                                            .purble,
                                                        font_size: 18,
                                                      ),
                                                    ],
                                                  )
                                                // to display the image if it exist
                                                : Container(
                                                    height:
                                                        daimentions!.height / 4,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: FileImage(File(
                                                            state.image.path)),
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                    )),
                              )),

                          // sized box between widgets
                          SizedBox(
                            height: daimentions!.Height20,
                          ),

                          // to but title of the text form field
                          description_text(
                              text: "Task title",
                              color: ColorsManeger.light_grey,
                              bold: false),

                          // sized box between widgets
                          SizedBox(
                            height: daimentions!.Height5,
                          ),

                          // text form field to take data from user
                          TextFormFieldWidget(
                            text_edting_controller: title_controller,
                            hint_text: "Enter title here",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("field can not be empty");
                              }
                            },
                          ),

                          // to but title of the text form field
                          description_text(
                              text: "Task description",
                              color: ColorsManeger.light_grey,
                              bold: false),

                          //sized box between widgets
                          SizedBox(
                            height: daimentions!.Height5,
                          ),

                          // text form field to take data from user
                          TextFormFieldWidget(
                            text_edting_controller: description_controller,
                            hint_text: "Enter description here....",
                            max_line: 5,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("field can not be empty");
                              }
                            },
                          ),

                          // drop down menu to choose your priority
                          DropdownButtonFormField<String>(
                              value: priority_value,
                              icon: Visibility(
                                visible: true,
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  child: Image(
                                    image: AssetImage(
                                        ImagesManegar.down_arrow_icon),
                                  ),
                                ),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                color: Colors.deepPurple,
                              ),
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromRGBO(240, 236, 255, 1),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  )),
                              onChanged: (String? newValue) {
                                priority_value = newValue!;
                                print("ppppppppppppp ${priority_value}");
                              },
                              validator: (value) {
                                if (value == "choose your priority")
                                  return ("choose your priority");
                              },
                              items: priority.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      children: [
                                        true
                                            ? priority_value == value
                                                ? Icon(
                                                    Icons.flag_outlined,
                                                    color: Colors.deepPurple,
                                                  )
                                                : Container()
                                            : Container(),
                                        Text(
                                          value,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ));
                              }).toList()),

                          // sized box between widgets
                          SizedBox(
                            height: daimentions!.Height10,
                          ),

                          // to but title of the text form field
                          description_text(
                            text: "Due date",
                            color: ColorsManeger.light_grey,
                            bold: false,
                          ),

                          // sized box between widgets
                          SizedBox(
                            height: daimentions!.Height5,
                          ),

                          // text form field to take data from user
                          TextFormFieldWidget(
                            text_edting_controller: date_controller,
                            hint_text: "choose due date...",
                            suffixIcon: IconButton(
                              onPressed: () {
                                _selectedData();
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                color: ColorsManeger.purble,
                              ),
                            ),
                            read_only: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("field can not be empty");
                              }
                            },
                          ),

                          // wid button to submit the data
                          wid_button_widget(
                            on_tap: () {
                              print("sssssssssssss ${priority_value}");

                              if (form_key!.currentState!.validate()) {
                                RequistTaskModel requist_task_model =
                                    RequistTaskModel(
                                        image: image.path,
                                        title: title_controller!.text,
                                        desc: description_controller!.text,
                                        priority: priority_value,
                                        dueDate: date_controller!.text);
                                print(requist_task_model);

                                context.read<AddTodoCubit>().addTodo(
                                    requist_task_model: requist_task_model);
                              }
                            },
                            text: "Add task",
                            daimentions: Daimentions(context: context),
                          )
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
