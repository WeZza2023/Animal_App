import 'package:animal_app/components/default_formfield.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/screens/home/home-screen.dart';
import 'package:animal_app/shared_prefs/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../components/custom_texts.dart';
import '../../constants/constant_sizes.dart';
import '../../enum/icons.dart';
import '../../generated/l10n.dart';
import '../signup/signup_screen.dart';
import 'login-cubit.dart';
import 'login-state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static String id = 'LoginScreen';
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LoginCubit>(context);

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async => {
        if (state is LoginSuccessState)
          {
            if (state.loginModel.success == true)
              {
                print(state.loginModel.message),
                print(state.loginModel.token),
                CacheHelper.saveData(
                  key: 'id',
                  value: state.loginModel.data!.id.toString(),
                ),
                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.token,
                ).then((value) async {
                  await cubit.getDeviceToken();
                  ApiConstants.userToken = state.loginModel.token;
                  ApiConstants.userId = state.loginModel.data!.id.toString();
                  Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                      content: S.of(context).loginSuccessfully,
                      color: Colors.green));
                })
              }
            else
              {
                print(state.loginModel.message),
              }
          }
        else if (state is LoginErrorState)
          {
            ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                content: S.of(context).loginError, color: Colors.red))
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
                  BodyExtraLargeText(
                    S.of(context).login,
                    weight: FontWeight.bold,
                    color: Colors.black,
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
                  state is LoginLoadingState
                      ? const CircularProgressIndicator(
                          color: KDefaultColor,
                        ).bP25
                      : defaultTextButton(
                          width: AppSizes.getScreenWidth(context) / 1.3,
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
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
                          textColor: KMaintextColor),
                      SizedBox(
                        width: AppSizes.getScreenWidth(context) * 0.1,
                      ),
                      defaultTextButton(
                          icon: ThemeImageIcon.google,
                          width: AppSizes.getScreenWidth(context) * 0.3,
                          color: const Color(0xffF1F5F9),
                          function: () {},
                          text: S.of(context).google,
                          textColor: KMaintextColor),
                    ],
                  ).bP16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyMediumText(S.of(context).dontHaveAccount),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SignupScreen.id);
                          },
                          child: BodyMediumText(
                            isUnderlined: true,
                            S.of(context).createAccount,
                            color: KDefaultColor,
                            weight: FontWeight.bold,
                          )),
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
