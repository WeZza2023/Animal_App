import 'package:animal_app/components/default_formfield.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/models/country_code_model.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/screens/home/home-screen.dart';
import 'package:animal_app/shared_prefs/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/link.dart';

import '../../components/components.dart';
import '../../components/custom_texts.dart';
import '../../constants/constant_sizes.dart';
import '../../enum/icons.dart';
import '../../generated/l10n.dart';
import 'signup-cubit.dart';
import 'signup-state.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  static String id = 'SignupScreen';
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SignupCubit>(context);

    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) => {
        if (state is SignupSuccessState)
          {
            if (state.registerModel.success == true)
              {
                print(state.registerModel.message),
                print(state.registerModel.token),
                CacheHelper.saveData(
                  key: 'id',
                  value: state.registerModel.data!.id.toString(),
                ),
                CacheHelper.saveData(
                  key: 'token',
                  value: state.registerModel.token,
                ).then((value) async {
                  await cubit.getDeviceToken();
                  ApiConstants.userToken = state.registerModel.token;
                  ApiConstants.userId = state.registerModel.data!.id.toString();
                }),
              }
            else
              {
                print(state.registerModel.message),
              }
          }
        else if (state is SignupErrorState)
          {
            ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                content: S.of(context).signupError, color: Colors.red))
          },
        if (state is VerificationSuccessState)
          {
            print(state.verifyModel.deep_link),
            showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  child: AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          BodyMediumText(S.of(context).step1).bP8,
                          BodyMediumText(S.of(context).step2).bP8,
                          BodyMediumText(S.of(context).step3).bP8,
                          BodyMediumText(S.of(context).step4).bP8,
                          BodyMediumText(S.of(context).step5).bP8,
                          Link(
                            uri: Uri.parse(state.verifyModel.link),
                            builder: (context, followLink) => InkWell(
                                onTap: () {
                                  cubit.openVerifyLink(
                                      Uri.parse(state.verifyModel.link));
                                },
                                child: BodyMediumText(
                                  state.verifyModel.deep_link,
                                  color: Colors.blue,
                                  isUnderlined: true,
                                )),
                          )
                        ],
                      ),
                    ),
                    title: Center(child: BodyLargeText(S.of(context).logout)),
                    actions: [
                      defaultTextButton(
                        text: S.of(context).done,
                        function: () {
                          // Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                              AppSnackBar(
                                  content: S.of(context).loginSuccessfully,
                                  color: Colors.green));
                        },
                      )
                    ],
                  ),
                );
              },
            )
          }
        else if (state is VerificationErrorState)
          {
            ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                content: S.of(context).processError, color: Colors.red))
          },
        if (state is GetDeviceTokenState)
          {cubit.storeToken(token: ApiConstants.deviceToken)}
      },
      builder: (context, state) => Scaffold(
        backgroundColor: KBackgroundColor,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: AppSizes.getScreenHeight(context) * 0.5,
              width: AppSizes.getScreenWidth(context),
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.fill,
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: BodyExtraLargeText(
                      S.of(context).createAccount,
                      weight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  DefaultFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).pleaseEnterYourName;
                      }
                      return null;
                    },
                    label: S.of(context).name,
                  ).bP8,
                  DefaultFormField(
                    suffix: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          useSafeArea: true,
                          enableDrag: true,
                          showDragHandle: true,
                          context: context,
                          builder: (context) => CountryCodesSheet(
                            context: context,
                          ),
                        );
                      },
                      child: BodyMediumText(
                        '${cubit.countryCode}',
                        color: KDefaultColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).pleaseEnterYourPhone;
                      }
                      return null;
                    },
                    label: S.of(context).phone,
                  ).bP8,
                  DefaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).pleaseEnterYourEmail;
                      }
                      return null;
                    },
                    label: S.of(context).email,
                  ).bP8,
                  DefaultFormField(
                    controller: passwordController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).pleaseEnterYourPassword;
                      }
                      return null;
                    },
                    label: S.of(context).password,
                    isPassword: cubit.isPass,
                    suffix: IconButton(
                        icon: Icon(cubit.passIcon),
                        onPressed: () {
                          cubit.isPassShow();
                        }),
                  ).bP25,
                  state is SignupLoadingState ||
                          state is VerificationLoadingState
                      ? const CircularProgressIndicator(
                          color: KDefaultColor,
                        ).bP25
                      : defaultTextButton(
                          width: AppSizes.getScreenWidth(context) / 1.3,
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              if (cubit.countryCode != "-  -") {
                                await cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  AppSnackBar(
                                      content:
                                          S.of(context).pleaseSelectCountryCode,
                                      color: Colors.red),
                                );
                              }
                            }
                          },
                          text: S.of(context).login,
                        ).bP25,
                  BodyMediumText(S.of(context).continueWith).bP16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultTextButton(
                        icon: ThemeImageIcon.facebook,
                        width: AppSizes.getScreenWidth(context) * 0.3,
                        color: const Color(0xffF1F5F9),
                        function: () {},
                        text: S.of(context).facebook,
                        textColor: KMaintextColor,
                      ),
                      SizedBox(
                        width: AppSizes.getScreenWidth(context) * 0.1,
                      ),
                      defaultTextButton(
                        icon: ThemeImageIcon.google,
                        width: AppSizes.getScreenWidth(context) * 0.3,
                        color: const Color(0xffF1F5F9),
                        function: () {},
                        text: S.of(context).google,
                        textColor: KMaintextColor,
                      ),
                    ],
                  ).bP16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyMediumText(S.of(context).doYouHaveAccount),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: BodyMediumText(
                          S.of(context).login,
                          color: KDefaultColor,
                          weight: FontWeight.bold,
                          isUnderlined: true,
                        ),
                      ),
                    ],
                  ).bP8,
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
