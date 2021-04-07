import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/FdQ8QByF9frpLXCCKCEe/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(10),
                    child: Text(documents[index]['text']),
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/FdQ8QByF9frpLXCCKCEe/messages')
              .add({'text': 'this was added'});
        },
      ),
    );
  }
}
