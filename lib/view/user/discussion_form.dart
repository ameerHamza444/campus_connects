import 'package:campus_connects/viewModel/discussion_form_view_m.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/app_export.dart';

class DiscussionFormScreen extends StatefulWidget {
  const DiscussionFormScreen({super.key});

  @override
  State<DiscussionFormScreen> createState() => _DiscussionFormScreenState();
}

class _DiscussionFormScreenState extends State<DiscussionFormScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: Provider.of<DiscussionFormViewModel>(context,
                          listen: true)
                      .messageStream,
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (asyncSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${asyncSnapshot.error}'));
                    }
                    final messages = asyncSnapshot.data ?? [];
                    final currentUserId =
                        FirebaseAuth.instance.currentUser?.uid;

                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isCurrentUser = message.userID == currentUserId;

                        return Align(
                          alignment: isCurrentUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: mediaQuery.width * 0.5,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: isCurrentUser
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.primary,
                              borderRadius:  isCurrentUser
                                  ?  const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ) : const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.message!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    DateFormat('HH:mm')
                                        .format(message.dateTime!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: CustomTextFormField(
                        controller: messageController,
                        hintText: "Send Message..",
                      )),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () async {
                          final message = messageController.text.trim();
                          if (message.isNotEmpty) {
                            final viewModel =
                                Provider.of<DiscussionFormViewModel>(context,
                                    listen: false);
                            final result = await viewModel.sendMessage(message);
                            if (result == "Success") {
                              messageController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Failed to send message")),
                              );
                            }
                          }
                        },
                        icon: Icon(
                          Icons.send,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
