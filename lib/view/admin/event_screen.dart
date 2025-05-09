import 'dart:developer';

import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/models/event_model.dart';
import 'package:campus_connects/viewModel/event_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController eventTitleController = TextEditingController();

  FocusNode eventTitleFocusNode = FocusNode();
  FocusNode addButtonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<EventViewModel>(context, listen: false).clearDateTime();
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
                controller: eventTitleController,
                focusNode: eventTitleFocusNode,
                margin: getMargin(left: 7, top: 21),
                contentPadding:
                    getPadding(left: 16, top: 25, right: 16, bottom: 18),
                hintText: "Event Title",
                autofocus: false,
                fillColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.2),
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                validator: RequiredValidator(errorText: "Required *").call,
                //  onSubmitField: (val) => Constants.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Consumer<EventViewModel>(
                    builder: (context, consumer, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        consumer.selectedDate == null
                            ? 'No date selected'
                            : 'Selected Date: ${DateFormat('yyyy MMM dd').format(consumer.selectedDate!)}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          consumer.pickDate(context);
                        },
                        child: const Text('Pick Date'),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                height: mediaQueryData.height * 0.075,
                width: mediaQueryData.width * 0.7,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<EventViewModel>(context, listen: false)
                        .createEventCalling(
                      context,
                      eventTitle: eventTitleController.text,
                      eventDate: Provider.of<EventViewModel>(context, listen: false).selectedDate,
                    );
                  } else {
                    Constants.toastMessage("Please enter the valid fields");
                  }
                },
                text: "ADD Event",
                focusNode: addButtonFocusNode,
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                buttonTextStyle:
                    Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: ColorUtils().whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<EventViewModel>(context, listen: true).getAllEventsCallingForAdmin(context),
                  builder: (context, snapshot) {
                    log("data snapshot: ${snapshot.data}");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }
                    // Handle errors
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    // Ensure data is not null
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(
                        child: Text(
                          'No data available',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      );
                    }
                    // Access the documents from the snapshot
                    var data = (snapshot.data as QuerySnapshot).docs;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          EventModel notificationModel = EventModel.fromDocumentSnapshot(documentsnapshot: data[index]
                          );
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              style: ListTileStyle.list,
                              tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              title: Text(
                                "${notificationModel.eventTitle}",
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                  DateFormat('yyyy MMM dd').format(notificationModel.eventDate!),
                                  style: Theme.of(context).textTheme.titleSmall
                              ),
                              trailing: SizedBox(
                                width: mediaQueryData.width * 0.07,
                                height: mediaQueryData.height,
                                child: IconButton(
                                  onPressed: () {
                                    //
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
