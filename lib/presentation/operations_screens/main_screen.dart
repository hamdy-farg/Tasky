import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/bussiness_logic/auth/cubit/auth_cubit.dart';
import 'package:tasky/bussiness_logic/operation/add_todo/cubit/add_todo_cubit.dart';
import 'package:tasky/constants/Screens.dart';
import 'package:tasky/constants/colors/colors.dart';
import 'package:tasky/constants/daimentions.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';
import 'package:tasky/presentation/custom_widgets/bit_text_widget.dart';

import '../../bussiness_logic/operation/todos/cubit/todo_cubit.dart';
import '../custom_widgets/description_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Daimentions? daimentions;

  int selected_item = 0;
  List<String> task_category = [
    "All",
    "Inprogress",
    "Waiting",
    "Finished",
  ];
  @override
  void initState() {
    daimentions = Daimentions(context: context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<TodoCubit>().getTodos();

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            AuthRepo.refresh_token = null;
            Navigator.pushReplacementNamed(context, Screens.login_screen);
          } else if (state is Logoutfailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error_message),
              ),
            );
          }
        },
        builder: (context, state) {
          return state is LogoutLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            big_text(text: "Logo"),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Screens.profile_screen,
                                    );
                                  },
                                  icon: Icon(IconlyLight.profile),
                                  iconSize: 30,
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<AuthCubit>().logout();
                                  },
                                  icon: Icon(
                                    Icons.door_back_door_outlined,
                                    color: ColorsManeger.purble,
                                  ),
                                  iconSize: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: daimentions!.Height25,
                        ),
                        description_text(
                          text: "My Tasks",
                          font_size: 15,
                          color: ColorsManeger.light_grey,
                          bold: true,
                        ),
                        SizedBox(
                          height: daimentions!.Height10,
                        ),
                        Container(
                            height: daimentions!.Height40,
                            child: ListView.builder(
                              itemCount: task_category.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (state is TodosFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text((state as TodosFailure)
                                          .error_message),
                                    ),
                                  );
                                }
                                return Container(
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20),
                                    color: selected_item == index
                                        ? ColorsManeger.purble
                                        : Color.fromRGBO(240, 236, 255, 1),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        setState(() {
                                          selected_item = index;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        margin: EdgeInsets.only(left: 5),
                                        child: Center(
                                          child: Text(
                                            task_category[index],
                                            style: TextStyle(
                                                color: selected_item == index
                                                    ? Colors.white
                                                    : ColorsManeger.light_grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                        SizedBox(
                          height: daimentions!.Height10,
                        ),
                        RefreshIndicator(
                          onRefresh: () {
                            return context.read<TodoCubit>().getTodos();
                          },
                          child: BlocBuilder<TodoCubit, TodosState>(
                            builder: (context, state) {
                              if (state is TodosSuccess) {
                                if (task_category[selected_item] != "All") {
                                  state.task_model_list = state.task_model_list
                                      .where((element) =>
                                          element.status ==
                                          task_category[selected_item]
                                              .toLowerCase())
                                      .toList();
                                }
                              }
                              return state is TodosLoading
                                  ? Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    )
                                  : state is TodosSuccess
                                      ? Container(
                                          height: daimentions!.height / 1.40,
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                state.task_model_list.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height:
                                                          daimentions!.height /
                                                              9.9,
                                                      width:
                                                          daimentions!.width /
                                                              8.7,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        image: DecorationImage(
                                                            image: FileImage(
                                                                File(state
                                                                    .task_model_list[
                                                                        index]
                                                                    .image!)),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          daimentions!.Width5,
                                                    ),
                                                    Container(
                                                      width:
                                                          daimentions!.width /
                                                              3.99,
                                                      height:
                                                          daimentions!.height /
                                                              9.9,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      big_text(
                                                                    text: state
                                                                        .task_model_list[
                                                                            index]
                                                                        .title
                                                                        .toString(),
                                                                    color: Colors
                                                                        .black,
                                                                    font_size:
                                                                        16,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              7,
                                                                          vertical:
                                                                              1),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: ColorsManeger
                                                                          .light_red_background),
                                                                  child:
                                                                      description_text(
                                                                    text: state
                                                                        .task_model_list[
                                                                            index]
                                                                        .status
                                                                        .toString(),
                                                                    color: ColorsManeger
                                                                        .light_red,
                                                                    bold: true,
                                                                  ),
                                                                ),
                                                              ]),
                                                          Row(
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  state
                                                                      .task_model_list[
                                                                          index]
                                                                      .desc
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorsManeger
                                                                        .light_grey,
                                                                    fontSize:
                                                                        15,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container()
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .flag_outlined,
                                                                    color: ColorsManeger
                                                                        .purble,
                                                                    size: 20,
                                                                  ),
                                                                  description_text(
                                                                    text: state
                                                                        .task_model_list[
                                                                            index]
                                                                        .priority
                                                                        .toString(),
                                                                    color: ColorsManeger
                                                                        .purble,
                                                                    bold: true,
                                                                  )
                                                                ],
                                                              ),
                                                              description_text(
                                                                text: state
                                                                    .task_model_list[
                                                                        index]
                                                                    .createdAt
                                                                    .toString()
                                                                    .split("T")
                                                                    .first,
                                                                color: ColorsManeger
                                                                    .light_grey,
                                                                bold: true,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 100,
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            IconButton(
                                                                onPressed: () {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      Screens
                                                                          .task_details_screen);
                                                                },
                                                                icon: Icon(Icons
                                                                    .menu_sharp)),
                                                          ]),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Container();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // container to work as small floating action button
            Container(
              width: daimentions!.height / 15,
              height: daimentions!.height / 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Material(
                color: ColorsManeger.light_blue_background,
                borderRadius: BorderRadius.circular(40),
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () {},
                  child: Center(
                    child: Icon(
                      Icons.qr_code_outlined,
                      size: 20,
                      color: ColorsManeger.purble,
                    ),
                  ),
                ),
              ),
            ),

            // sized box between widgets
            SizedBox(
              height: daimentions!.Height10,
            ),

            // container to work as big flouting action button
            Container(
              width: daimentions!.height / 12,
              height: daimentions!.height / 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Material(
                color: ColorsManeger.purble,
                borderRadius: BorderRadius.circular(40),
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () {
                    Navigator.of(context).pushNamed(Screens.add_task_screen);
                  },
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
