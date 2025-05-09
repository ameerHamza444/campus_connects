import 'package:campus_connects/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:campus_connects/constants/app_export.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  final ValueNotifier<bool> _obscureConfirmPassword = ValueNotifier<bool>(true);

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();

  FocusNode lastNameFocusNode = FocusNode();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

  FocusNode buttonFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    buttonFocusNode.dispose();
    _obscurePassword.dispose();
    _obscureConfirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).size;
    final authViewModel = Provider.of<AuthViewModel>(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: mediaQueryData.width,
          height: mediaQueryData.height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: getPadding(left: 20, top: 130, right: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: firstNameController,
                    focusNode: firstNameFocusNode,
                    margin: getMargin(left: 7, top: 21),
                    contentPadding: getPadding(left: 16, top: 25, right: 16, bottom: 18),
                    hintText: "First name",
                    autofocus: false,
                    fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    validator: RequiredValidator(errorText: "Required *").call,
                    onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
                  ),
                  CustomTextFormField(
                    controller: lastNameController,
                    focusNode: lastNameFocusNode,
                    margin: getMargin(left: 7, top: 21),
                    contentPadding: getPadding(left: 16, top: 25, right: 16, bottom: 18),
                    hintText: "Last name",
                    autofocus: false,
                    fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    validator: RequiredValidator(errorText: "Required *").call,
                    onSubmitField: (val) => Constants.fieldFocusChange(context, lastNameFocusNode, emailFocusNode),
                  ),
                  CustomTextFormField(
                      controller: emailController,
                      margin: getMargin(left: 7, top: 21),
                      hintText: "Enter email",
                      focusNode: emailFocusNode,
                      autofocus: false,
                      fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                      textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                      textInputType: TextInputType.emailAddress,
                      onSubmitField: (val) => Constants.fieldFocusChange(context, emailFocusNode, passwordFocusNode),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "Required *"),
                          EmailValidator(errorText: "Not a Valid Email"),
                        ],
                      ).call,
                      contentPadding: getPadding(left: 16, top: 25, right: 16, bottom: 18)),
                  ValueListenableBuilder(
                    valueListenable: _obscurePassword,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return CustomTextFormField(
                        controller: passwordController,
                        margin: getMargin(left: 7, top: 21),
                        hintText: "Password",
                        focusNode: passwordFocusNode,
                        autofocus: false,
                        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                        textInputType: TextInputType.visiblePassword,
                        obscureText: _obscurePassword.value,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required *";
                          } else if (val.length < 6) {
                            return "Should be At least 6 characters.";
                          } else if (val.length > 15) {
                            return "Should not be more than 15 characters.";
                          } else {
                            return null;
                          }
                        },
                        onSubmitField: (val) => Constants.fieldFocusChange(context, passwordFocusNode, buttonFocusNode),
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
                        contentPadding: getPadding(left: 16, top: 25, right: 16, bottom: 18),
                      );
                    },
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: authViewModel.isRegister == true
                        ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                        : CustomElevatedButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authViewModel.registerUser(
                            context,
                            username: "${firstNameController.text} ${lastNameController.text}",
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        } else {
                          Constants.toastMessage("Please enter the valid fields");
                        }
                      },
                      text: "Register",
                      focusNode: buttonFocusNode,
                      buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      buttonTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: ColorUtils().whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.loginScreen);
                    },
                    child: Padding(
                      padding: getPadding(top: 42, bottom: 5),
                      child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Already a member? ",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "Login Now",
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          textAlign: TextAlign.left),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
