

import 'dart:developer';

import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/models/clubnactitvity_model.dart';
import 'package:campus_connects/viewModel/clubnactivity_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClubnactivityScreen extends StatefulWidget {
  const ClubnactivityScreen({super.key});

  @override
  State<ClubnactivityScreen> createState() => _ClubnactivityScreenState();
}

class _ClubnactivityScreenState extends State<ClubnactivityScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,

    /// todo: will work on them later
    title: Text("Club & Act.. Participants"),
    ),
      body: Expanded(
        child: FutureBuilder(
          future: Provider.of<ClubnactivityViewModel>(context, listen: true).getAllClubnactitvityCalling(context),
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
                  ClubnactitvityModel clubnactitvityModel = ClubnactitvityModel.fromDocumentSnapshot(documentsnapshot: data[index]
                  );
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      style: ListTileStyle.list,
                      tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      title: Text(
                        "${clubnactitvityModel.name}",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                          "${clubnactitvityModel.clubNactivity}",
                          style: Theme.of(context).textTheme.titleSmall
                      ),
                      trailing: SizedBox(
                        width: mediaQueryData.width * 0.07,
                        height: mediaQueryData.height,
                        child: IconButton(
                          onPressed: () {
                            Provider.of<ClubnactivityViewModel>(context, listen: false).deleteClubnactitvityCalling(
                              context,
                              id: clubnactitvityModel.id,
                            );
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
    );
  }
}
