

import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/constants/utils/color_utils.dart';
import 'package:campus_connects/constants/utils/size_utils.dart';
import 'package:campus_connects/viewModel/clubnactivity_view_model.dart';
import 'package:campus_connects/widgets/custom_elevated_button.dart';
import 'package:campus_connects/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ClubnActivitySignup extends StatefulWidget {
  const ClubnActivitySignup({super.key});

  @override
  State<ClubnActivitySignup> createState() => _ClubnActivitySignupState();
}

class _ClubnActivitySignupState extends State<ClubnActivitySignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController clubNactivityController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode clubNactivityFocusNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: nameController,
                    focusNode: nameFocusNode,
                    margin: getMargin(left: 7, top: 21),
                    contentPadding:
                    getPadding(left: 16, top: 25, right: 16, bottom: 18),
                    hintText: "Name",
                    autofocus: false,
                    fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    validator: RequiredValidator(errorText: "Required *").call,
                    // onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
                  ),
                  CustomTextFormField(
                    controller: clubNactivityController,
                    focusNode: clubNactivityFocusNode,
                    margin: getMargin(left: 7, top: 21),
                    contentPadding:
                    getPadding(left: 16, top: 25, right: 16, bottom: 18),
                    hintText: "Club & Activity",
                    autofocus: false,
                    fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    validator: RequiredValidator(errorText: "Required *").call,
                    // onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
                  ),
                  SizedBox(height: 10,),
                  CustomElevatedButton(
                    height: mediaQueryData.height * 0.075,
                    width: mediaQueryData.width * 0.7,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<ClubnactivityViewModel>(context, listen: false).createClubnactitvityCalling(context,name: nameController.text, clubnactivity: clubNactivityController.text,);
                      } else {
                        Constants.toastMessage("Please enter the valid fields");
                      }
                      // Provider.of<AnnouncementViewModel>(context, listen: false).addToList(
                      //     announcementMsgController.text, departmentController.text);
                    },
                    text: "Enroll now",
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
                ],
              ),
            ),
          )),
    );
  }
}
