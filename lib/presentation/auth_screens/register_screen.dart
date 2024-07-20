import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_input/phone_input_package.dart';
import 'package:tasky/bussiness_logic/auth/cubit/auth_cubit.dart';
import 'package:tasky/constants/Screens.dart';
import 'package:tasky/constants/colors/colors.dart';
import 'package:tasky/constants/daimentions.dart';
import 'package:tasky/constants/strings.dart';
import 'package:tasky/data/model/auth_model/register_model.dart';
import 'package:tasky/presentation/custom_widgets/bit_text_widget.dart';
import 'package:tasky/presentation/custom_widgets/text_form_field_widget.dart';
import 'package:tasky/presentation/custom_widgets/wid_buttom_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // validate controller
  PhoneController? phone_controller;
  TextEditingController? password_controller;
  TextEditingController? user_name_controller;
  TextEditingController? address_controller;
  TextEditingController? experaince_controller;

  Daimentions? daimentions;

  //phone input related
  LayerLink layerLink = LayerLink();
  final bool _shouldFormat = true;
  final bool _showFlagInInput = true;
  final bool _showArrow = true;
  late List<CountrySelectorNavigator> navigators;
  late CountrySelectorNavigator selectorNavigator;

  // Initial Selected Value
  String? dropdownvalue = "1";

  // global form key
  GlobalKey<FormState>? form_key;
  @override
  void initState() {
    form_key = GlobalKey();

    // form text field controllers
    experaince_controller = TextEditingController();
    password_controller = TextEditingController();
    user_name_controller = TextEditingController();
    address_controller = TextEditingController();

    // intailize daimentions
    daimentions = Daimentions(context: context);

    // intialize phone controllers
    phone_controller =
        PhoneController(const PhoneNumber(isoCode: IsoCode.EG, nsn: "1"));
    navigators = <CountrySelectorNavigator>[
      const CountrySelectorNavigator.searchDelegate(),
      const CountrySelectorNavigator.dialog(),
      const CountrySelectorNavigator.bottomSheet(),
      const CountrySelectorNavigator.modalBottomSheet(),
      const CountrySelectorNavigator.draggableBottomSheet(),
      CountrySelectorNavigator.dropdown(
        backgroundColor: const Color(0xFFE7DEF6),
        borderRadius: BorderRadius.circular(5),
        layerLink: layerLink,
        showSearchInput: true,
      ),
    ];
    selectorNavigator = navigators.first;

    // phone controllers related
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    experaince_controller!.dispose();
    user_name_controller!.dispose();
    address_controller!.dispose();
    phone_controller!.dispose();
    password_controller!.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().return_to_init();

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is registerfailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error_message),
              ),
            );
          } else if (state is registerSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("your account is successful created")));
            Navigator.pushReplacementNamed(context, Screens.home_screen);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: daimentions!.Width10,
                vertical: daimentions!.Height30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: daimentions!.height / 2.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImagesManegar.first_hero),
                      ),
                    ),
                  ),
                  big_text(
                    text: "Register",
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: daimentions!.Height20,
                  ),
                  Form(
                    key: form_key,
                    child: Column(
                      children: [
                        // text form field for password
                        TextFormFieldWidget(
                          hint_text: "Name...",
                          text_edting_controller: user_name_controller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("field can not be empty");
                            }
                            return null;
                          },
                        ),

                        // input
                        PhoneInput(
                          controller: phone_controller,
                          showArrow: _showArrow,
                          shouldFormat: _shouldFormat,
                          validator: PhoneValidator.compose([
                            PhoneValidator.required(),
                            PhoneValidator.valid()
                          ]),
                          flagShape: BoxShape.rectangle,
                          showFlagInInput: _showFlagInInput,
                          decoration: InputDecoration(
                              labelText: 'Phone number',
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: ColorsManeger.light_grey))),
                          countrySelectorNavigator: selectorNavigator,
                        ),

                        // sized box to make space between widgets
                        SizedBox(
                          height: daimentions!.Height20,
                        ),
                        // years of experaince text field
                        TextFormFieldWidget(
                          keybourdType: TextInputType.number,
                          hint_text: "Years of experience...",
                          secure: true,
                          text_edting_controller: experaince_controller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("field can not be empty");
                            }
                            return null;
                          },
                        ),

                        /// dorp down meny
                        DropdownButtonFormField<String>(
                          value: dropdownvalue,
                          hint: const Text('choose experiance Level'),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == "1") {
                              return "you have to choose your exprience level";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(106, 124, 110, 1))),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "1",
                              child: Text("Choose experience Level"),
                            ),
                            DropdownMenuItem(
                              value: "fresh",
                              child: Text("fresh"),
                            ),
                            DropdownMenuItem(
                              value: "junior",
                              child: Text("junior"),
                            ),
                            DropdownMenuItem(
                              value: "midLevel",
                              child: Text("midLevel"),
                            ),
                            DropdownMenuItem(
                              value: "senior",
                              child: Text("senior"),
                            ),
                          ],
                        ),
                        // sized box to make space between widgets
                        SizedBox(
                          height: daimentions!.Height20,
                        ),
                        // text form field for password
                        TextFormFieldWidget(
                          hint_text: "Address...",
                          text_edting_controller: address_controller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("field can not be empty");
                            }
                            return null;
                          },
                        ),
                        // sized box to make space between widgets

                        // text form field for password
                        TextFormFieldWidget(
                          hint_text: "password",
                          secure: true,
                          text_edting_controller: password_controller,
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove_red_eye_rounded)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("field can not be empty");
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  state is registerLoading
                      ? const Center(child: CircularProgressIndicator())
                      : wid_button_widget(
                          daimentions: daimentions,
                          text: "register",
                          is_icon: false,
                          on_tap: () {
                            //     "+${phone_controller!.value!.countryCode.toString() + phone_controller!.value!.nsn.toString()}");
                            if (form_key!.currentState!.validate()) {
                              String phone =
                                  "+${phone_controller!.value!.countryCode.toString() + phone_controller!.value!.nsn.toString()}";
                              RegisterModel registerModel = RegisterModel(
                                phone,
                                password_controller!.text,
                                user_name_controller!.text,
                                address_controller!.text,
                                dropdownvalue!,
                                int.parse(experaince_controller!.text),
                              );

                              context
                                  .read<AuthCubit>()
                                  .register(register_model: registerModel);
                            }
                          },
                        ),
                  SizedBox(
                    height: daimentions!.Height20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Didn't have any account?  ",
                            style: TextStyle(
                              color: ColorsManeger.light_grey,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, Screens.login_screen);
                              },
                            text: "Sign in",
                            style: TextStyle(
                              fontSize: 15,
                              color: ColorsManeger.purble,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
