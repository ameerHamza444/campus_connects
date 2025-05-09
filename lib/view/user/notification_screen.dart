
import 'dart:developer';

import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/models/notification_model.dart';
import 'package:campus_connects/viewModel/notification_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({super.key});

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,

        /// todo: will work on them later
        title: Text("Notifications"),
      ),
      body: SafeArea(
        child: Expanded(
          child: FutureBuilder(
            future: Provider.of<NotificationViewModel>(context, listen: true).getAllNotificationCalling(context),
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
                    NotificationModel notificationModel = NotificationModel.fromDocumentSnapshot(documentsnapshot: data[index]
                    );
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Notification Details'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Title: ${notificationModel.notificationTitle}'),
                                    Text('Message: ${notificationModel.notificationName}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );

                        },
                        style: ListTileStyle.list,
                        tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        title: Text(
                          "${notificationModel.notificationTitle}",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                            "${notificationModel.notificationName}",
                            style: Theme.of(context).textTheme.titleSmall
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
