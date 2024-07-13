import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/bussiness_logic/operation/profile/cubit/profile_cubit.dart';
import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/constants/colors/colors.dart';
import 'package:tasky/constants/strings.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/presentation/custom_widgets/description_text_widget.dart';
import 'package:tasky/presentation/custom_widgets/text_form_field_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController? name_controller;

  TextEditingController? phone_controller;

  TextEditingController? level_controller;

  TextEditingController? years_of_experience_controller;

  TextEditingController? location_controller;

  @override
  void initState() {
    name_controller = TextEditingController();

    phone_controller = TextEditingController();

    level_controller = TextEditingController();

    years_of_experience_controller = TextEditingController();

    location_controller = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getprofile();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
          name_controller!.text = state.profileModelResponse.displayName;
          phone_controller!.text = state.profileModelResponse.username;
          level_controller!.text = state.profileModelResponse.level;
          years_of_experience_controller!.text =
              state.profileModelResponse.experienceYears.toString();
          location_controller!.text = state.profileModelResponse.address;
        }
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
            title: description_text(
              text: "Profile",
              font_size: 16,
              bold: true,
              color: Colors.black,
            ),
            centerTitle: false,
          ),
          body: state is ProfileLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : state is ProfileFailure
                  ? Center(
                      child: Text(state.error_message),
                    )
                  : state is ProfileSuccess
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 40),
                            child: Column(
                              children: [
                                TextFormFieldWidget(
                                  fill_color: ColorsManeger.light_white,
                                  have_label: true,
                                  read_only: true,
                                  filled_color: ColorsManeger.light_white,
                                  label_text: "NAME",
                                  text_edting_controller: name_controller,
                                  have_border: false,
                                ),
                                TextFormFieldWidget(
                                  have_label: true,
                                  read_only: true,
                                  fill_color: ColorsManeger.light_white,
                                  filled_color: ColorsManeger.light_white,
                                  label_text: "PHONE",
                                  text_edting_controller: phone_controller,
                                  have_border: false,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.copy_outlined,
                                      color: ColorsManeger.purble,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                TextFormFieldWidget(
                                  have_label: true,
                                  read_only: true,
                                  fill_color: ColorsManeger.light_white,
                                  filled_color: ColorsManeger.light_white,
                                  label_text: "LEVEL",
                                  text_edting_controller: level_controller,
                                  have_border: false,
                                ),
                                TextFormFieldWidget(
                                  have_label: true,
                                  read_only: true,
                                  fill_color: ColorsManeger.light_white,
                                  filled_color: ColorsManeger.light_white,
                                  label_text: "YEARS OF EXPERIENCE",
                                  text_edting_controller:
                                      years_of_experience_controller,
                                  have_border: false,
                                ),
                                TextFormFieldWidget(
                                  have_label: true,
                                  read_only: true,
                                  fill_color: ColorsManeger.light_white,
                                  filled_color: ColorsManeger.light_white,
                                  label_text: "LOCATION",
                                  text_edting_controller: location_controller,
                                  have_border: false,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
        );
      },
    );
  }
}
