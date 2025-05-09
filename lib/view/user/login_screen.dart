
import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/viewModel/auth_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

  FocusNode buttonFocusNode = FocusNode();

  //final LoginModel loginModel = LoginModel();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    buttonFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    final authViewModel = Provider.of<AuthViewModel>(context);

    //final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              text: "Let's ",
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
                              children: [
                                TextSpan(
                                  text: "Sign In",
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        children: [
                          /// todo: email
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 6, bottom: 10),
                            child: CustomTextFormField(
                              controller: emailController,
                              focusNode: emailFocusNode,
                              autofocus: false,
                              hintText: "Email",
                              fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                              prefix: Container(
                                margin: const EdgeInsets.fromLTRB(12, 16, 11, 16),
                                child: Icon(Icons.email_outlined,
                                  color: Theme.of(context).primaryIconTheme.color,
                                ),
                                // child: CustomImageView(
                                //   imagePath: ImageConstant.imgPersonLogo,
                                //   height: 20,
                                //   width: 20,
                                // ),
                              ),
                              prefixConstraints: const BoxConstraints(maxHeight: 52),
                              onSubmitField: (val) => Constants.fieldFocusChange(context, emailFocusNode, passwordFocusNode),
                            ),
                          ),

                          /// todo: password
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 6, bottom: 10, top: 10),
                            child: ValueListenableBuilder(
                              valueListenable: _obscurePassword,
                              builder: (BuildContext context, bool value, Widget? child) {
                                return CustomTextFormField(
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  autofocus: false,
                                  hintText: "Password",
                                  fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.visiblePassword,
                                  prefix: Container(
                                    margin: const EdgeInsets.fromLTRB(12, 16, 11, 16),
                                    child: Icon(Icons.lock_outline,
                                      color: Theme.of(context).primaryIconTheme.color,
                                    ),
                                    // child: CustomImageView(
                                    //   imagePath: ImageConstant.imgPassLogo,
                                    //   height: 20,
                                    //   width: 20,
                                    // ),
                                  ),
                                  prefixConstraints: const BoxConstraints(maxHeight: 52),
                                  suffix: IconButton(
                                    onPressed: () {
                                      _obscurePassword.value = !_obscurePassword.value;
                                    },
                                    icon: _obscurePassword.value
                                        ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: Theme.of(context).primaryIconTheme.color,
                                    )
                                        : Icon(
                                      Icons.visibility_outlined,
                                      color: Theme.of(context).primaryIconTheme.color,
                                    ),
                                  ),
                                  suffixConstraints: const BoxConstraints(maxHeight: 52),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required *";
                                    } else if (value.length < 6) {
                                      return "Should be At least 6 characters.";
                                    } else if (value.length > 15) {
                                      return "Should not be more than 15 characters.";
                                    } else {
                                      return null;
                                    }
                                  },
                                  obscureText: _obscurePassword.value,
                                  onSubmitField: (val) => Constants.fieldFocusChange(context, passwordFocusNode, buttonFocusNode),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      /// todo: button
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: mediaQuery.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            child: authViewModel.isRegister == true
                                ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                                : CustomElevatedButton(
                              width: mediaQuery.width * 0.5,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  authViewModel.loginUser(
                                    context,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                } else {
                                  Constants.toastMessage("Please enter the valid fields");
                                }
                              },
                              text: "Sign in",
                              focusNode: buttonFocusNode,
                              buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              buttonTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: ColorUtils().whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      // Expanded(
                      //   flex: 1,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       const Expanded(
                      //         flex: 4,
                      //         child: Divider(),
                      //       ),
                      //       Expanded(
                      //         child: Text(
                      //           textAlign: TextAlign.center,
                      //           "Or",
                      //           style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                      //         ),
                      //       ),
                      //       const Expanded(
                      //         flex: 4,
                      //         child: Divider(),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //const Expanded(child: SizedBox()),
                      // Expanded(
                      //   flex: 1,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: CustomElevatedButton(
                      //           height: mediaQuery.height * 0.08,
                      //           width: mediaQuery.width * 0.5,
                      //           text: "",
                      //           buttonStyle: ElevatedButton.styleFrom(
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(20),
                      //             ),
                      //           ),
                      //           extraSpace: const SizedBox(width: 10),
                      //           leftIcon: CustomImageView(
                      //             imagePath: ImageConstant.imgGoogleIcon,
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(width: 10),
                      //       Expanded(
                      //         flex: 1,
                      //         child: CustomElevatedButton(
                      //           height: mediaQuery.height * 0.08,
                      //           width: mediaQuery.width * 0.5,
                      //           text: "",
                      //           buttonStyle: ElevatedButton.styleFrom(
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(20),
                      //             ),
                      //           ),
                      //           extraSpace: const SizedBox(width: 10),
                      //           leftIcon: CustomImageView(
                      //             imagePath: ImageConstant.imgFacebookIcon,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //const Expanded(child: SizedBox()),
                      // Expanded(
                      //   flex: 1,
                      //   child: Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: RichText(
                      //         text: TextSpan(
                      //           text: "Don't have an account? ",
                      //           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //           children: [
                      //             TextSpan(
                      //               text: "Register",
                      //               style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      //                 color: Theme.of(context).colorScheme.primary,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //               recognizer: TapGestureRecognizer()
                      //                 ..onTap = () {
                      //                     Navigator.pushNamed(context, AppRoutes.registerScreen);
                      //                 },
                      //             ),
                      //           ],
                      //         ),
                      //         textAlign: TextAlign.left),
                      //   ),
                      // ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

