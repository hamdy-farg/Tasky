import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_input/phone_input_package.dart';
import 'package:tasky/bussiness_logic/auth/cubit/auth_cubit.dart';
import 'package:tasky/constants/Screens.dart';
import 'package:tasky/constants/colors/colors.dart';
import 'package:tasky/constants/daimentions.dart';
import 'package:tasky/constants/strings.dart';
import 'package:tasky/data/model/auth_model/login_model.dart';
import 'package:tasky/presentation/custom_widgets/bit_text_widget.dart';
import 'package:tasky/presentation/custom_widgets/text_form_field_widget.dart';
import 'package:tasky/presentation/custom_widgets/wid_buttom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PhoneController? phone_controller;
  TextEditingController? password_controller;
  Daimentions? daimentions;

  LayerLink layerLink = LayerLink();
  bool _shouldFormat = true;
  bool _showFlagInInput = true;
  bool _showArrow = true;
  late List<CountrySelectorNavigator> navigators;
  late CountrySelectorNavigator selectorNavigator;
  GlobalKey<FormState>? form_key;
  @override
  void initState() {
    form_key = GlobalKey();
    password_controller = TextEditingController();
    daimentions = Daimentions(context: context);
    phone_controller =
        PhoneController(PhoneNumber(isoCode: IsoCode.EG, nsn: "1"));
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
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
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
          print("sss $state");
          if (state is SigninFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error_message),
              ),
            );
          } else if (state is SigninSuccess) {
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
                      height: daimentions!.height / 2.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImagesManegar.first_hero),
                        ),
                      ),
                    ),
                    big_text(
                      text: "Login",
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: daimentions!.Height20,
                    ),
                    Form(
                      key: form_key,
                      child: Column(
                        children: [
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ColorsManeger.light_grey))),
                            countrySelectorNavigator: selectorNavigator,
                          ),
                          SizedBox(
                            height: daimentions!.Height20,
                          ),
                          TextFormFieldWidget(
                            hint_text: "password",
                            secure: true,
                            text_edting_controller: password_controller,
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.remove_red_eye_rounded),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('field can not be empty');
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    state is SigninLoading
                        ? Center
                        (child: CircularProgressIndicator())
                        : wid_button_widget(
                            daimentions: daimentions,
                            text: "Sign In",
                            is_icon: false,
                            on_tap: () {
                              // print(
                              //     );

                              if (form_key!.currentState!.validate()) {
                                String phone =
                                    "+${phone_controller!.value!.countryCode.toString() + phone_controller!.value!.nsn.toString()}";
                                LoginModel login_model = LoginModel(
                                    phone: phone,
                                    password: password_controller!.text);
                                context
                                    .read<AuthCubit>()
                                    .login(login_model: login_model);
                              }
                            },
                          ),
                    SizedBox(
                      height: daimentions!.Height20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(children: [
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
                                  context, Screens.register_screen);
                            },
                          text: "Sign Up here",
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorsManeger.purble,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ])),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
