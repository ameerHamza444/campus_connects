

import 'dart:developer';

import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/models/announcements_management_model.dart';
import 'package:campus_connects/view/user/notification_screen.dart';
import 'package:campus_connects/viewModel/announcement_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text("Announcements"),
        /// todo: will work on them later
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.notifyScreen);
            },
            icon: Icon(
              Icons.notifications_active,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<AnnouncementViewModel>(context, listen: true).getAllAnnouncementsCalling(context),
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
                  AnnouncementsManagementModel announcementModel = AnnouncementsManagementModel.fromDocumentSnapshot(documentsnapshot: data[index]
                  );
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Announcement Details'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Title: ${announcementModel.announcementtitle}'),
                                  Text('Department: ${announcementModel.departmentName}'),
                                  Text('Announcement: ${announcementModel.announcementmsg}'),
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
                        "${announcementModel.departmentName}",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                          "${announcementModel.announcementmsg}",
                          style: Theme.of(context).textTheme.titleSmall
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      )
    );
  }
}
