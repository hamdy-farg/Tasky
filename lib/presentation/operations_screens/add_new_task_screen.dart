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
import 'package:tasky/constants/variable_data.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';
import 'package:tasky/data/repo/utils/utils.dart';
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
  // declare text editing controllers
  TextEditingController? date_controller;
  TextEditingController? title_controller;
  TextEditingController? description_controller;
  GlobalKey<FormState>? form_key;

  // function to select date

  @override
  void initState() {
    // initailize controllers
    date_controller = TextEditingController();
    title_controller = TextEditingController();
    description_controller = TextEditingController();
    //initailize daimentions
    Data.daimentions = Daimentions(context: context);
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
          padding: const EdgeInsets.symmetric(
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
                      const SnackBar(content: Text("successfully added")));
                }
                if (state is AddTodoFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error_message)));
                }
                if (state is imageLoaded) Data.image = state.image;
                // TODO: implement listener
              },
              builder: (context, state) {
                return state is AddTodoloading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DottedBorder(
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [3, 3],
                              color: ColorsManeger.purble,
                              // impelement three layer to get perfect onpress container
                              child: SizedBox(
                                width: double.infinity,
                                height: Data.daimentions!.height / 4,
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
                                            ? const CircularProgressIndicator()
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
                                                    height: Data.daimentions!
                                                            .height /
                                                        4,
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
                            height: Data.daimentions!.Height20,
                          ),

                          // to but title of the text form field
                          description_text(
                              text: "Task title",
                              color: ColorsManeger.light_grey,
                              bold: false),

                          // sized box between widgets
                          SizedBox(
                            height: Data.daimentions!.Height5,
                          ),

                          // text form field to take data from user
                          TextFormFieldWidget(
                            text_edting_controller: title_controller,
                            hint_text: "Enter title here",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("field can not be empty");
                              }
                              return null;
                            },
                          ),

                          // to but title of the text form field
                          description_text(
                              text: "Task description",
                              color: ColorsManeger.light_grey,
                              bold: false),

                          //sized box between widgets
                          SizedBox(
                            height: Data.daimentions!.Height5,
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
                              return null;
                            },
                          ),

                          // drop down menu to choose your priority
                          dropDownButtom(
                            dataValue: Data.priority_value,
                            list: Data.priority,
                            holder: Data.priority_holder,
                          ),

                          // sized box between widgets
                          SizedBox(
                            height: Data.daimentions!.Height10,
                          ),

                          // to but title of the text form field
                          description_text(
                            text: "Due date",
                            color: ColorsManeger.light_grey,
                            bold: false,
                          ),

                          // sized box between widgets
                          SizedBox(
                            height: Data.daimentions!.Height5,
                          ),

                          // text form field to take data from user
                          TextFormFieldWidget(
                            text_edting_controller: date_controller,
                            hint_text: "choose due date...",
                            suffixIcon: IconButton(
                              onPressed: () async {
                                date_controller!.text =
                                    await Utils().selectedData(context);
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
                              return null;
                            },
                          ),

                          // wid button to submit the data
                          wid_button_widget(
                            on_tap: () {
                              if (form_key!.currentState!.validate()) {
                                RequistTaskModel requistTaskModel =
                                    RequistTaskModel(
                                        image: Data.image.path,
                                        title: title_controller!.text,
                                        desc: description_controller!.text,
                                        priority: Data.priority_value,
                                        dueDate: date_controller!.text);
                                print(requistTaskModel);

                                context.read<AddTodoCubit>().addTodo(
                                    requist_task_model: requistTaskModel);
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

DropdownButtonFormField<String> dropDownButtom({
  required List<String> list,
  required String dataValue,
  required String holder,
}) {
  return DropdownButtonFormField<String>(
      value: dataValue,
      icon: Visibility(
        visible: true,
        child: SizedBox(
          height: 15,
          width: 15,
          child: Image(
            image: AssetImage(ImagesManegar.down_arrow_icon),
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
        Data.priority_value = newValue!;
        dataValue = newValue;
      },
      validator: (value) {
        if (value == "choose your priority") return ("choose your priority");
        return null;
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                "choose your priority" == value
                    ? const Icon(
                        Icons.flag_outlined,
                        color: Colors.deepPurple,
                      )
                    : Container(),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ));
      }).toList());
}
