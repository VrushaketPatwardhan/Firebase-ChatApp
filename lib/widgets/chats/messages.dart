import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './message_bubble.dart';

class Messages extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    print(user.uid);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy(
              "createdAt",
              descending: true,
            )
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatdocs = chatSnapshot.data.docs;

          return ListView.builder(
              reverse: true,
              itemCount: chatdocs.length,
              itemBuilder: (ctx, index) {
                return MessageBubble(
                  chatdocs[index]['text'],
                  user.uid == chatdocs[index]['userId'],
                  key: ValueKey(index),
                );
              });
        });
  }
}
